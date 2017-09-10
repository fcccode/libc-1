@echo off
SET PATH=%PATH%;..\..\tools

REM Make a virtual disk image with a fat file system
imdisk -a -f floppy.img -s 1440K -m B: -p "/fs:fat /q /y"

REM Copy the kernel to the floppy disk
COPY ..\debug\kernel.bin B: > nul
COPY ..\debug\z.txt B: > nul
COPY ..\debug\s.txt B: > nul

REM Unmount the floppy disk
imdisk -D -m B:

REM Write the bootloader to the floppy disk
dd if=..\debug\boot\bootload.bin of=floppy.img bs=512

REM Run the built floppy disk image with bochs
start ..\..\tools\bochsrcm.bxrc

