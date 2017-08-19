@echo off
SET PATH=.\..\Tools\VC152\;.\..\Tools\;.\..\Tools\qemu\

:build_library
    rem Compile all source assembly files
    ML /omf /c /I "..\inc" src\*.asm

    rem Link all object files to libary
    LIB ..\lib\libc -+conio.obj -+ctype.obj -+stdio.obj -+string.obj -+assert.obj -+bios.obj, ..\lib\libc.lst, ..\lib\libc.lib

:build_tests
    rem Compile all C files
    CL /AT /G2 /Gs /Gx /c /Zl /I "..\h" tests\*.c

    rem Compile all assembly files
    ML /omf /c  tests\*.asm

    rem Link together all files and include the libary
    LINK /T /NOD kernel.obj __kernel.obj __string.obj __ctype.obj __conio.obj, bin\kernel.bin, nul, ..\lib\libc.lib, nul

    move /Y *.obj bin\obj > nul

:build_floppy
    rem Copy and replace the the old image with the formatted floppy image1
    copy /Y bin\formatted_floppy.img bin\built_floppy.img > NUL

    rem Make a virtual disk image of our floppy disk
    imdisk -a -f bin\built_floppy.img -s 1440K -m B:

    rem Copy our kernel to the floppy disk
    copy bin\kernel.bin  B:

    rem Unmount the floppy disk
    imdisk -D -m B:

    rem Write the bootloader to the floppy disk
    dd if=bin\bootload.bin of=bin\built_floppy.img bs=512

    rem Run the built floppy disk image with qemu
    qemu -fda bin\built_floppy.img