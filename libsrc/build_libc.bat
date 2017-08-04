@echo off

rem Set the output libary path
set libpath=.\..\lib

rem Set the VC152 path with build tools
set vcpath=.\..\..\Tools\VC152

rem Compile all source assembly files 
%vcpath%\ML.EXE /omf /c src\*.asm

rem Link all object files to libary
%vcpath%\LIB.EXE %libpath%\libc -+conio.obj -+ctype.obj -+stdio.obj -+string.obj, %libpath%\libc.lst, %libpath%\libc.lib

rem Move all object files into the bin dir
move /Y *.obj bin > nul

