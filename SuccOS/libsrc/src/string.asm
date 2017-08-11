; ------------------------------------------------------------------
  	.286					; CPU type
	.model tiny				; Tiny memoy model
	.data					; Data segment
		return_buffer BYTE 64 dup(?)	; Buffer for returning data
		strtok_buffer BYTE 64 dup(?)	; Buffer for str token data
		token_buffer BYTE 64 dup(?)	; Buffer for str token data
	.code					; Start of code segment
; ------------------------------------------------------------------

clearBuff MACRO arg
    push di
    push cx
    push ax
    cld
    mov di, offset arg
    mov cx, sizeof arg				; Repeat for the length of the buffer
    mov al, 0							; Clear with null (0)
    rep stosb
    pop di
    pop cx
    pop ax
ENDM

; ------------------------------------------------------------------
; int strcmp(const char *str1, const char *str2)
; ------------------------------------------------------------------
; Compares the string pointed to, by str1 to the string
; pointed to by str2.

_strcmp PROC
	push bp							; Save BP on stack
	mov bp, sp						; Set BP to SP
	mov di, [bp + 4]					; Point to param address
	mov si, [bp + 6]					; Point to param address

	xor ah, ah						; Char number total for SI
	xor bh, bh						; Char number total for DI

  @@cmp:
    mov al, [si]					; Byte from SI
    add ah, al					; Total ascii char number
    mov bl, [di]					; Byte from DI
    add bh, bl					; Total ascii char number
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
	mov sp, bp						; Restore stack pointer
	pop bp							; Restore BP register
	ret
_strcmp ENDP


; ------------------------------------------------------------------
; int strncmp(const char *str1, const char *str2, size_t n)
; ------------------------------------------------------------------
; Compares at most the first n bytes of str1 and str2.

_strncmp PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
	mov di, [bp + 4]					; Point to param address str1
	mov si, [bp + 6]					; Point to param address str2

	xor cx, cx						; Store n in cx for loop
	xor ah, ah						; Char number total for SI
	xor bh, bh						; Char number total for DI

  	.WHILE cx != [bp + 8]
		mov al, [si]					; Byte from S
		add ah, al
		mov bl, [di]					; Byte from DI
		add bh, bl
		.IF al != bl					; Both bytes equal before null?
			.BREAK
		.ELSEIF !al
			.BREAK
		.ENDIF
		inc di
		inc si
		inc cx
	.ENDW

	.IF bh == ah						; Return 0 if both str inputs equal
		mov ax, 0
	.ELSEIF bh > ah						; Return 1 if str1 is greater than str2
		mov ah, 1
	.ELSEIF bh < ah						; Return -1 if str1 is less than str2
		mov ah, -1
	.ENDIF

	mov sp, bp						; Restore stack pointer
	pop bp							; Restore BP register
	ret
_strncmp ENDP


; ------------------------------------------------------------------
; int strcoll(const char *str1, const char *str2)
; ------------------------------------------------------------------
; Compares the string pointed to, by str1 to the string
; pointed to by str2.

_strcoll PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov di, [bp + 4]					; Point to param address
    mov si, [bp + 6]					; Point to param address

    xor ah, ah						; Char number total	for SI
    xor bh, bh						; Char number total for DI

   .REPEAT
	mov al, [si]					; Byte from SI
	add ah, al					; Total ascii char number
	mov bl, [di]					; Byte from DI
	add bh, bl					; Total ascii char number
	.IF al != bl					; Both bytes equal before null?
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

    mov sp, bp						; Restore stack pointer
    pop bp							; Restore BP register
    ret
_strcoll ENDP


; ------------------------------------------------------------------
; char *strcpy(char *dest, const char *src)
; ------------------------------------------------------------------
; Coppy string in src to dest

_strcpy PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov di, [bp + 4]						; Point to dest address
    mov si, [bp + 6]						; Point to src address

  @@cpy:
    mov al, [si]						; Transfer contents (at least one byte terminator)
    mov [di], al
    inc si
    inc di
    cmp byte ptr al, 0						; If source string is empty, quit out
    jne @@cpy

    mov ax, [bp + 4]						; Return dest address
    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
_strcpy ENDP


; ------------------------------------------------------------------
; char *strncpy(char *dest, const char *src, size_t n)
; ------------------------------------------------------------------
; Coppy string in src to dest up to n chars.

_strncpy PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov di, [bp + 4]						; Point to dest address
    mov si, [bp + 6]						; Point to src address

    xor cx, cx							; Store n in cx for loop

    .WHILE cx != [bp + 8]
    	mov al, [si]						; Transfer contents (at least one byte terminator)
    	mov [di], al
    	inc si
    	inc di
    	inc cx
    	.IF !al
    	    .BREAK
    	.ENDIF
    .ENDW

    mov ax, [bp + 4]						; Return dest address
    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
_strncpy ENDP


; ------------------------------------------------------------------
; size_t strlen(const char *str)
; ------------------------------------------------------------------
; Get the length of the string.

_strlen PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov si, [bp + 4]						; Point to param address str1

    xor cx, cx							; Store n in cx for loop

  @@loop:
    lodsb							; Get character from string
    or al, al							; End of string
    jz @@done
    inc cx
    jmp @@loop

  @@done:
    mov ax, cx							; Return the length of the string

    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
_strlen ENDP



; ------------------------------------------------------------------
; char *strchr(const char *str, int c)
; ------------------------------------------------------------------
; Searches for the first occurrence of the character c
; (an unsigned char) in the string pointed to, by the
; argument str.

_strchr PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov si, [bp + 4]					; Point to param address str1

	cli									; Clear interrupts
	mov di, offset return_buffer
	mov cx, sizeof return_buffer		; Repeat for the length of the buffer
	mov al, 0							; Clear with null (0)
	rep stosb

	mov di, offset return_buffer

  @@loop:
	lodsb								; Get character from string
	or al, al							; End of string
	jz @@done
	cmp al, [bp + 6]
	jne @@loop
	stosb

  @@found:
   	lodsb								; Get character from string
	or al, al							; End of string
	jz @@done
	stosb
	jmp @@found

  @@done:
	mov ax, offset return_buffer

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register
	ret
_strchr ENDP


; ------------------------------------------------------------------
; char *strcat(char *dest, const char *src)
; ------------------------------------------------------------------
; The strcat function concatenates or appends src to dest.
; All characters from src are copied including the
; terminating null character.

_strcat PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov di, [bp + 4]					    ; Point to dest address
    mov si, [bp + 6]					    ; Point to source address

  @@inc:							; Find the end of the dest string
    inc di
    mov al, [di]
    or al, al
    jnz @@inc

  @@append:
    mov al, [si]						; Transfer contents of source to dest
    mov [di], al
    inc si
    inc di
    or al, al
    jne @@append

    mov ax, [bp + 4]						; Return value points to dest address
    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
_strcat ENDP


; ------------------------------------------------------------------
; char *strncat(char *dest, const char *src, size_t n)
; ------------------------------------------------------------------
; The strncat function concatenates or appends first n characters
; from src to dest. All characters from src are copied including
; the terminating null character.

_strncat PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov di, [bp + 4]						; Point to dest address
    mov si, [bp + 6]						; Point to source address
    mov cx, [bp + 8]						; Point to n address

  @@inc:							; Find the end of the dest
    inc di
    mov al, [di]
    or al, al
    jnz @@inc

  @@append:
    mov al, [si]						; Transfer contents of source to dest up to n
    mov [di], al
    inc si
    inc di
    loop @@append

    mov ax, [bp + 4]						; Return value points to dest address
    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
_strncat ENDP


; ------------------------------------------------------------------
; void *memset(void *str, int c, size_t n)
; ------------------------------------------------------------------
; Copies the character c (an unsigned char) to the first n
; characters of the string pointed to, by the argument str.

_memset PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov di, [bp + 4]						; Point to str address
    mov cx, [bp + 8]						; Point to n address

  @@append:
    mov al, [bp + 6]						; Move c into str n times
    mov [di], al
    inc di
    loop @@append

    mov ax, [bp + 4]						; Return value points to dest address
    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
_memset ENDP


; ------------------------------------------------------------------
; void *memmove(void *dest, const void *src, size_t n)
; ------------------------------------------------------------------
; Copies n characters from src to dest.

_memmove PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov di, [bp + 4]						; Point to dest address
    mov si, [bp + 6]						; Point to src address
    mov cx, [bp + 8]						; Point to n address

  @@append:
    mov al, [si]						; Char from src to al
    mov [di], al						; Char from al moves into dest
    inc di
    inc si
    loop @@append

    mov ax, [bp + 4]						; Return value points to dest address
    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
_memmove ENDP



; ------------------------------------------------------------------
; void *memcpy(void *dest, const void *src, size_t n)
; ------------------------------------------------------------------
; This function copies n characters from memory at src to the
; memory area at the dest.

_memcpy PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov di, [bp + 4]						; Point to str1 address
    mov si, [bp + 6]						; Point to str2 address
    mov cx, [bp + 8]						; Point to n address

  @@cpy:
    mov al, [si]						; Transfer contents (at least one byte terminator)
    mov [di], al
    cmp al, 0
    je @@done
    inc si
    inc di
    inc cx
    loop @@cpy

  @@done:
    mov ax, [bp + 4]						; Return value points to dest address

    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
_memcpy ENDP


; ------------------------------------------------------------------
; int memcmp(const void *str1, const void *str2, size_t n)
; ------------------------------------------------------------------
; Compares at most the first n bytes of str1 and str2.

_memcmp PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov di, [bp + 4]						; Point to str1 address
    mov si, [bp + 6]						; Point to str2 address
    mov cx, [bp + 8]						; Point to n addres

    xor ah, ah							; Char number total for SI
    xor bh, bh							; Char number total for DI

  @@cmp:
    mov al, [si]						; Byte from S
    add ah, al							; Add byte value to ah
    mov bl, [di]						; Byte from DI
    add bh, bl							; Add byte value to bh
    cmp al, bl							; If both bytes not equal then exit
    jne @@done
    cmp al, 0							; If no bytes left then exit
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

    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
_memcmp ENDP


; ------------------------------------------------------------------
; void *memchr(const void *str, int c, size_t n)
; ------------------------------------------------------------------
; Searches for the first occurrence of the character c
; (an unsigned char) in the first n bytes of the string
; pointed to, by the argument str.

_memchr PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov si, [bp + 4]						; Point to param address str1

    ; cli
    cld
    mov di, offset return_buffer
    mov cx, sizeof return_buffer				; Repeat for the length of the buffer
    mov al, 0							; Clear with null (0)
    rep stosb

    mov di, offset return_buffer

  @@loop:
    lodsb							; Get character from string
    or al, al							; End of string
    jz @@done
    cmp al, [bp + 6]
    jne @@loop

    mov [di], al						; Add n to buffer and increase
    inc di

    mov cx, [bp + 8]						; Times to iterate
    cmp cx, 0
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

    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
_memchr ENDP


; ------------------------------------------------------------------
; size_t strcspn(const char *str1, const char *str2);
; ------------------------------------------------------------------
; This function calculates the length of the initial
; segment of str1, which consists entirely of characters
; not in str2.

_strcspn PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov si, [bp + 4]						; Point to str1 address
    mov di, [bp + 6]						; Point to str2 address

    xor cx, cx

  @@cmp:
    mov al, [si]						; Byte from SI
    push di							; Save DI

  @@char:
    mov bl, [di]						; Byte from DI
    cmp al, bl							; If both bytes equal then exit
    je @@done
    inc di							; Increase DI untill zero
    cmp bl, 0
    jnz @@char
    pop di							; Restore DI

    cmp al, 0							; If no bytes left then exit
    jz @@done
    inc si
    inc cx
    jmp @@cmp

  @@done:
    mov ax, cx

    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
_strcspn ENDP


; ------------------------------------------------------------------
; char *strpbrk(const char *str1, const char *str2);
; ------------------------------------------------------------------
; This function finds the first character in the string str1
; that matches any character specified in str2. This does
; not include the terminating null-characters.

_strpbrk PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov si, [bp + 4]						; Point to str1 address

    cld
    mov di, offset return_buffer
    mov cx, sizeof return_buffer				; Repeat for the length of the buffer
    mov al, 0							; Clear with null (0)
    rep stosb

    mov di, [bp + 6]						; Point to str2 address

  @@cmp:
    mov al, [si]						; Byte from SI
    push di							; Save DI

  @@char:
    mov bl, [di]						; Byte from DI
    cmp al, bl							; If both bytes equal then exit
    je @@equal
    inc di							; Increase DI untill zero
    cmp bl, 0
    jnz @@char
    pop di							; Restore DI

    cmp al, 0							; If no bytes left then exit
    jz @@error
    inc si
    jmp @@cmp

  @@equal:
    pop di
    mov di, offset return_buffer				; Found equal char

  @@fill:
    mov al, [si]
    mov [di], al
    cmp al, 0							; If no bytes left then exit
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
    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
_strpbrk ENDP


; ------------------------------------------------------------------
; char *strrchr(const char *str, int c);
; ------------------------------------------------------------------
; This function searches for the last occurrence of the
; character c (an unsigned char) in the string pointed
; to, by the argument str.

_strrchr PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov si, [bp + 4]						; Point to str1 address

    cld
    mov di, offset return_buffer
    mov cx, sizeof return_buffer				; Repeat for the length of the buffer
    mov al, 0							; Clear with null (0)
    rep stosb


    push si							; Save SI
    xor cx, cx							; Clear counter
    xor bx, bx							; Clear counter storage

  @@cmp:
    mov al, [si]						; Byte from SI
    cmp al, [bp + 6]
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
    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
_strrchr ENDP


; ------------------------------------------------------------------
; size_t strspn(const char *str1, const char *str2);
; ------------------------------------------------------------------
; This function calculates the length of the initial
; segment of str1 which consists entirely of chars
; in str2.

_strspn PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov si, [bp + 4]						; Point to str1 address
    mov di, [bp + 6]						; Point to str2 address

    xor cx, cx							; Clear counter

  @@cmp:
    mov al, [si]						; Byte from S
    mov bl, [di]						; Byte from DI
    cmp al, bl							; If both bytes not equal then exit
    jne @@done
    cmp al, 0							; If no bytes left then exit
    jz @@done
    inc di
    inc si
    inc cx
    jmp @@cmp

  @@done:
    mov ax, cx							; Return counter number

    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
_strspn ENDP


; ------------------------------------------------------------------
; char *strstr(const char *haystack, const char *needle)
; ------------------------------------------------------------------
; This function finds the first occurrence of the substring
; needle in the string haystack. The terminating '\0'
; characters are not compared.

_strstr PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov si, [bp + 4]						; Point to haystack address
    mov di, [bp + 6]						; Point to needle address

    pusha
    cld
    mov di, offset return_buffer
    mov cx, sizeof return_buffer				; Repeat for the length of the buffer
    mov al, 0							; Clear with null (0)
    rep stosb
    popa

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
    cmp bl, 0							; If end of needle return true
    je @@equal
    cmp al, bl							; Test if equal
    jne @@notequal						; If not equal continue @@cmp loop
    inc di
    inc si
    jmp @@cmpstr

  @@notequal:
    popa

  @@cont:
    cmp al, 0							; If no bytes left then exit
    jz @@done
    inc si
    inc cx
    jmp @@cmp

 @@equal:
    popa
    mov di, offset return_buffer				; Point DI to the offset of return_buffer
    mov si, [bp + 4]						; Point to haystack address
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

    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
_strstr	ENDP

; ------------------------------------------------------------------
; char *strtok(char *str, const char *delim)
; ------------------------------------------------------------------
 _strtok PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov si, [bp + 4]						; Point to haystack address
    mov di, [bp + 4]						; This function makes me wanta kill myself

    clearBuff return_buffer

    mov bl, [di]						; Byte from DI
    cmp bl, 0
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
    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret

  @@f:
    clearBuff strtok_buffer
    mov di, offset return_buffer	; Point to buffer address

  @@f_fill_return:
    lodsb							; Get byte from SI into AL
    cmp al, [bp + 6]
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
    mov sp, bp							; Restore stack pointer
    pop bp								; Restore BP register
    ret
_strtok ENDP

; ------------------------------------------------------------------
; size_t strxfrm(char *dest, const char *src, size_t n)
; ------------------------------------------------------------------
; This function transforms the first n chars of src
; into the locale and puts them into the dest.

_strxfrm PROC
    push bp								; Save BP on stack
    mov bp, sp								; Set BP to SP
    mov di, [bp + 4]							; Point to str1 address
    mov si, [bp + 6]							; Point to str2 address

    xor cx, cx

  @@loop:								; Get length of SI
    lodsb								; Get character from string
    or al, al								; End of string
    jz @@cont
    inc cx
    jmp @@loop

  @@cont:
    push cx								; Save length of SI
    mov cx, [bp + 8]							; Point to n addres
    mov si, [bp + 6]							; Point to str2 address

  @@append:
    mov al, [si]							; Transfer contents of source to dest up to n
    mov [di], al
    inc si
    inc di
    loop @@append

  @@done:
    pop cx
    mov ax, cx
    mov sp, bp								; Restore stack pointer
    pop bp								; Restore BP register
    ret
_strxfrm ENDP
END