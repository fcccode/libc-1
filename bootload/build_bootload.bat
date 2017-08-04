@echo off

rem Build the bootloader
.\..\..\Tools\nasm.exe -f bin bootload.asm -o bootload.bin 