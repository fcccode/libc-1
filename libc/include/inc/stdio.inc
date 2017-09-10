.NOLIST
IFNDEF _STDIO_
_STDIO_ EQU <1>

getchar PROTO
gets    PROTO
printf  PROTO :WORD, :VARARG
putchar PROTO
puts    PROTO :WORD
scanf	PROTO

FILENAME_MAX EQU 11
.data
hexstr   db '0123456789ABCDEF'
outstr16   db '00', 0
.code
ENDIF
.LIST