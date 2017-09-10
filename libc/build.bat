@echo off
SET PATH=
cd libc
REM List of object files to add to the library
set libOBJ= -+conio.obj  ^
    	    -+ctype.obj  ^
	    -+locale.obj ^
	    -+stdio.obj  ^
	    -+string.obj ^
	    -+assert.obj ^
	    -+bios.obj   ^
	    -+signal.obj ^
	    -+fat.obj	 ^
	    -+times.obj


REM List of object files to add to the test kernel
set testOBJ= __kernel.obj ^
	     __time.obj   ^
	     __fat.obj    ^
	     __stdio.obj  ^
	     __signal.obj ^
	     __stddef.obj ^
	     __string.obj ^
	     __ctype.obj  ^
	     __conio.obj


REM Compile library source code
:compileLibrary
    IF "%~1" == "debug" (
	REM Compile all source assembly files with debug options
	..\tools\ML.EXE /omf /c /Fl /Zd /Sa /Zi /I include\inc source\*.asm

	REM Clean all produced lst files
	move /Y *.lst source\lst > nul
    ) ELSE (
	REM Compile all source assembly files
	..\tools\ML.EXE /omf /c /I include\inc source\*.asm
    )

    REM Link all object files to libary
    ..\tools\LIB.EXE /BATCH /NOLOGO libc %libOBJ%, libc.lst, libc.lib

    REM Clean all produced obj files
    move /Y *.obj source\obj > nul

    REM Clean produced bak file
    del libc.bak > nul
REM compileLibrary


REM Compile test case source code
:compileTestKernel
    IF "%~1" == "debug" (
	REM Compile all source C files with debug options
	..\tools\CL.EXE /nologo /AT /G2 /Gs /Gx /c /Fl /Zi /Zl /I include debug\*.c

	rem Clean all produced cod files
	move /Y *.cod debug\cod > nul
    ) ELSE (
	REM Compile all source c files
	..\tools\CL.EXE /AT /G2 /Gs /Gx /c /I include debug\*.c
    )

    rem Link together all test cases and libary
    ..\tools\LINK.EXE /T /NOD  %testOBJ%, debug\kernel.bin, nul, libc.lib, nul

    rem Clean all produced obj files
    move /Y *.obj debug\obj > nul
REM compileTestKernel


