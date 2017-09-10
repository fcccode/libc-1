.NOLIST

getch PROTO
getche PROTO
kbhit PROTO
putch PROTO, :BYTE
ungetch PROTO, :BYTE
clrscr PROTO
gotoxy PROTO, :BYTE, :BYTE
highvideo PROTO
lowvideo PROTO
insline PROTO
wherex PROTO
wherey PROTO
cputs PROTO, :PTR BYTE
cputsxy PROTO, :BYTE, :BYTE, :PTR BYTE
textbackground PROTO, :BYTE
textcolor PROTO, :BYTE
cursoroff PROTO
cursoron PROTO
delay PROTO, :PTR BYTE
newline	PROTO
setcursortype PROTO, :BYTE
cprintf PROTO :WORD, :VARARG
cscanf PROTO :WORD, :VARARG

.LIST