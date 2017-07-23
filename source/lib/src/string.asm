
  	.286								; CPU type
	.model tiny							; Tiny memoy model
	.code								; Start of code segment



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
		.BREAK .IF al != bl				; Both bytes equal before null?
		.BREAK .IF !al
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
		.BREAK .IF al != bl				; Both bytes equal before null?
		.BREAK .IF !al
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

END