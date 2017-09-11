.NOLIST
IFNDEF _STRING_
_STRING_ EQU <1>

memchr PROTO :PTR BYTE, :BYTE, :PTR BYTE
memcmp PROTO :PTR BYTE, :PTR BYTE, :PTR BYTE
memcpy PROTO :PTR BYTE, :PTR BYTE, :PTR BYTE
memmove PROTO :PTR BYTE, :PTR BYTE, :PTR BYTE
memset PROTO :PTR BYTE, :BYTE, :PTR BYTE
strcat PROTO :PTR BYTE, :PTR BYTE
strchr PROTO :PTR BYTE, :BYTE
strcmp PROTO :PTR BYTE, :PTR BYTE
strcoll PROTO :PTR BYTE, :PTR BYTE
strcpy PROTO :PTR BYTE, :PTR BYTE
strcspn PROTO :WORD, :WORD
strlen PROTO :PTR BYTE
strncat PROTO :PTR BYTE, :PTR BYTE, :PTR BYTE	; [!] Warning! Mem error
strncmp PROTO :PTR BYTE, :PTR BYTE, :PTR BYTE
strncpy PROTO :PTR BYTE, :PTR BYTE, :PTR BYTE
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