.NOLIST								; Supress listing of header
.model tiny, c							; Small memoy model
.386								; 80386 CPU

IFNDEF LIBC_INC
LIBC_INC equ <1>

include stdio.inc
include string.inc
include ctype.inc
include conio.inc
include assert.inc

ENDIF
.LIST								; Enable listing again