@echo off

rem Set the output libary path
set libpath=.\..\lib



rem Compile all source assembly files 
ML.EXE /omf /c src\*.asm

rem Link all object files to libary
LIB.EXE %libpath%\libc -+conio.obj -+ctype.obj -+stdio.obj -+string.obj -+assert.obj, %libpath%\libc.lst, %libpath%\libc.lib

rem Move all object files into the bin dir
move /Y *.obj bin > nul

