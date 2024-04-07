%include "win32n.inc"

section .data

section .bss

    buf  resd 1
    argc resd 1
    argv resb 255

    lpBytesWritten  resd 1
    hSelfFile1      resd 1
    hSelfFile2      resd 1
    hHeap           resd 1
    lpFileSize      resd 1
    hReadBuf        resd 1
    nameBuf1        resd 1
    nameBuf2        resb 19

section .text

    global Start

    ;extern printf
    extern CreateFileA
    extern WriteFile
    extern SetFilePointer
    extern ReadFile
    extern CloseHandle
    extern __getmainargs
    ;extern WriteConsoleA
    ;extern GetStdHandle
    extern ExitProcess
    extern GetFileSize
    extern GetProcessHeap
    extern HeapAlloc
    extern HeapFree


    convert:
        dec edi
        xor edx, edx
        mov ecx, 10
        div ecx
        add dl, '0'
        mov [edi], dl
        test eax, eax
        jnz convert
        ret

    strlen:             ; eax: a string ending in 0
        push eax            ; cache eax

    .strloop:

        mov bl, byte [eax]
        cmp bl, 0
        je .strret          ; return len if bl == 0
        inc eax             ; else eax++
        jmp .strloop

    .strret:

        pop ebx             ; ebx = cached eax
        sub eax, ebx        ; eax -= ebx
        ret                 ; eax = len

    Start:
        mov esi, 0
        push 0
        push buf
        push argv
        push argc
        call __getmainargs
        add esp, 16         ; clear stack (4 * 4 arguments)

        mov edx, [argv]
        mov eax, dword [edx]
        mov dword [nameBuf1], eax


    Redo:
        
        call    GetProcessHeap                  ; get handle to apps heap
        mov     [hHeap], eax        


        rdtsc
        
        lea edi, [nameBuf2 + 18]

        mov byte [edi], 0x65
        dec edi
        mov byte [edi], 0x78
        dec edi
        mov byte [edi], 0x65
        dec edi
        mov byte [edi], 0x2E
        
        call convert 

        mov dword [nameBuf2], edi

        push    NULL
        push    NULL
        push    CREATE_ALWAYS
        push    NULL
        push    0
        push    FILE_READ_DATA|FILE_WRITE_DATA
        push    dword [nameBuf2]
        call    CreateFileA                     ; open the file
        add esp, 28                             ; clear stack
        mov     [hSelfFile2], eax   


    ;----------------------------------

        push    NULL
        push    NULL
        push    OPEN_EXISTING
        push    NULL
        push    0
        push    FILE_READ_DATA
        push    dword [nameBuf1]
        call    CreateFileA                     ; open the file
        add esp, 28                             ; clear stack
        mov     [hSelfFile1], eax   


        push    NULL
        push    eax
        call    GetFileSize                     ; size of file to read
        add esp, 8                              ; clear stack
        add     eax, 1
        mov     [lpFileSize], eax

        push    eax
        push    HEAP_ZERO_MEMORY
        push    dword [hHeap]
        call    HeapAlloc                       ; allocate memory
        add esp, 12                             ; clear stack
        mov     [hReadBuf], eax

        push    NULL
        push    lpBytesWritten
        push    dword [lpFileSize]
        push    dword [hReadBuf]
        push    dword [hSelfFile1]
        call    ReadFile                        ; read file1 into memory
        add esp, 20                             ; clear stack

        push    dword [hSelfFile1]
        call    CloseHandle                     ; close file
        add esp, 4                              ; clear stack

        push    NULL
        push    lpBytesWritten 
        push    dword [lpFileSize]
        push    dword [hReadBuf]
        push    dword [hSelfFile2]
        call    WriteFile                       ; write memory into file2
        add esp, 20                             ; clear stack

        push    dword [hSelfFile2]
        call    CloseHandle                     ; close file
        add esp, 4                              ; clear stack
        
        
        push    NULL
        push    hReadBuf
        call    HeapFree                        ; free the buffer memory
        add esp, 8                              ; clear stack
        
        inc esi
        cmp esi, 2
        jne Redo
        
        push 0
        call ExitProcess
