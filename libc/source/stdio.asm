; ------------------------------------------------------------------
.model tiny, c							; Small memoy model
.386								; 80386 CPU
 include stdio.inc					; Include library headers
.data								; Data segment
 temp db 10 dup(?)						; Temp var
.code								; Start of code segment
; ------------------------------------------------------------------
outp PROC uses ax dx port:PTR BYTE, data:BYTE
    mov dx, port
    mov al, data
    out dx, al
    ret
outp ENDP

outportp PROC uses ax dx port:PTR BYTE, data:BYTE
    mov dx, port
    mov al, data
    out dx, al
    ret
outportp ENDP

outw PROC uses ax dx port:WORD, data:WORD
    mov dx, port
    mov ax, data
    out dx, ax
    ret
outw ENDP

outportw PROC uses ax dx port:WORD, data:WORD
    mov dx, port
    mov ax, data
    out dx, ax
    ret
outportw ENDP
; ------------------------------------------------------------------
; int printf(const char *format, ...)
; ------------------------------------------------------------------
; Sends formatted output to stdout.

printf PROC uses di si ax bx cx dx format:WORD, args:VARARG

    mov di, 4
    mov si, format					    ; Point to param address
    .REPEAT						    ; Iterate over string
	lodsb						    ; Get character from string
	.BREAK .IF !al					    ; Break if not al
	.IF al == '%'					    ; Format string identifyer
	    lodsb
	    push si					    ; Store current string
	    add di, 2					    ; Add to param offset
	    mov si, [bp + di]				    ; Point to param address
	    .IF al == 's'				    ; Format string
		.REPEAT
		    lodsb
		    .BREAK .IF !al
		    mov ah, 0eh				    ; Teletype output
		    int     10h				    ; Video interupt
		.UNTIL 0
		pop si
		.CONTINUE
	    .ELSEIF al == 'x'				    ; Format hex
		push si
		push bx
		mov di, offset outstr16
		mov ax, si
		mov si, offset hexstr
		mov cx, 4
		.REPEAT
		    rol ax, 4				    ; leftmost will
		    mov bx, ax				    ; become
		    and bx, 0fh				    ; rightmost
		    mov bl, [si + bx]			    ; Index into hexstr
		    mov [di], bl
		    inc di
		.UNTILCXZ
		mov si, offset outstr16
		pop bx
		.REPEAT
		    lodsb
		    .BREAK .IF !al
		    mov ah, 0eh				    ; Teletype output
		    int     10h				    ; Video interupt
		.UNTIL 0
		pop si
		pop si
		.CONTINUE
	    .ELSEIF al == 'c'				    ; Format char
		mov ax,  si
		mov ah, 0eh				    ; Teletype output
		int     10h				    ; Video interupt
		pop si
	    	.CONTINUE
	    .ELSEIF al == 'd'				    ; Format decimal
	       	mov ax,  si
		mov cx, 0
		mov bx, 10				    ; Set BX 10, for division and mod
		.REPEAT
	    	    mov dx, 0
		    div bx				    ; Remainder in DX, quotient in AX
		    inc cx				    ; Increase pop loop counter
		    push dx				    ; Push remainder, so as to reverse order when popping
		.UNTIL !ax
		.REPEAT
		    pop dx				    ; Pop off values in reverse order, and add 48 to make them digits
		    add dl, 48				    ; And save them in the string, increasing the pointer each time
		    mov al, dl				    ; Print out the number
		    mov ah, 0eh				    ; Teletype output
		    int     10h				    ; Video interupt
		.UNTILCXZ
		pop si
		.CONTINUE
	    .ENDIF
	.ENDIF
	mov ah, 0eh					    ; Teletype output
	int     10h					    ; Video interupt
    .UNTIL 0
    ret
printf ENDP


; ------------------------------------------------------------------
; int scanf(const char *format, ...);
; ------------------------------------------------------------------
; Reads formatted input from stdin.

scanf PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov si, [bp + 4]						; Point to param address

    .IF BYTE PTR [si] == '%'
	.IF BYTE PTR [si + 1] == 's'
	    jmp @@string
	.ELSEIF BYTE PTR [si + 1] == 'c'
	    jmp @@char
	.ELSEIF BYTE PTR [si + 1] == 'd'
	    jmp @@decimal
	.ELSE
	    @@error: jmp @@error
	.ENDIF
    .ELSE
	    @error: jmp @error
    .ENDIF
      @@string:
		mov di, [bp + 6]				; Point to param address
		xor cl, cl
      @@input_loop:
		mov ah, 0
		int	16h	    				; Wait for keypress
		cmp al, 08h					; Handle backspace
		je @@backspace
		cmp al, 0dh					; Handle enter
		je @@done
		cmp cl, 3fh					; Handle max input buffer
		je @@done

		mov ah, 0eh					; Teletype output
		int	10h					; Video interupt

		stosb						; Store string
		inc cl
		jmp @@input_loop

	  @@backspace:
		cmp cl, 0					; Start of string
		je @@input_loop
		dec di
		mov BYTE PTR [di], 0				 ; Remove char
		dec cl						; Decrease char counter
		mov ah, 0eh					; Teletype output
		mov al, 08h					; Backspace
		int	10h					; Video interupt
		mov al, ' '					; Fill with blank char
		int     10h					; Video interupt
		mov al, 08h					; Backspace
		int     10h					; Video interupt
		jmp @@input_loop

	@@char:
		mov di, [bp + 6]				; Point to param address
		mov ah, 0
		int	16h					; Wait for keypress
		mov ah, 0eh					; Teletype output
		int	10h					; Video interupt
		stosb						; Store string
		jmp @@done

	@@decimal:

  @@done:
    mov ah, 0eh							; Teletype output
    mov al, 0dh							; Carriage return
    int	    10h							; Video interupt
    mov al, 0ah							; Line feed
    int	    10h							; Video interupt

    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
scanf ENDP


; ------------------------------------------------------------------
; int getchar(void)
; ------------------------------------------------------------------
; Gets a character (an unsigned char) from stdin.

getchar PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP

    mov ah, 0
    int	    16h							; Keybord interupt
    xor ah, ah							; Clear higher-half of ax

    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
getchar ENDP


; ----------------------------------------------------------------
; char *gets(char *str)
; ------------------------------------------------------------------
; Reads a line from stdin and stores it into the
; string pointed to by, str. It stops when either
; the newline character is read or when the end-of-file
; is reached, whichever comes first.

gets PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov di, [bp + 4]						; Point to param address

    xor cl, cl
  @@input_loop:
    mov ah, 0
    int		16h						; Wait for keypress
    cmp al, 08h							; Handle backspace
    je @@backspace
    cmp al, 0dh							; Handle enter
    je @@done
    cmp cl, 3fh							; Handle max input buffer
    je @@done

    mov ah, 0eh							; Teletype output
    int	10h							; Video interupt

    stosb							; Store string
    inc cl
    jmp @@input_loop

  @@backspace:
    cmp cl, 0							; Start of string
    je @@input_loop
    dec di
    mov byte ptr [di], 0					; Remove char
    dec cl							; Decrease char counter
    mov ah, 0eh							; Teletype output
    mov al, 08h							; Backspace
    int	    10h							; Video interupt
    mov al, ' '							; Fill with blank char
    int     10h							; Video interupt
    mov al, 08h							; Backspace
    int     10h							; Video interupt
    jmp @@input_loop

  @@done:

    mov ah, 0eh							; Teletype output
    mov al, 0dh							; Carriage return
    int	    10h							; Video interupt
    mov al, 0ah							; Line feed
    int	    10h							; Video interupt

    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
gets ENDP


; ------------------------------------------------------------------
; int putchar(int char)
; ------------------------------------------------------------------
; Writes a character (an unsigned char) specified
; by the argument char to stdout.

putchar PROC uses ax
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP

    mov ax, [bp + 4]						; Move char into ax
    mov ah, 0eh							; Teletype output
    int	    10h							; Video interupt

    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
putchar ENDP


; ------------------------------------------------------------------
; int puts(const char *str)
; ------------------------------------------------------------------
; Writes a string to stdout up to but not including
; the null character. A newline character is appended
; to the output.

puts PROC C uses ax si string:WORD
    mov si, string						; Point to param address

  @@string:
    lodsb
    or al, al							; End of param string
    jz @@done
    mov ah, 0eh							; Teletype output
    int     10h							; Video interupt
    jmp @@string

  @@done:
    mov ah, 0eh							; Teletype output
    mov al, 0dh							; Carriage return
    int	    10h							; Video interupt
    mov al, 0ah							; Line feed
    int	    10h							; Video interupt
    							; Restore BP register
    ret
puts ENDP


END
