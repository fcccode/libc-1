@echo off
set var=C:\Users\jjrie\Desktop\SuccOS Dev\inc
REM make16_vs2012.bat
REM Updated 2/24/2013, for Visual Studio 2012
REM By: Kip R. Irvine

REM Assembles and links the current 16-bit ASM program.
REM Assumes you have installed Microsoft Visual Studio 2012
REM or Visual Studio 2012 Express.
REM
REM Command-line options (unless otherwise noted, they are case-sensitive):
REM
REM -Cp     Enforce case-sensitivity for all identifiers
REM -Zi		Include source code line information for debugging
REM -Fl		Generate a listing file
REM /CODEVIEW   Generate CodeView debugging information (linker)
REM %1.asm      The name of the source file, passed on the command line
setlocal
set INCLUDE="C:\Users\jjrie\Desktop\SuccOS Dev\inc"
set LIB="C:\Users\jjrie\Desktop\SuccOS Dev\lib\"
set MASM="C:\Users\jjrie\Desktop\SuccOS Dev\tools\VC152\"
set PATH="C:\Users\jjrie\Desktop\SuccOS Dev\tools\VC152\";%PATH%
REM ************* The following lines can be customized:
REM **************************** End of customized lines

REM Invoke ML.EXE (the assembler):
ML /nologo /omf /c /Fl /Zi /I "%INCLUDE%" "string.asm"
if errorlevel 1 goto terminate

REM Run the 16-bit linker, modified for Visual Studio.Net:
LINK /T /NOD %1.obj, %1.bin, nul, %LIB%libc.lib, nul
if errorlevel 1 goto terminate

REM Display all files related to this program:
DIR %1.*

:terminate
endlocal

pause
