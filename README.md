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
While working on the development of this project I have sumbled uppon many resources 
that would intrest any `Hobby OS` developer and in fact be very helpfull. I highly 
recomend to use [OSDev] while working on this topic of operating system development,
for it has an extensive ammount of help. On the other hand, to build this project
you will need the following programs, [NASM] and [MASM] which are used for the
bootloader, C library and kernel, [imdisk] and [dd] to write the os system files 
to a virutal floppy disk and lastly [QEMU] image emulator.

[QEMU]:   http://www.qemu.org/
[imdisk]: http://www.ltr-data.se/opencode.html/
[dd]:	  http://uranus.chrysocome.net/linux/rawwrite/dd-old.htm
[OSDev]:  http://wiki.osdev.org/Main_Page
[MASM]:   http://www.masm32.com/download.htm
[NASM]:   http://www.nasm.us/index.php