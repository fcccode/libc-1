.NOLIST
IFNDEF _STRING_
_STRING_ EQU <1>

memchr PROTO C :WORD, :BYTE, :PTR BYTE
memcmp PROTO :WORD, :WORD, :PTR BYTE
memcpy PROTO :WORD, :WORD, :PTR BYTE
memmove PROTO :WORD, :WORD, :PTR BYTE
memset PROTO :WORD, :BYTE, :PTR BYTE
strcat PROTO :WORD, :WORD
strchr PROTO :WORD, :BYTE
strcmp PROTO :WORD, :WORD
strcoll PROTO :WORD, :WORD
strcpy PROTO :WORD, :WORD
strcspn PROTO :WORD, :WORD
strlen PROTO :WORD
strncat PROTO :WORD, :WORD, :PTR BYTE	; [!] Warning! Mem error
strncmp PROTO :WORD, :WORD, :PTR BYTE
strncpy PROTO :WORD, :WORD, :PTR BYTE
strpbrk PROTO :WORD, :WORD
strrchr PROTO :WORD, :BYTE
strspn PROTO :PTR WORD, :WORD
strstr PROTO :WORD, :WORD
strtok PROTO :WORD, :WORD
strxfrm PROTO :WORD, :WORD, :PTR BYTE

.data
 return_buffer BYTE 64 dup(?)					; Buffer for returning data
 strtok_buffer BYTE 64 dup(?)					; Buffer for str token data
 token_buffer BYTE 64 dup(?)					; Buffer for str token data
.code

ENDIF
.LIST