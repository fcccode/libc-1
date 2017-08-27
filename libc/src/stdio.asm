; ------------------------------------------------------------------
.model tiny, c							; Small memoy model
.386								; 80386 CPU
include libc.inc						; Include library headers
extern BootDrive:far
.data								; Data segment
dirlist db 60 dup(?)
 temp db 10 dup(?)						; Temp var
.code								; Start of code segment
; ------------------------------------------------------------------




; --------------------------------------------------------------------------
; convert_sector -- Calculate head, track and sector for int 13h
; IN: AX = logical sector
; OUT: correct registers for int 13h

convert_sector proc
	push bx
	push ax
	mov bx, ax                  ; Save logical sector
	mov dx, 18                   ; First the sector
	div bx	    ; Sectors per track
	add	dl, 01h                 ; Physical sectors start at 1
	mov	cl, dl                  ; Sectors belong in CL for int 13h
	mov	ax, bx
	mov	dx, 18                   ; Calculate the head
	div bx  ; Sectors per track
	mov	dx, 2
	div bx            ; Floppy sides
	mov	dh, dl                  ; Head/side
	mov	ch, al                  ; Track
	pop	ax
	pop	bx
	mov	dx, [BootDrive]
	ret
convert_sector endp
; ------------------------------------------------------------------
; reset_floppy -- Reset the floppy disk on error
; IN: Nothing
; OUT: Carry flag on error

reset_floppy proc
    push ax
    push dx

    mov	ax, 0
    mov	dx, [BootDrive]

    stc
    int	13h
    pop dx
    pop ax
    ret
reset_floppy ENDp

; ------------------------------------------------------------------
; int printf(const char *format, ...)
; ------------------------------------------------------------------
; Sends formatted output to stdout.

printf PROC uses ax
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
    mov di, 6
    mov si, [bp + di]						; Point to param address

  @@loop:
	lodsb							; Get character from string
	or al, al						; End of string
	jz @@done
	cmp al, '%'
	je @@switch
	mov ah, 0eh						; int 10h 'print char' function
	int     10h						; Otherwise, print it
	jmp @@loop

	@@switch:
		lodsb
		push si						; Store current string
		add di, 2					; Add to param offset
		mov si, [bp + di]				; Point to param address

		cmp al, 's'					; String
		je @@string
		cmp al, 'c'					; Character
		je @@char
		cmp al, 'd'					; Decimal integer
		je @@decimal

	  @@switch_end:
	  	pop si
		jmp @@loop

	  @@string:
		lodsb
		or al, al					; End of param string
		jz @@switch_end
		mov ah, 0eh					; Teletype output
		int     10h					; Video interupt
		jmp @@string

	  @@char:
		mov ax,  si
		mov ah, 0eh					; Teletype output
		int     10h					; Video interupt
		jmp @@switch_end

	  @@decimal:
		mov ax, si
		pusha
		mov cx, 0
		mov bx, 10					; Set BX 10, for division and mod

		@@push:
			mov dx, 0
			div bx					; Remainder in DX, quotient in AX
			inc cx					; Increase pop loop counter
			push dx					; Push remainder, so as to reverse order when popping
			test ax, ax				; Is quotient zero?
			jnz @@push				; If not, loop again

		@@pop:
			pop dx					; Pop off values in reverse order, and add 48 to make them digits
			add dl, 48				; And save them in the string, increasing the pointer each time
			mov al, dl
			mov ah, 0eh				; Teletype output
			int     10h
			dec cx
			jnz @@pop
			popa
			jmp @@switch_end			; Print temp

  @@done:
    mov sp, bp							; Restore stack pointer
	pop bp							; Restore BP register
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

puts PROC C uses ax string:WORD
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
