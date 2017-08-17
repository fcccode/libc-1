; ------------------------------------------------------------------
	.286					; CPU type
	.model tiny				; Tiny memoy model
	.data					; Start of data segment
	    txtc  db 15				; Text color
	    txtbg db 0				; Text background
	.code					; Start of code segment
; ------------------------------------------------------------------
; conio libary


 ColorAL MACRO
    pusha
   .IF !(al >= 09h && al <= 0dh)			    ; Ignore line feed and newline
	mov bl, txtbg					    ; Attribute (color)
	rol bl, 4					    ; Rotate left 4 bits
	or bl, txtc
	mov cx, 1					    ; Chars to print
	mov ah, 09h
	int	10h					    ; Video interupt

	mov bh, 0
	mov ah, 3					    ; Get cursor x and y
	int	10h					    ; Video interupt

	inc dl						    ; Increase x
	mov ah, 2					    ; Set cursor pos
	int	10h					    ; Video interupt
    .ELSE
         mov ah, 0eh
	 int	10h
    .ENDIF
     popa
 ENDM


; ------------------------------------------------------------------
; int getch(void)
; ------------------------------------------------------------------
; Gets a character (an unsigned char) input.

_getch PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP

    mov ah, 0
    int	    16h						    ; Keybord interupt
    xor ah, ah						    ; Clear higher-half of ax

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_getch ENDP


; ------------------------------------------------------------------
; int getche(void)
; ------------------------------------------------------------------
; Gets a character (an unsigned char) input and echo output.

_getche PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP

    mov ah, 0
    int	    16h						    ; Keybord interupt
    mov ah, 0eh						    ; Teletype output
    int     10h						    ; Video interupt
    xor ah, ah						    ; Clear higher-half of ax

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_getche ENDP


; ------------------------------------------------------------------
; int kbhit(void);
; ------------------------------------------------------------------
; Gets a character (an unsigned char) input and echo output.

_kbhit PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP

    mov ah, 0
    int	    16h						    ; Keybord interupt
    mov ax, 1						    ; Return true

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_kbhit ENDP


; ------------------------------------------------------------------
; int putch(int c)
; ------------------------------------------------------------------
; Writes a character (an unsigned char) specified
; by the argument char to stdout.

_putch PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP

    mov ax, [bp + 4]					    ; Move char into ax
    mov ah, 0eh						    ; Teletype output

    .IF al == 0dh					    ; Newline on enter
	int	10h					    ; Video interupt
	mov al, 0ah					    ; Line feed
	int	10h					    ; Video interupt
    .ELSE
	int	10h					    ; Video interupt
    .ENDIF

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_putch ENDP


; ------------------------------------------------------------------
; int ungetch(int c)
; ------------------------------------------------------------------
; Pushes a character back into the keyboard buffer.

_ungetch PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP

    mov ax, [bp + 4]					    ; Move char into ax
    mov ah, 5						    ; Keybord buffer write
    mov cl, al						    ; Char to write into buffer
    int	    16h						    ; Keyboard interupt

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_ungetch ENDP


; ------------------------------------------------------------------
; int clrscr()
; ------------------------------------------------------------------
; This function clears the screen.

_clrscr PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP

    mov al, 02h
    mov ah, 00h
    int	10h						    ; Video interupt

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_clrscr ENDP


; ------------------------------------------------------------------
; void gotoxy(int x, int y)
; ------------------------------------------------------------------
; This function moves the cursor to a new pos.

_gotoxy PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP

    mov dl, [bp + 4]					    ; xpos
    mov dh, [bp + 6]					    ; ypos
    mov bh, 0
    mov ah, 2
    int 10h						    ; Video interupt

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_gotoxy ENDP


; ------------------------------------------------------------------
; void highvideo(void)
; ------------------------------------------------------------------
; This function sets high intensity bits for the current
; foreground color.

_highvideo PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP
    mov	al, txtc					    ; Get text color

    .IF al <= 7						    ; Set to high intensity bit if less than or equal to 7
	add al, 8
    .ENDIF

    mov	txtc, al					    ; Store text color

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_highvideo ENDP


; ------------------------------------------------------------------
; void lowvideo(void)
; ------------------------------------------------------------------
; This function sets low intensity bits for the current
; foreground color.

_lowvideo PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP
    mov	al, txtc					    ; Get text color

    .IF al >= 7						    ; Set to low intensity bit if greater than or equal to 7
	sub al, 8
    .ENDIF

    mov	txtc, al					    ; Store text color

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_lowvideo ENDP


; ------------------------------------------------------------------
; void insline(void)
; ------------------------------------------------------------------
; A blank line is inserted at the current cursor position.
; The previous line and lines below it scroll down.


_insline PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP

    mov ah, 0eh						    ; Teletype output
    mov al, 0dh						    ; Carriage return
    int	    10h						    ; Video interupt
    mov al, 0ah						    ; Line feed
    int	    10h

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_insline ENDP

; ------------------------------------------------------------------
; int wherex(void)
; ------------------------------------------------------------------
; This function returns the cursor x pos.

_wherex PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP

    mov bh, 0
    mov ah, 3
    int	    10h						    ; Video interupt

    mov ah, 0
    mov al, dl

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_wherex ENDP


; ------------------------------------------------------------------
; int wherey(void)
; ------------------------------------------------------------------
; This function returns the cursor y pos.

_wherey PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP

    mov bh, 0
    mov ah, 3
    int	    10h						    ; Video interupt

    mov ah, 0
    mov al, dh

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_wherey ENDP


; ------------------------------------------------------------------
; int cputs(const char * str)
; ------------------------------------------------------------------
; Returns a string to the screen.

_cputs PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP
    pusha
    mov si, [bp + 4]					    ; Point to param address

  @@puts:
    lodsb						    ; Get character from string
    or al, al						    ; End of string
    jz @@done
    ColorAL
    jmp @@puts

  @@done:
    popa
    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_cputs ENDP


 ; ------------------------------------------------------------------
; int cputsxy(int x, int y, const char * str)
; ------------------------------------------------------------------
; Returns a string to the screen at the specified pos

_cputsxy PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP
    pusha
    mov ax, [bp + 4]
    mov bx, [bp + 6]
    push bx
    push ax
    call _gotoxy
    pop ax
    pop bx
    mov si, [bp + 8]					    ; Point to string address

  @@puts:
    lodsb						    ; Get character from string
    or al, al						    ; End of string
    jz @@done
    ColorAL
    jmp @@puts

  @@done:
    popa
    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_cputsxy ENDP


; ------------------------------------------------------------------
; int cprintf(const char *format, ...)
; ------------------------------------------------------------------
; Sends formatted output to stdout.

_cprintf PROC uses ax
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP
    mov di, 6
    mov si, [bp + di]					    ; Point to param address
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
		    ColorAL
		.UNTIL 0
		pop si
		.CONTINUE
	    .ELSEIF al == 'c'				    ; Format char
		mov ax,  si
		ColorAL
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
		    ColorAL
		.UNTILCXZ
		pop si
		.CONTINUE
	    .ENDIF
	.ENDIF
	ColorAL
    .UNTIL 0
    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_cprintf ENDP

  ; ------------------------------------------------------------------
; int cscanf(const char *format, ...);
; ------------------------------------------------------------------
; Reads formatted input from stdin.

_cscanf PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP
    mov si, [bp + 4]					    ; Point to param address
    .IF BYTE PTR [si] == '%'
	.IF BYTE PTR [si + 1] == 's'
	    mov di, [bp + 6]				    ; Point to param address
	    xor cl, cl
	    .REPEAT
		mov ah, 0
		int	16h				    ; Wait for keypress
		.IF al == 08h				    ; Handle backspace
		    .CONTINUE .IF !cl			    ; No overwrite prompt
		    dec di				    ; Move back a char
		    mov BYTE PTR [di], 0		    ; Remove char
		    dec cl				    ; Decrease char counter
		    mov ah, 0eh				    ; Teletype output
		    mov al, 08h				    ; Backspace
		    int	    10h				    ; Video interupt
		    mov al, ' '				    ; Fill with blank char
		    int     10h				    ; Video interupt
		    mov al, 08h				    ; Backspace
		    int     10h				    ; Video interupt
		    .CONTINUE
		.ELSEIF al == 0dh			    ; Handle enter
		    .BREAK
		.ELSEIF cl == 3dh			    ; Max input allowed
		    .BREAK
		.ENDIF
		ColorAL
		stosb					    ; Store string
		inc cl
	    .UNTIL 0
	.ELSEIF BYTE PTR [si + 1] == 'c'
	    mov di, [bp + 6]				    ; Point to param address
	    mov ah, 0
	    int	16h					    ; Wait for keypress
	    mov ah, 0eh					    ; Teletype output
	    int	10h					    ; Video interupt
	    stosb					    ; Store string
	.ELSEIF BYTE PTR [si + 1] == 'd'
	.ENDIF
    .ENDIF

    mov ah, 0eh						    ; Teletype output
    mov al, 0dh						    ; Carriage return
    int	    10h						    ; Video interupt
    mov al, 0ah						    ; Line feed
    int	    10h						    ; Video interupt

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_cscanf ENDP


; ------------------------------------------------------------------
; void textbackground(int color)
; ------------------------------------------------------------------
; Change of current background color in text mode.

_textbackground PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP

    mov al, [bp + 4]					    ; Move color to al
    mov	txtbg, al					    ; Set text background color to al

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_textbackground ENDP


; ------------------------------------------------------------------
; void textcolor(int color)
; ------------------------------------------------------------------
; change the color of drawing text where color is a integer variable.

_textcolor PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP

    mov al, [bp + 4]					    ; Move color to al
    mov	txtc, al					    ; Set text color to al

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_textcolor ENDP

; MOVE BELOW FUNCTIONS TO A FILE CALLED BIOS.ASM & BIOS.H





; ------------------------------------------------------------------
; void cursoroff(void)
; ------------------------------------------------------------------
; This function turns the cursor off

_cursoroff PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP

	mov ch, 32
	mov ah, 1
	mov al, 3
	int 10h

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register
	ret
_cursoroff ENDP



; ------------------------------------------------------------------
; void cursoron(void)
; ------------------------------------------------------------------
; This function turns the cursor on

_cursoron PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP

	mov ch, 6
	mov cl, 7
	mov ah, 1
	mov al, 3
	int 10h

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register
	ret
_cursoron ENDP


; ------------------------------------------------------------------
; void delay(int ms)
; ------------------------------------------------------------------
; This function delays the program

_delay PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP
	mov cx, [bp + 4]					; ms delay

	mov dx, 4240h
	mov ah, 86h
	int 15h

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register
	ret
_delay ENDP


; ------------------------------------------------------------------
; void draw_line(int x, int y, int len)
; ------------------------------------------------------------------
; This function moves the cursor to a new pos

_drawline PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP


	push [bp + 4]						; Xpos
	push [bp + 6]						; Ypos
	call _gotoxy

    mov ah, 09h
	mov bh, 0
	mov cx, [bp + 8]
	mov bl, 70h							; Black text on white background
	mov al, ' '
	int 10h

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register
	ret
_drawline ENDP










; ------------------------------------------------------------------
; void newline(void)
; ------------------------------------------------------------------
; This function writes a new line

_newline PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP

    mov ah, 0eh							; Teletype output
    mov al, 0dh							; Carriage return
    int		10h							; Video interupt
    mov al, 0ah							; Line feed
    int		10h							; Video interupt

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register
	ret
_newline ENDP







; ------------------------------------------------------------------
; void setcursortype(iunt type)
; ------------------------------------------------------------------
; This function moves the cursor to a new pos

_setcursortype PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP

	mov ch,  [bp + 4]
	mov cl, 7
	mov ah, 1
	mov al, 3
	int 10h


	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register
	ret
_setcursortype ENDP




END