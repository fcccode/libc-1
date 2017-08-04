@echo off
SET PATH=

.\..\..\Tools\VC152\CL.EXE /AT /G2 /Gs /Gx /c /Zl *.c
.\..\..\Tools\VC152\ML.EXE /omf /c *.asm 
.\..\..\Tools\VC152\LINK.EXE /T /NOD kernel.obj kmain.obj, kernel.bin, nul, .\..\lib\Lib16.lib, nul
del *.obj

IF NOT EXIST .\..\build\formatted_floppy.img GOTO floppy_error
IF EXIST .\..\build\built_floppy.img GOTO remove_image
GOTO copy_image
:remove_image
DEL .\..\build\built_floppy.img > NUL
:copy_image
COPY .\..\build\formatted_floppy.img .\..\build\built_floppy.img > NUL

.\..\..\Tools\imdisk -a -f .\..\build\built_floppy.img -s 1440K -m B:

copy kernel.bin  B:
.\..\..\Tools\imdisk -D -m B:
.\..\..\Tools\dd if=.\..\bootload\bootload.bin of=.\..\build\built_floppy.img bs=512

.\..\..\Tools\qemu\qemu -fda .\..\build\built_floppy.img