.NOLIST
IFNDEF _FAT_
_FAT_ EQU <1>

 include string.inc
 include stdio.inc
 include ctype.inc

.data
fileEntry STRUCT
    fileName	      db 10 dup(?)
    fileExtension     db 4  dup(?)
    fileAttribute     dw ?
    fileReserved      db 10 dup(?)
    fileCreatedMonth  dw ?
    fileCreatedDay    dw ?
    fileCreatedYear   dw ?
    fileAccessedMonth dw ?
    fileAccessedDay   dw ?
    fileAccessedYear  dw ?
    fileModifiedMonth dw ?
    fileModifiedDay   dw ?
    fileModifiedYear  dw ?
    startCluster      dw ?
    fileLength        dw ?
fileEntry ENDS

SecsPerTrack          dw 18
Sides		      dw 2
BootDrive	      db 0
rootBuffer	      dw 24576
fileStat	      dw 0
fmtBuf BYTE 12 dup(?)					

.code

clearBuff MACRO arg
    push di
    push cx
    push ax
    cld
    mov di, offset arg
    mov cx, sizeof arg						; Repeat for the length of the buffer
    mov al, 0							; Clear with null (0)
    rep stosb
    pop di
    pop cx
    pop ax
ENDM

resetFloppy PROTO
openRoot PROTO
closeRoot PROTO
readRoot PROTO
convert_sector PROTO
rename PROTO  :WORD, :WORD	
fmtFatFilename PROTO :WORD
staticFileBuf fileEntry <>

ENDIF
.LIST