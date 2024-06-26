
# Self Replicating Assembly Program

[<img src="https://raw.githubusercontent.com/woodjooe/Self_Replicating_assembly_Malw/main/imgs/NasmLogo.png" width="200">](https://www.nasm.us/) [<img src="https://raw.githubusercontent.com/woodjooe/Self_Replicating_assembly_Malw/main/imgs/GoasmLogo.png" width="200">](http://www.godevtool.com/)


<br>

This is one of my attempts at learning the fundamentals of malware development, malware reverse engineering and assembly programing language on the windows OS.
<br>

### How to use :

We use nasm to assemble the code and link it using Golink: <br>
(kernel32.dll and Msvcrt.dll are Dynamic Link Libraries that include necessary Windows API functionalities for this program)

``` cmd
nasm -f win32 Self_Replicating.asm && golink /fo Self_Replicating.exe Self_Replicating.obj /console kernel32.dll Msvcrt.dll
```
<br>

Make sure to to install both nasm and goasm and add them to your PATH of course.
<br>

### Behaviour :

The ouput is an executable that creates 2 exact copies out of itself in the current folder each with a randomized name.
Try and run the output program but Windows defender will flag it. <br> 

But you can deactivate it to run the program.... Trust me bro :^)

<br>

This project is part of a bigger project in which this assembly code has been modified to limitlessly replicate on the host computer. (V1) <br>
These assembly code bytes are then encrypted and then added to a bigger C++ program that decrypts the malicious bytes on execution, coupled with a few classic AV sandbox evasion techniques.
<br>

### Demo :
I am not sure if publishing such malicious code is allowed and therefore will only publish this assembly code which is the 1st version (V0). <br>
But I will also publish a demo showcasing the functionality of the final code project (V1 and V2) that im still working on improving.

https://github.com/woodjooe/Self_Replicating_assembly_Malw/assets/97318624/c610cc04-eea3-4037-8439-5fa321222bb7

<br>

### Virus Total Detection Results :
Im also showing the detection result on VirusTotal. (on the left is the V1, on the right is the V2)<br>
<img src="https://raw.githubusercontent.com/woodjooe/Self_Replicating_assembly_Malw/main/imgs/VirusTotalResults.png">

### Notes :
* Building this project took quite some time, mostly researching assembly language and malware dev techniques.
* These ressources helped me out a lot ! Check them out !
- - https://0xpat.github.io/
Great tutorial explaining multiple AV bypass techniques with examples.
- - https://github.com/Apress/beginning-x64-assembly-programming/
Muliple assemble program samples to learn from.
- - https://github.com/malsearchs/Pure-Malware-Development
More MalDev ressources you can learn from.
