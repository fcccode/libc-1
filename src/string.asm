; ------------------------------------------------------------------
.model tiny, c							; Small memoy model
.386								; 80386 CPU
include libc.inc						; Include library headers
.data								; Data segment
 return_buffer BYTE 64 dup(?)					; Buffer for returning data
 strtok_buffer BYTE 64 dup(?)					; Buffer for str token data
 token_buffer BYTE 64 dup(?)					; Buffer for str token data
 include art.inc
 .code
; ------------------------------------------------------------------

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


plotImage PROC
    mov cx, memesSize
    mov si, offset memesImage
    xor ax, ax
    xor bx, bx
  @@:
    mov ax, [si]
    inc si
    mov bx, [si]
    inc si
    push bx
    push ax
    call gotoxy
    pop ax
    pop bx
    pusha
    mov bl, [si]
    mov	cx, 1
    mov bh, 00 ; page | color
    mov	ax, 0920h ; int | char
    int	    10h
    mov ax, 0edbh  ; int | char
    int	    10h							; Video interupt
    popa
    inc si
  loop @b

    ret
plotImage ENDP
; ------------------------------------------------------------------
; int strcmp(const char *str1, const char *str2)
; ------------------------------------------------------------------
; Compares the string pointed to, by str1 to the string
; pointed to by str2.

strcmp PROC uses si di bx str1:WORD, str2:WORD
    mov di, str1						; Point to param address
    mov si, str2						; Point to param address

    xor ax, ax							; Char number total for SI
    xor bx, bx							; Char number total for DI

  @@cmp:
    mov al, [si]						; Byte from SI
    add ah, al							; Total ascii char number
    mov bl, [di]						; Byte from DI
    add bh, bl							; Total ascii char number
    cmp al, bl
    jne @@done
    cmp al, 0
    je @@done
    inc di
    inc si
    jmp @@cmp

  @@done:
    .IF bh == ah						; Return 0 if both str inputs equal
	mov ax, 0
    .ELSEIF bh > ah						; Return 1 if str1 is greater than str2
	mov ax, 1
    .ELSEIF bh < ah						; Return -1 if str1 is less than str2
	mov ax, -1
    .ENDIF

    ret
strcmp ENDP


; ------------------------------------------------------------------
; int strncmp(const char *str1, const char *str2, size_t n)
; ------------------------------------------------------------------
; Compares at most the first n bytes of str1 and str2.

strncmp PROC uses si di bx cx str1:WORD, str2:WORD, n:PTR BYTE
    mov di, str1						; Point to param address str1
    mov si, str2						; Point to param address str2
    mov cx, n							; Store n in cx for loop

    xor ax, ax							; Char number total for SI
    xor bx, bx							; Char number total for DI

    .REPEAT
	mov al, [si]						; Byte from S
	add ah, al
	mov bl, [di]						; Byte from DI
	add bh, bl
	.IF al != bl						; Both bytes equal before null?
	    .BREAK
	.ELSEIF !al
	    .BREAK
	.ENDIF
	inc di
	inc si
	dec cx
    .UNTILCXZ

    .IF bh == ah						; Return 0 if both str inputs equal
	mov ax, 0
    .ELSEIF bh > ah						; Return 1 if str1 is greater than str2
	mov ah, 1
    .ELSEIF bh < ah						; Return -1 if str1 is less than str2
	mov ah, -1
    .ENDIF

    ret
strncmp ENDP


; ------------------------------------------------------------------
; int strcoll(const char *str1, const char *str2)
; ------------------------------------------------------------------
; Compares the string pointed to, by str1 to the string
; pointed to by str2.

strcoll PROC uses si di bx str1:WORD, str2:WORD
    mov di, str1						; Point to str1
    mov si, str2						; Point to str2

    xor ax, ax							; Char number total for SI
    xor bx, bx							; Char number total for DI

   .REPEAT
	mov al, [si]						; Byte from SI
	add ah, al						; Total ascii char number
	mov bl, [di]						; Byte from DI
	add bh, bl						; Total ascii char number
	.IF al != bl						; Both bytes equal before null?
	    .BREAK
	.ELSEIF !al
	    .BREAK
	.ENDIF
	inc di
	inc si
    .UNTIL 0

    .IF bh == ah						; Return 0 if both str inputs equal
    	mov ax, 0
    .ELSEIF bh > ah						; Return 1 if str1 is greater than str2
    	mov ah, 1
    .ELSEIF bh < ah						; Return -1 if str1 is less than str2
    	mov ah, -1
    .ENDIF

    ret
strcoll ENDP


; ------------------------------------------------------------------
; char *strcpy(char *dest, const char *src)
; ------------------------------------------------------------------
; Coppy string in src to dest

strcpy PROC uses si di ax bx dest:WORD, src:WORD
    mov di, dest						; Point to dest address
    mov si, src							; Point to src address

  @@cpy:
    lodsb
    stosb							; Transfer contents
    or al, al							; If source string is empty, quit out
    jne @@cpy

    ret
strcpy ENDP


; ------------------------------------------------------------------
; char *strncpy(char *dest, const char *src, size_t n)
; ------------------------------------------------------------------
; Coppy string in src to dest up to n chars.

strncpy PROC uses si di ax bx dest:WORD, src:WORD, n:PTR BYTE
    mov di, dest						; Point to dest address
    mov si, src							; Point to src address
    mov cx, n							; Times to iterate

  @@cpy:
    lodsb
    stosb							; Transfer contents
    or al, al							; If source string is empty, quit out
    jz @@done
    loop @@cpy

  @@done:
    ret
strncpy ENDP


; ------------------------------------------------------------------
; size_t strlen(const char *str)
; ------------------------------------------------------------------
; Get the length of the string.

strlen PROC uses si cx string:WORD
    mov si, string						; Point to string address

    xor cx, cx							; Store n in cx for loop

  @@loop:
    lodsb							; Get character from string
    or al, al							; End of string
    jz @@done
    inc cx
    jmp @@loop

  @@done:
    mov ax, cx							; Return the length of the string

    ret
strlen ENDP


; ------------------------------------------------------------------
; char *strchr(const char *str, int n)
; ------------------------------------------------------------------
; Searches for the first occurrence of the character c
; (an unsigned char) in the string pointed to, by the
; argument str.

strchr PROC uses si di cx string:WORD, n:BYTE
    clearBuff return_buffer

    mov si, string						; Point to param address str1
    mov di, offset return_buffer				; Point to param ret str1
    mov cl, n

  @@loop:
    lodsb							; Get character from string
    or al, al							; End of string
    jz @@done
    cmp al, cl
    jne @@loop
    stosb

  @@found:
    lodsb							; Get character from string
    or al, al							; End of string
    jz @@done
    stosb
    jmp @@found

  @@done:
    mov ax, offset return_buffer

    ret
strchr ENDP


; ------------------------------------------------------------------
; char *strcat(char *dest, const char *src)
; ------------------------------------------------------------------
; The strcat function concatenates or appends src to dest.
; All characters from src are copied including the
; terminating null character.

strcat PROC uses si di ax dest:WORD, src:WORD
    mov di, dest					    ; Point to dest address
    mov si, src						    ; Point to source address

  @@inc:						    ; Find the end of the dest string
    inc di
    mov al, [di]
    or al, al
    jnz @@inc

  @@append:
    mov al, [si]					    ; Transfer contents of source to dest
    mov [di], al
    inc si
    inc di
    or al, al
    jne @@append

    ret
strcat ENDP


; ------------------------------------------------------------------
; char *strncat(char *dest, const char *src, size_t n)
; ------------------------------------------------------------------
; The strncat function concatenates or appends first n characters
; from src to dest. All characters from src are copied including
; the terminating null character.

strncat PROC uses si di ax dest:WORD, src:WORD, n:PTR BYTE
    mov di, dest					    ; Point to dest address
    mov si, src						    ; Point to source address
    mov cx, n						    ; Point to n address

  @@inc:						    ; Find the end of the dest
    inc di
    mov al, [di]
    or al, al
    jnz @@inc

  @@append:
    mov al, [si]					    ; Transfer contents of source to dest up to n
    mov [di], al
    inc si
    inc di
    loop @@append

    ret
strncat ENDP


; ------------------------------------------------------------------
; void *memset(void *str, int c, size_t n)
; ------------------------------------------------------------------
; Copies the character c (an unsigned char) to the first n
; characters of the string pointed to, by the argument str.

memset PROC uses si di ax cx string:WORD, char:BYTE, n:PTR BYTE
    mov di, string					    ; Point to str address
    mov cx, n						    ; Point to n address

  @@append:
    mov al, char					    ; Move c into str n times
    mov [di], al
    inc di
    loop @@append

    ret
memset ENDP


; ------------------------------------------------------------------
; void *memmove(void *dest, const void *src, size_t n)
; ------------------------------------------------------------------
; Copies n characters from src to dest.

memmove PROC uses si di ax cx dest:WORD, src:WORD, n:PTR BYTE
    mov di, dest						; Point to dest address
    mov si, src							; Point to src address
    mov cx, n							; Point to n address

  @@append:
    mov al, [si]						; Char from src to al
    mov [di], al						; Char from al moves into dest
    inc di
    inc si
    loop @@append

    ret
memmove ENDP


; ------------------------------------------------------------------
; void *memcpy(void *dest, const void *src, size_t n)
; ------------------------------------------------------------------
; This function copies n characters from memory at src to the
; memory area at the dest.

memcpy PROC uses si di ax cx dest:WORD, src:WORD, n:PTR BYTE
    mov di, dest					    ; Point to str1 address
    mov si, src						    ; Point to str2 address
    mov cx, n						    ; Point to n address

  @@cpy:
    mov al, [si]					    ; Transfer contents (at least one byte terminator)
    mov [di], al
    or al, al
    je @@done
    inc si
    inc di
    inc cx
    loop @@cpy

  @@done:
    ret
memcpy ENDP


; ------------------------------------------------------------------
; int memcmp(const void *str1, const void *str2, size_t n)
; ------------------------------------------------------------------
; Compares at most the first n bytes of str1 and str2.

memcmp PROC uses si di bx cx str1:WORD, str2:WORD, n:PTR BYTE
    mov di, str1						; Point to str1 address
    mov si, str2						; Point to str2 address
    mov cx, n							; Point to n addres

    xor ax, ax							; Char number total for SI
    xor bx, bx							; Char number total for DI

  @@cmp:
    mov al, [si]						; Byte from S
    add ah, al							; Add byte value to ah
    mov bl, [di]						; Byte from DI
    add bh, bl							; Add byte value to bh
    cmp al, bl							; If both bytes not equal then exit
    jne @@done
    or al, al							; If no bytes left then exit
    jz @@done
    inc di
    inc si
    loop @@cmp

  @@done:
    .IF bh == ah						; Return 0 if both str inputs equal
    	mov ax, 0
    .ELSEIF bh > ah						; Return 1 if str1 is greater than str2
    	mov ah, 1
    .ELSEIF bh < ah						; Return -1 if str1 is less than str2
    	mov ah, -1
    .ENDIF

    ret
memcmp ENDP


; ------------------------------------------------------------------
; void *memchr(const void *str, int c, size_t n)
; ------------------------------------------------------------------
; Searches for the first occurrence of the character c
; (an unsigned char) in the first n bytes of the string
; pointed to, by the argument str.

memchr PROC uses si di bx cx string:WORD, char:BYTE, n:PTR BYTE
    clearBuff return_buffer

    mov si, string						; Point to param address str
    mov di, offset return_buffer

  @@loop:
    lodsb							; Get character from string
    or al, al							; End of string
    jz @@done
    cmp al, char
    jne @@loop

    mov [di], al						; Add n to buffer and increase
    inc di

    mov cx, n						; Times to iterate
    or cx, cx
    jz @@done

  @@iterate:
    lodsb							; Get character from string
    or al, al							; End of string
    jz @@done
    mov [di], al
    inc di
    loop @@iterate

  @@done:
    mov ax, offset return_buffer

    ret
memchr ENDP


; ------------------------------------------------------------------
; size_t strcspn(const char *str1, const char *str2);
; ------------------------------------------------------------------
; This function calculates the length of the initial
; segment of str1, which consists entirely of characters
; not in str2.

strcspn PROC uses si di bx cx str1:WORD, str2:WORD
    mov si, str1					    ; Point to str1 address
    mov di, str2					    ; Point to str2 address

    xor cx, cx

  @@cmp:
    mov al, [si]					    ; Byte from SI
    push di						    ; Save DI

  @@char:
    mov bl, [di]					    ; Byte from DI
    cmp al, bl						    ; If both bytes equal then exit
    je @@exit
    inc di						    ; Increase DI untill zero
    or bl, bl
    jnz @@char
    pop di						    ; Restore DI
    or al, al						    ; If no bytes left then exit
    jz @@done
    inc si
    inc cx
    jmp @@cmp

  @@exit:
     pop di						    ; Restore DI

  @@done:
    mov ax, cx
    ret
strcspn ENDP


; ------------------------------------------------------------------
; char *strpbrk(const char *str1, const char *str2);
; ------------------------------------------------------------------
; This function finds the first character in the string str1
; that matches any character specified in str2. This does
; not include the terminating null-characters.

strpbrk PROC uses si di bx str1:WORD, str2:WORD
    clearBuff return_buffer

    mov si, str1						; Point to str1 address
    mov di, str2						; Point to str2 address

  @@cmp:
    mov al, [si]						; Byte from SI
    push di							; Save DI

  @@char:
    mov bl, [di]						; Byte from DI
    cmp al, bl							; If both bytes equal then exit
    je @@equal
    inc di							; Increase DI untill zero
    or bl, bl
    jnz @@char
    pop di							; Restore DI

    or al, al							; If no bytes left then exit
    jz @@error
    inc si
    jmp @@cmp

  @@equal:
    pop di
    mov di, offset return_buffer				; Found equal char

  @@fill:
    mov al, [si]
    mov [di], al
    or al, al							; If no bytes left then exit
    jz @@buff
    inc si
    inc di
    jmp @@fill

  @@buff:
    mov ax, offset return_buffer
    jmp @@done

  @@error:
    mov ax, 0							 ; Return null on char not found

  @@done:
    ret
strpbrk ENDP


; ------------------------------------------------------------------
; char *strrchr(const char *str, int n);
; ------------------------------------------------------------------
; This function searches for the last occurrence of the
; character c (an unsigned char) in the string pointed
; to, by the argument str.

strrchr PROC uses si di bx cx str1:WORD, n:BYTE
    clearBuff return_buffer

    mov si, str1						; Point to str1 address
    push si							; Save SI

    xor cx, cx							; Clear counter
    xor bx, bx							; Clear counter storage

  @@cmp:
    mov al, [si]						; Byte from SI
    cmp al, n
    je @@found							; If equal store counter in BX
    jne @@cont							; Else continue

  @@found:
    mov bx, cx

  @@cont:
    or al, al
    jz @@fill							; If no more bytes left we need to now fill the buffer
    inc si							; Increment string
    inc cx							; Increment counter
    jmp @@cmp

  @@fill:
    pop si							; Restore the string
    or bx, bx							; If stored counter is null return null
    jz @@error
    add si, bx							; Add offfset of counter and string
    mov di, offset return_buffer				; Point DI to the offset of return_buffer

  @@iterate:
    lodsb							; Get character from string
    or al, al							; End of string
    jz @@finished
    mov [di], al						; Store char into DI
    inc di							; Increase DI
    jmp @@iterate

  @@error:
    xor ax, ax
    jmp @@done

  @@finished:
    mov ax, offset return_buffer

  @@done:
    ret
strrchr ENDP


; ------------------------------------------------------------------
; size_t strspn(const char *str1, const char *str2);
; ------------------------------------------------------------------
; This function calculates the length of the initial
; segment of str1 which consists entirely of chars
; in str2.

strspn PROC uses di si cx str1:PTR WORD, str2:WORD
    mov si, str1						; Point to str1 address
    mov di, str2						; Point to str2 address

    xor cx, cx							; Clear counter

  @@cmp:
    mov al, [si]						; Byte from S
    mov bl, [di]						; Byte from DI
    cmp al, bl							; If both bytes not equal then exit
    jne @@done
    or al, al							; If no bytes left then exit
    jz @@done
    inc di
    inc si
    inc cx
    jmp @@cmp

  @@done:
    mov ax, cx							; Return counter number
    ret
strspn ENDP


; ------------------------------------------------------------------
; char *strstr(const char *haystack, const char *needle)
; ------------------------------------------------------------------
; This function finds the first occurrence of the substring
; needle in the string haystack. The terminating '\0'
; characters are not compared.

strstr PROC uses si di bx cx haystack:WORD, needle:WORD
    clearBuff return_buffer

    mov si, haystack						; Point to haystack address
    mov di, needle						; Point to needle address

    xor cx, cx							; Store n in cx for loop

  @@cmp:
    mov al, [si]						; Byte from SI
    mov bl, [di]						; Byte from DI
    cmp al, bl							; If not equal continue to iterate
    jne @@cont
    pusha

  @@cmpstr:
    mov al, [si]						; Byte from SI
    mov bl, [di]						; Byte from DI
    or bl, bl							; If end of needle return true
    je @@equal
    cmp al, bl							; Test if equal
    jne @@notequal						; If not equal continue @@cmp loop
    inc di
    inc si
    jmp @@cmpstr

  @@notequal:
    popa

  @@cont:
    or al, al							; If no bytes left then exit
    jz @@done
    inc si
    inc cx
    jmp @@cmp

 @@equal:
    popa
    mov di, offset return_buffer				; Point DI to the offset of return_buffer
    mov si, haystack						; Point to haystack address
    add si, cx

 @@iterate:
   lodsb							; Get character from string
   or al, al							; End of string
   jz @@done
   mov [di], al							; Store char into DI
   inc di							; Increase DI
   jmp @@iterate

  @@done:
    mov ax, offset return_buffer				; Return the buffer
    ret
strstr	ENDP

; ------------------------------------------------------------------
; char *strtok(char *str, const char *delim)
; ------------------------------------------------------------------
strtok PROC uses si di bx string:WORD, delim:WORD
    mov si, string						; Point to haystack address
    mov di, string						; This function makes me wanta kill myself

    clearBuff return_buffer

    mov bl, [di]						; Byte from DI
    or bl, bl
    jz @@s
    jmp @@f

  @@s:
    mov si, offset strtok_buffer
    mov di, offset return_buffer
    mov al, [si]
    or al, al
    jnz @@s_fill_return
    mov ax, 0
    jmp @@done

  @@s_fill_return:
    lodsb							; Get byte from SI into AL
    cmp al, [bp + 6]
    je @@s_found_delim
    stosb							; Store AL into DI
    or al, al							; End of string?
    jnz @@s_fill_return

  @@s_found_delim:
    mov di, offset token_buffer

  @@s_fill_token:
    lodsb							; Get byte from SI into AL
    stosb							; Store AL into DI
    or al, al							; End of string?
    jnz @@s_fill_token

    clearBuff strtok_buffer

    mov di, offset strtok_buffer
    mov si, offset token_buffer

  @@s_fill_strtok:
    lodsb							; Get byte from SI into AL
    stosb							; Store AL into DI
    or al, al							; End of string?
    jnz @@s_fill_strtok

    clearBuff token_buffer

    mov ax, offset return_buffer
    ret

  @@f:
    clearBuff strtok_buffer
    mov di, offset return_buffer	; Point to buffer address

  @@f_fill_return:
    lodsb							; Get byte from SI into AL
    cmp al, [bp+4]
    je @@f_found_delim
    stosb							; Store AL into DI
    or al, al						; End of string?
    jnz @@f_fill_return

  @@f_found_delim:
    mov di, offset strtok_buffer

  @@f_fill_strtok:
    lodsb							; Get byte from SI into AL
    stosb							; Store AL into DI
    or al, al						; End of string?
    jnz @@f_fill_strtok
    mov ax, offset return_buffer

  @@done:
    ret
strtok ENDP

; ------------------------------------------------------------------
; size_t strxfrm(char *dest, const char *src, size_t n)
; ------------------------------------------------------------------
; This function transforms the first n chars of src
; into the locale and puts them into the dest.

strxfrm PROC uses di si cx dest:WORD, src:WORD, n:PTR BYTE
    mov di, dest							; Point to str1 address
    mov si, src							; Point to str2 address

    xor cx, cx

  @@loop:								; Get length of SI
    lodsb								; Get character from string
    or al, al								; End of string
    jz @@cont
    inc cx
    jmp @@loop

  @@cont:
    push cx								; Save length of SI
    mov cx, n							; Point to n addres
    mov si, src							; Point to str2 address

  @@append:
    mov al, [si]							; Transfer contents of source to dest up to n
    mov [di], al
    inc si
    inc di
    loop @@append

  @@done:
    pop cx
    mov ax, cx
    ret
strxfrm ENDP
END
