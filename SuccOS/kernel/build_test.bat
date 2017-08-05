@echo off
SET PATH=

rem Compile all C files
.\..\..\Tools\VC152\CL.EXE /AT /G2 /Gs /Gx /c /Zl test\*.c

rem Compile all assembly files
.\..\..\Tools\VC152\ML.EXE /omf /c test\*.asm 

rem Link together all files and include the libary
.\..\..\Tools\VC152\LINK.EXE /T /NOD kernel.obj ktest.obj conio_test.obj, kernel.bin, nul, .\..\lib\libc.lib, nul

rem Move object files into bin dir
move /Y *.obj bin > nul

rem Move kernel image into bin dir
move /Y *.bin bin > nul