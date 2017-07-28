; ------------------------------------------------------------------
  	.286								; CPU type
	.model tiny							; Tiny memoy model
	.data								; Data segment
		temp_buffer db ?				; Temp var
	.code								; Start of code segment
; ------------------------------------------------------------------


; ------------------------------------------------------------------
; int strcmp(const char *str1, const char *str2)
; ------------------------------------------------------------------
; Compares the string pointed to, by str1 to the string 
; pointed to by str2.

_strcmp PROC
	push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP   
	mov di, [bp + 4]					; Point to param address
	mov si, [bp + 6]					; Point to param address

	xor ah, ah							; Char number total	for SI
	xor bh, bh							; Char number total for DI

  	.REPEAT
		mov al, [si]					; Byte from SI
		add ah, al						; Total ascii char number
		mov bl, [di]					; Byte from DI
		add bh, bl						; Total ascii char number
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

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_strcmp ENDP


; ------------------------------------------------------------------
; int strncmp(const char *str1, const char *str2, size_t n)
; ------------------------------------------------------------------
; Compares at most the first n bytes of str1 and str2.

_strncmp PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP   
	mov di, [bp + 4]					; Point to param address str1
	mov si, [bp + 6]					; Point to param address str2

	xor cx, cx							; Store n in cx for loop
	xor ah, ah							; Char number total for SI
	xor bh, bh							; Char number total for DI

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

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_strncmp ENDP


; ------------------------------------------------------------------
; int strcoll(const char *str1, const char *str2)
; ------------------------------------------------------------------
; Compares the string pointed to, by str1 to the string 
; pointed to by str2.

_strcoll PROC
	push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP   
	mov di, [bp + 4]					; Point to param address
	mov si, [bp + 6]					; Point to param address

	xor ah, ah							; Char number total	for SI
	xor bh, bh							; Char number total for DI

  	.REPEAT
		mov al, [si]					; Byte from SI
		add ah, al						; Total ascii char number
		mov bl, [di]					; Byte from DI
		add bh, bl						; Total ascii char number
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

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_strcoll ENDP


; ------------------------------------------------------------------
; char *strcpy(char *dest, const char *src)
; ------------------------------------------------------------------
; Coppy string in src to dest

_strcpy PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP   
	mov di, [bp + 4]					; Point to dest address
	mov si, [bp + 6]					; Point to src address

  @@cpy:
	mov al, [si]						; Transfer contents (at least one byte terminator)
	mov [di], al
	inc si
	inc di
	cmp byte ptr al, 0					; If source string is empty, quit out
	jne @@cpy
	
	mov ax, [bp + 4]					; Return dest address
	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_strcpy ENDP


; ------------------------------------------------------------------
; char *strncpy(char *dest, const char *src, size_t n)
; ------------------------------------------------------------------
; Coppy string in src to dest up to n chars.

_strncpy PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP   
	mov di, [bp + 4]					; Point to dest address
	mov si, [bp + 6]					; Point to src address
	
	xor cx, cx							; Store n in cx for loop

	.WHILE cx != [bp + 8]
		mov al, [si]					; Transfer contents (at least one byte terminator)
		mov [di], al
		inc si
		inc di
		inc cx
		.IF !al	
			.BREAK		  
		.ENDIF
	.ENDW

	mov ax, [bp + 4]					; Return dest address
	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_strncpy ENDP


; ------------------------------------------------------------------
; size_t strlen(const char *str)
; ------------------------------------------------------------------
; Get the length of the string.

_strlen PROC 
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP   
	mov si, [bp + 4]					; Point to param address str1
	
	xor cx, cx							; Store n in cx for loop

  @@loop:
	lodsb								; Get character from string
	or al, al							; End of string
	jz @@done
	inc cx
	jmp @@loop

  @@done:
    mov ax, cx

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
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

	cld									; Clear the temp_buffer
	lea di, temp_buffer
	mov cx, 128							; Repeat 128 times
	mov al, 0							; Clear with null (0)
	rep stosb     

	push di
	mov di, offset temp_buffer

  @@loop:
	lodsb								; Get character from string
	or al, al							; End of string
	jz @@done
	cmp al, [bp + 6]
	jne @@loop
	mov [di], byte ptr al
	inc di

  @@found:
   	lodsb								; Get character from string
	or al, al							; End of string
	jz @@done
	mov [di], byte ptr al
	inc di
	jmp @@found

  @@done:
	pop di
	mov ax, offset temp_buffer
	
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
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP   
	mov di, [bp + 4]					; Point to dest address
	mov si, [bp + 6]					; Point to source address

  @@inc:								; Find the end of the dest string
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

	mov ax, [bp + 4]					; Return value points to dest address
	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_strcat ENDP


; ------------------------------------------------------------------
; char *strncat(char *dest, const char *src, size_t n)
; ------------------------------------------------------------------
; The strncat function concatenates or appends first n characters
; from src to dest. All characters from src are copied including 
; the terminating null character.

_strncat PROC 
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP   
	mov di, [bp + 4]					; Point to dest address
	mov si, [bp + 6]					; Point to source address
	mov cx, [bp + 8]					; Point to n address

  @@inc:								; Find the end of the dest
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

	mov ax, [bp + 4]					; Return value points to dest address
	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_strncat ENDP


; ------------------------------------------------------------------
; void *memset(void *str, int c, size_t n)
; ------------------------------------------------------------------
; Copies the character c (an unsigned char) to the first n 
; characters of the string pointed to, by the argument str.
	  
_memset PROC 
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP   
	mov di, [bp + 4]					; Point to str address
	mov cx, [bp + 8]					; Point to n address

  @@append:
	mov al, [bp + 6]					; Move c into str n times
	mov [di], al
	inc di
	loop @@append

	mov ax, [bp + 4]					; Return value points to dest address
	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_memset ENDP


; ------------------------------------------------------------------
; void *memmove(void *dest, const void *src, size_t n)
; ------------------------------------------------------------------
; Copies n characters from src to dest.
	  
_memmove PROC 
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP   
	mov di, [bp + 4]					; Point to dest address
	mov si, [bp + 6]					; Point to src address
	mov cx, [bp + 8]					; Point to n address

  @@append:
	mov al, [si]					    ; Char from src to al
	mov [di], al						; Char from al moves into dest
	inc di
	inc si
	loop @@append

	mov ax, [bp + 4]					; Return value points to dest address
	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_memmove ENDP



; ------------------------------------------------------------------
; void *memcpy(void *dest, const void *src, size_t n)
; ------------------------------------------------------------------
; This function copies n characters from memory at src to the 
; memory area at the dest.
	  
_memcpy PROC 
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP   
	mov di, [bp + 4]					; Point to str1 address
	mov si, [bp + 6]					; Point to str2 address
	mov cx, [bp + 8]					; Point to n address

  @@cpy:
	mov al, [si]					   ; Transfer contents (at least one byte terminator)
	mov [di], al
	cmp al, 0
	je @@done
	inc si
	inc di
	inc cx
	loop @@cpy

  @@done:
	mov ax, [bp + 4]					; Return value points to dest address
	
	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_memcpy ENDP


; ------------------------------------------------------------------
; int memcmp(const void *str1, const void *str2, size_t n)
; ------------------------------------------------------------------
; Compares at most the first n bytes of str1 and str2.

_memcmp PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP   
	mov di, [bp + 4]					; Point to str1 address
	mov si, [bp + 6]					; Point to str2 address
	mov cx, [bp + 8]					; Point to n addres

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
	pop bp								; Restore BP register   
	ret
_memcmp ENDP


; ------------------------------------------------------------------
; void *memchr(const void *str, int c, size_t n)
; ------------------------------------------------------------------
; Searches for the first occurrence of the character c 
; (an unsigned char) in the first n bytes of the string 
; pointed to, by the argument str.

_memchr PROC
	push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP   
	mov si, [bp + 4]					; Point to param address str1

	cld									; Clear the temp_buffer
	lea di, temp_buffer
	mov cx, 512							; Repeat 128 times
	mov al, 0							; Clear with null (0)
	rep stosb     

	push di
	mov di, offset temp_buffer

  @@loop:
	lodsb								; Get character from string
	or al, al							; End of string
	jz @@done
	cmp al, [bp + 6]
	jne @@loop

	mov [di], al						; Add n to buffer and increase
	inc di

	mov cx, [bp + 8]				    ; Times to iterate
	cmp cx, 0
	jz @@done

  @@iterate:
   	lodsb								; Get character from string
	or al, al							; End of string
	jz @@done
	mov [di], al
	inc di
	loop @@iterate

  @@done:
	pop di
	mov ax, offset temp_buffer
	
	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_memchr ENDP

END