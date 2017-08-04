# SuccOS
SuccOS is a minimal 16 bit, real mode DOS like operating system written in both C and MASM!



## Features

* Supports only Windows currently, Linux is on the todo list.
* Extensive C library written in MASM and compatable with any 16 bit system.
* Clean and modular design, most features can be omitted when building.

### Current Library Features

This table summarizes the C library features:

| Header        | Description                       | Status        |
| :------------ | :-------------------------------- | ------------: |
<ctype.h>       | Character handling.               | Completed.
<stdio.h>       | Input/output.                     | WIP 
<string.h>      | String handling.                  | WIP
<conio.h>       | Date and time.                    | WIP


#### Footnotes
[ge](#footnotes)

> NOTE: Do not change the file directorys or ordering because it will screw up Visual Studio.

Programs used
--------------------------------------

- [NASM](http://www.nasm.us/index.php) -- `Assembler used for the Bootloader`
- [MASM](http://www.masm32.com/download.htm) -- `Assembler used for the C libary and Kernel`
- [QEMU](http://www.qemu.org/) -- `Virtural image emulator (can use virtural box insted)`
- [imdisk](http://www.ltr-data.se/opencode.html/) -- `Create virtural floppy disk images`
- [dd](http://uranus.chrysocome.net/linux/rawwrite/dd-old.htm) -- `Coppy bootloader into disk image`

