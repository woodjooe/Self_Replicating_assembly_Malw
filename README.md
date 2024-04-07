
#   


#### Self Replicating Assembly Program


[![N|NAsm](https://raw.githubusercontent.com/woodjooe/Self_Replicating_assembly_Malw/main/imgs/NasmLogo.png)](https://www.nasm.us/) [![N|GoAsm](https://raw.githubusercontent.com/woodjooe/Self_Replicating_assembly_Malw/main/imgs/GoasmLogo.png)](http://www.godevtool.com/)



This is one of my attempts at learning the fundamentals of malware development, malware reverse engineering and assembly programing language.

We use nasm to assemble the code and link it using Golink:

``` cmd
nasm -f win32 Self_Replicating.asm && golink /fo Self_Replicating.exe Self_Replicating.obj /console kernel32.dll Msvcrt.dll
```

Make sure to to install both nasm and goasm and add them to your PATH of course.

The ouput is an executable that creates 2 exact copies out of itself in the current folder each with a randomized name.

Try and run the output program but Windows defender will flag it. But you can deactivate it to run the program.... Trust me bro :^)

###### This project is part of a bigger project in which, this assembly code has been modified to limitlessly replicate on the host computer. These assembly code bytes are then added to a bigger C++ program that encrypts the malicious bytes and and decrypts them on execution, coupled with a few classic AV sandbox evasion techniques.

###### I am not sure if publishing such code is allowed and therefore will only publish this assembly code. But I will also publish a demo showcasing the functionality of the final code project that im still working on improving.

###### Im also showing the detection result on VirusTotal.

[![N|VirusTot](https://raw.githubusercontent.com/woodjooe/Self_Replicating_assembly_Malw/main/imgs/VirusTotalResults.png)](https://www.virustotal.com)

###Notes :
* Building this project took quite some time, mostly researching assembly language and malware dev techniques.
* These ressources helped me out a lot ! Check them out !
- - https://0xpat.github.io/
Great tutorial explaining multiple AV bypass techniques with examples.


- - https://github.com/Apress/beginning-x64-assembly-programming/
Muliple assemble program samples to learn from.


- - https://github.com/malsearchs/Pure-Malware-Development
More MalDev ressources you can learn from.
