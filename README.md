# SuccOS
SuccOS is a minimal 16 bit, real mode DOS like operating system written in both C and MASM!

## Features
* Supports only Windows currently, Linux is on the todo list.
* Extensive C library written in MASM and compatable with any 16 bit system.
* Library refrences work in both MASM and C, examples on the todo list.
* Working Bootloader and kernel entry point.

### Current Library Features
This table summarizes the C library features:

| Header        | Description                       | Status        |
| :------------ | :-------------------------------- | :------------ |
<ctype.h>       | Character handling.               | Completed.
<stdio.h>       | Input/output.                     | WIP 
<string.h>      | String handling.                  | WIP
<conio.h>       | DOS like functions.               | WIP

## Download WIP
* [Version X.Y](https://github.com/SpookyVerkauferin/SuccOS/archive/master.zip)
* Other Versions

## Updates
* August 4th 2017: Its still early. Please kill me :)

## Installation 
1) Please run the imdisk installer in `Tools\imdiskinst_2.0.6.exe` to install the imdisk virtual floppy disk drivers. 
2) The rest should work by opening up the Visual Studio Solution and building with `Debug` and `x64` options.

## Resources
* [OSDev] Is a great website for any Hobby OS developer.
* [NASM] & [MASM] Which are used for the bootloader, C library and kernel.
* [imdisk] & [dd] To write the operating system files to a floppy image.
* [QEMU] Image emulator for testing the os.

[QEMU]:   http://www.qemu.org/
[imdisk]: http://www.ltr-data.se/opencode.html/
[dd]:	  http://uranus.chrysocome.net/linux/rawwrite/dd-old.htm
[OSDev]:  http://wiki.osdev.org/Main_Page
[MASM]:   http://www.masm32.com/download.htm
[NASM]:   http://www.nasm.us/index.php