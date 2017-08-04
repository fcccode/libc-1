@echo off

rem Build the bootloader
.\..\..\Tools\nasm.exe -f bin src\bootload.asm -o bin\bootload.bin 