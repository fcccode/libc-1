@echo off

rem Copy and replace the the old image with the formatted floppy image1
copy /Y bin\formatted_floppy.img bin\built_floppy.img > NUL

rem Make a virtual disk image of our floppy disk
.\..\..\Tools\imdisk -a -f bin\built_floppy.img -s 1440K -m B:

rem Copy our kernel to the floppy disk
copy .\..\kernel\bin\kernel.bin  B:

rem Unmount the floppy disk
.\..\..\Tools\imdisk -D -m B:

rem Write the bootloader to the floppy disk
.\..\..\Tools\dd if=.\..\bootload\bin\bootload.bin of=bin\built_floppy.img bs=512

rem Run the built floppy disk image with qemu
.\..\..\Tools\qemu\qemu -fda bin\built_floppy.img