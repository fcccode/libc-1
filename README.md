# SuccOS
SuccOS is a minimal 16 bit, real mode DOS like operating system written in both C and MASM!

## Features

* Supports only Windows currently, Linux is on the todo list.
* Extensive C library written in MASM and compatable with any 16 bit system.
* Working Bootloader and kernel entry point.
* Library refrences work in both MASM and C, examples on the todo list.

### Current Library Features

This table summarizes the C library features:

| Header        | Description                       | Status        |
| :------------ | :-------------------------------- | :------------ |
<ctype.h>       | Character handling.               | Completed.
<stdio.h>       | Input/output.                     | WIP [[1]](#footnotes)
<string.h>      | String handling.                  | WIP
<conio.h>       | DOS like functions.               | WIP


#### Footnotes

> **[1]** Do not change the file directorys or ordering because it will screw up Visual Studio.

Programs used
--------------------------------------

- [NASM](http://www.nasm.us/index.php) -- `Assembler used for the Bootloader`
- [MASM](http://www.masm32.com/download.htm) -- `Assembler used for the C libary and Kernel`
- [QEMU](http://www.qemu.org/) -- `Virtural image emulator (can use virtural box insted)`
- [imdisk](http://www.ltr-data.se/opencode.html/) -- `Create virtural floppy disk images`
- [dd](http://uranus.chrysocome.net/linux/rawwrite/dd-old.htm) -- `Coppy bootloader into disk image`

