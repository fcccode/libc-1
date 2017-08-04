@echo off
SET PATH=

rem Compile all C files
.\..\..\Tools\VC152\CL.EXE /AT /G2 /Gs /Gx /c /Zl *.c

rem Compile all assembly files
.\..\..\Tools\VC152\ML.EXE /omf /c *.asm 

rem Link together all files and include the libary
.\..\..\Tools\VC152\LINK.EXE /T /NOD kernel.obj kmain.obj, kernel.bin, nul, .\..\lib\libc.lib, nul
del *.obj
