; ------------------------------------------------------------------
	.286								; CPU type
	.model tiny							; Tiny memoy model
	.data								; Data segment
		error_msg db "Error: ", 0
		error_end db " failed.", 0
				temp db 10 dup(?)				; Temp var 

	.code								; Start of code segment
; ------------------------------------------------------------------
  ssp proc	  uses si

 @@decimal:
		mov ax, si
		pusha
		mov cx, 0
		mov bx, 10						; Set BX 10, for division and mod
		mov di, offset temp				; Get our temp var ready

		@@push:
			mov dx, 0
			div bx						; Remainder in DX, quotient in AX
			inc cx						; Increase pop loop counter
			push dx						; Push remainder, so as to reverse order when popping
			test ax, ax					; Is quotient zero?
			jnz @@push					; If not, loop again

		@@pop:
			pop dx						; Pop off values in reverse order, and add 48 to make them digits
			add dl, 48					; And save them in the string, increasing the pointer each time
			mov [di], dl
			inc di
			dec cx
			jnz @@pop
			mov byte ptr [di], 0		; Zero-terminate string
			popa
			mov si, offset temp			; Return location of string
	@@string:
	lodsb
	or al, al							; End of param string
	jz @@done
	mov ah, 0eh							; Teletype output	
	int     10h							; Video interupt
	jmp @@string

  @@done:
  ret
ssp endp
p proc	  uses si
@@string:
	lodsb
	or al, al							; End of param string
	jz @@done
	mov ah, 0eh							; Teletype output	
	int     10h							; Video interupt
	jmp @@string
  @@done:
    ret
p endp 
; ------------------------------------------------------------------
;
; ------------------------------------------------------------------
;		printf("Error: %s:%d: `%s` failed.", file, line, e);

__assert PROC 
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP    
	mov si, offset error_msg
	call p

 	mov si, [bp + 4]					; File name
	call p
	mov al, ':'
	mov ah, 0eh							; Teletype output	
	int     10h							; Video interupt

	mov si, [bp + 6]					; Line number
	call ssp
	mov al, ':'
	mov ah, 0eh							; Teletype output	
	int     10h							; Video interupt
	
	mov al, ' '
	mov ah, 0eh							; Teletype output	
	int     10h							; Video interupt
	mov al, '`'
	mov ah, 0eh							; Teletype output	
	int     10h							; Video interupt
	mov si, [bp + 8]					; param
	call p
	mov al, '`'
	mov ah, 0eh							; Teletype output	
	int     10h							; Video interupt

	mov si, offset error_end
	call p

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
__assert ENDP

end