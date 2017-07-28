; ------------------------------------------------------------------
	.286								; CPU type
	.model tiny							; Tiny memoy model
	.code								; Start of code segment
; ------------------------------------------------------------------


; ------------------------------------------------------------------
; int isalnum(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character 
; is alphanumeric or not. 
							 
_isalnum PROC uses si
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP     
	mov ax, [bp + 6]

	.IF ax >= 48 && ax <= 57 			; If input is a digit return 4
   		mov ax, 4						
	.ELSEIF ax >= 65 && ax <= 90		; If input is uppercase char return 1
		mov ax, 1						
	.ELSEIF ax >= 97 && ax <= 122		; If input is lowercase char return 2
		mov ax, 2						
	.ELSE
		mov ax, 0						; Return 0 on non alphanumeric
	.ENDIF
	
	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_isalnum ENDP



; ------------------------------------------------------------------
; int isalpha(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character is alphabetic.

_isalpha PROC uses si
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP     
	mov ax, [bp + 6]
	
	.IF ax >= 65 && ax <= 90			; If input is uppercase char return 1
		mov ax, 1						
	.ELSEIF ax >= 97 && ax <= 122		; If input is lowercase char return 2
		mov ax, 2						
	.ELSE
		mov ax, 0						; Return 0 on non alphanumeric
	.ENDIF

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_isalpha ENDP



; ------------------------------------------------------------------
; int iscntrl(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character is control character.

_iscntrl PROC uses si
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP     
	mov ax, [bp + 6]
	
	.IF ax >= 0 && ax <= 31				; If input is control character return 32 
		mov ax, 32						
	.ELSEIF ax == 127					; If input is control character return 32 
		mov ax, 32						
	.ELSEIF ax == 256					; If input is control character return 32 
		mov ax, 32						
	.ELSE
		mov ax, 0						; Return 0 on non control character
	.ENDIF

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_iscntrl ENDP



; ------------------------------------------------------------------
; int isdigit(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character is decimal digit.

_isdigit PROC uses si
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP     
	mov ax, [bp + 6]
	
	.IF ax >= 48 && ax <= 57			; If input is control character return 32 
		mov ax, 1						
	.ELSE
		mov ax, 0						; Return 0 on non control character
	.ENDIF

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_isdigit ENDP



; ------------------------------------------------------------------
; int isgraph(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character is decimal digit.

_isgraph PROC uses si
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP     
	mov ax, [bp + 6]
	
	.IF ax >= 33 && ax <= 47			
		mov ax, 16			
	.ELSEIF ax >= 48 && ax <= 57		
		mov ax, 4		
	.ELSEIF ax >= 58 && ax <= 64		
		mov ax, 16		
	.ELSEIF ax >= 65 && ax <= 90		
		mov ax, 1
	.ELSEIF ax >= 91 && ax <= 96		
		mov ax, 16
	.ELSEIF ax >= 97 && ax <= 122		
		mov ax, 2
	.ELSEIF ax >= 123 && ax <= 126		
		mov ax, 16
	.ELSE
		mov ax, 0						
	.ENDIF

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_isgraph ENDP



; ------------------------------------------------------------------
; int islower(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character is 
; a lowercase letter.

_islower PROC uses si
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP     
	mov ax, [bp + 6]
	
	.IF ax >= 97 && ax <= 122			; If input is lowercase char return 2
		mov ax, 2						
	.ELSE
		mov ax, 0						; Return 0 on non lowercase
	.ENDIF

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_islower ENDP



; ------------------------------------------------------------------
; int isprint(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character 
; is \is a printable char 

_isprint PROC uses si
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP     
	mov ax, [bp + 6]

	.IF ax == 32						; If input is a special char return 32
		mov ax, 64
	.ELSEIF ax >= 33 && ax <= 47		; If input is a special char return 16
		mov ax, 16
	.ELSEIF ax >= 48 && ax <= 57 		; If input is a digit return 4
   		mov ax, 4	
	.ELSEIF ax >= 58 && ax <= 64		; If input is a special char return 16
		mov ax, 16						
	.ELSEIF ax >= 65 && ax <= 90		; If input is lowercase char return 1
		mov ax, 1						
	.ELSEIF ax >= 91 && ax <= 96		; If input is a special char return 16
		mov ax, 16						
	.ELSEIF ax >= 97 && ax <= 122		; If input is uppercase char return 2
		mov ax, 2
	.ELSEIF ax >= 123 && ax <= 126		; If input is a special char return 16
		mov ax, 16		
	.ELSE
		mov ax, 0						; Return 0 on non printable char
	.ENDIF
	
	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_isprint ENDP



; ------------------------------------------------------------------
; int ispunct(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character 
; is a punctuation character.

_ispunct PROC uses si
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP     
	mov ax, [bp + 6]

	.IF ax >= 33 && ax <= 47			; If input is punctuation return 16
		mov ax, 16
	.ELSEIF ax >= 58 && ax <= 64		; If input is punctuation return 16
		mov ax, 16						
	.ELSEIF ax >= 91 && ax <= 96		; If input is punctuation return 16
		mov ax, 16						
	.ELSEIF ax >= 123 && ax <= 126		; If input is punctuation return 16
		mov ax, 16		
	.ELSE
		mov ax, 0						; Return 0 on non printable char
	.ENDIF
	
	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_ispunct ENDP



; ------------------------------------------------------------------
; int isspace(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character is white-space.

_isspace PROC uses si
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP     
	mov ax, [bp + 6]

	.IF ax >= 9 && ax <= 13				; If input is white-space return 16
		mov ax, 8
	.ELSEIF ax == 32					; If input is white-space return 16
		mov ax, 8		
	.ELSE
		mov ax, 0						; Return 0 on non printable char
	.ENDIF
	
	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_isspace ENDP



; ------------------------------------------------------------------
; int isupper(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character 
; is an uppercase letter.

_isupper PROC uses si
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP     
	mov ax, [bp + 6]

	.IF ax >= 65 && ax <= 90			; If input is uppercase char return 1
		mov ax, 1
	.ELSE
		mov ax, 0						; Return 0 on non uppercase
	.ENDIF
	
	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_isupper ENDP



; ------------------------------------------------------------------
; int isxdigit(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character 
; is a hexadecimal digit.

_isxdigit PROC uses si
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP     
	mov ax, [bp + 6]

	.IF ax >= 48 && ax <= 57			; If input is a hexadecimal digit return 128
		mov ax, 128
	.ELSEIF ax >= 65 && ax <= 70		; If input is a hexadecimal digit return 128
		mov ax, 128
	.ELSEIF ax >= 97 && ax <= 102		; If input is a hexadecimal digit return 128
		mov ax, 128
	.ELSE
		mov ax, 0						; Return 0 on non uppercase
	.ENDIF

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_isxdigit ENDP



; ------------------------------------------------------------------
; int tolower(int c)
; ------------------------------------------------------------------
; This function converts uppercase letters to lowercase.

_tolower PROC uses si
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP     
	mov ax, [bp + 6]

	.IF ax >= 65 && ax <= 90			
		add ax, 32
	.ENDIF

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_tolower  ENDP



; ------------------------------------------------------------------
; int toupper(int c)
; ------------------------------------------------------------------
; This function converts lowercase letters to uppercase .

_toupper PROC uses si
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP     
	mov ax, [bp + 6]

	.IF ax >= 97 && ax <= 122			
		sub ax, 32
	.ENDIF

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_toupper  ENDP



END