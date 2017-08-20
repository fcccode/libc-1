.NOLIST
IFNDEF _CONIO_
_CONIO_ EQU <1>

clrscr PROTO
cprintf PROTO :WORD, :VARARG
cputs PROTO :WORD
cputsxy PROTO :BYTE, :BYTE, :WORD
cscanf PROTO :WORD, :VARARG
cursoroff PROTO
cursoron PROTO
delay PROTO :PTR BYTE
drawline PROTO
getch PROTO
getche PROTO
gotoxy PROTO :BYTE, :BYTE
highvideo PROTO
insline PROTO
kbhit PROTO
lowvideo PROTO
newline	PROTO
putch PROTO :PTR BYTE
setcursortype PROTO :BYTE
textbackground PROTO :BYTE
textcolor PROTO	:BYTE
ungetch PROTO :PTR BYTE
wherex PROTO
wherey PROTO

ENDIF
.LIST