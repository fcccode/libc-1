@echo off
REM ---------------------------------------------------------------
SET TOOLS=C:\Users\Admin\Desktop\libc\tools\
SET INCLUDE=C:\Users\Admin\Desktop\libc\include;%INCLUDE%
SET LIB=C:\Users\Admin\Desktop\libc\lib\;%LIB%
REM ---------------------------------------------------------------

for %%F in (%1 %2 %3 %4 %5 %6 %7 %8 %9) do %TOOLS%ML /omf /c %%F.asm
if errorlevel 1 goto terminate

SET FILELIST=-+%1.obj

:LINKLOOP
if !%2==! goto ENDLINKLOOP
SET FILELIST=%FILELIST% -+%2.obj
shift
goto LINKLOOP

:ENDLINKLOOP

%TOOLS%LIB .\..\lib\libc %FILELIST%, .\..\lib\libc.lst, .\..\lib\libc.lib
if errorlevel 1 goto terminate

:terminate
move *.obj obj
pause