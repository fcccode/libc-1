# <img src="Docs/succOS logoblue.png?raw=true" height=60/>
SuccOS is a minimal 16 bit, real mode DOS like operating system written in both C and MASM!

## <img src="Docs/Features & Goalsblue.png?raw=true" height=40/>
* [x] Working Bootloader and kernel entry point.
* [ ] Standard C library written in MASM and compatable with any 16 bit system.
* [x] Library refrences work in both MASM and C.
* [ ] Write test cases that work within [gcc](https://gcc.gnu.org/) and my 16 bit C library.
* [ ] Write tutorials on how to use the library within your own 16 bit system.
* [ ] Implement standard kernel features. 
* [ ] Building in cross platform environments.

## <img src="Docs/Current Library Featuresblue.png?raw=true" height=40/>
This table summarizes the C library features:

| Header        | Description                       | Status        | Test Cases
| :------------ | :-------------------------------- | :------------ | :---------
<assert.h>      | Verify statements.                | Completed.    | *NULL*
<ctype.h>       | Character handling.               | Completed.    | [__ctype.c](SuccOS/libsrc/tests/__ctype.c)  
<errno.h>       | Error Events.			                | WIP	          | 
<limits.h>      | Variable limits.		              | WIP	          |  
<signal.h>      | Handle signal events.		          | WIP	          |  
<stdio.h>       | Input/output.                     | WIP           |
<string.h>      | String handling.                  | Completed.    | [__string.c](SuccOS/libsrc/tests/__string.c)  
<conio.h>       | Low level I/O functions.          | WIP           |
<stdbool.h>     | Boolean statements.		            | Completed.    | *NULL*

## <img src="Docs/Downloadsblue.png?raw=true" height=40/>
* [Version 0.1.1](https://github.com/SpookyVerkauferin/SuccOS/archive/master.zip)
* [Version 0.1](https://github.com/SpookyVerkauferin/SuccOS-0.1) 

## <img src="Docs/Notable Updatesblue.png?raw=true" height=40/>
* August 11th 2017: Finished the *ctype* test case.
* August 10th 2017: Finished the *string* test case.
* August 9th 2017: Completed all standard *string.h* functions.
* August 7th 2017: Completed the standard *ctype.h* functions.
* August 6th 2017: Set up test case kernel, started on the *string* test cases.

## <img src="Docs/Installationblue.png?raw=true" height=40/>
1) Extract the `Tools.zip` to the current folder, build scripts depend on it's path.
2) Please run the imdisk installer in `Tools\imdiskinst_2.0.6.exe` to install the imdisk virtual floppy disk drivers. 
3) The rest should work by opening up the Visual Studio Solution and building with `Debug` and `x64` options.

## <img src="Docs/Resourcesblue.png?raw=true" height=40/>
* [OSDev] Is a great website for any Hobby OS developer.
* [NASM] & [MASM] Which are used for the bootloader, C library and kernel.
* [imdisk] & [dd] To write the operating system files to a floppy image.
* [QEMU] Image emulator for testing the os.

[QEMU]:   http://www.qemu.org/
[imdisk]: http://www.ltr-data.se/opencode.html/
[dd]:	    http://uranus.chrysocome.net/linux/rawwrite/dd-old.htm
[OSDev]:  http://wiki.osdev.org/Main_Page
[MASM]:   http://www.masm32.com/download.htm
[NASM]:   http://www.nasm.us/index.php
