@echo off
SET PATH=.\..\..\Tools\VC152\

rem Set the output libary path
set libpath=.\..\lib

rem Compile all source assembly files
ML.EXE /omf /c src\*.asm

rem Link all object files to libary
LIB.EXE %libpath%\libc -+conio.obj -+ctype.obj -+stdio.obj -+string.obj -+assert.obj -+bios.obj, %libpath%\libc.lst, %libpath%\libc.lib

if "%1"=="debug" goto debug
goto done

:debug
rem Compile all C files
CL.EXE /AT /G2 /Gs /Gx /c /Zl /I ".\..\libsrc\include" tests\*.c

rem Compile all assembly files
ML.EXE /omf /c  tests\*.asm

rem Link together all files and include the libary
LINK.EXE /T /NOD kernel.obj ktest.obj __string.obj __ctype.obj __conio.obj, kernel.bin, nul, %libpath%\libc.lib, nul

rem Move kernel image into bin dir
move /Y *.bin .\..\kernel\bin > nul

:done
rem Move object files into bin dir
move /Y *.obj bin > nul
pause