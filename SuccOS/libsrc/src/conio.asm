; ------------------------------------------------------------------
  	.286					; CPU type
	.model tiny				; Tiny memoy model
	.data					; Start of data segment
	    txtc  db 1				; Text color
	    txtbg db 0				; Text background
	.code					; Start of code segment
; ------------------------------------------------------------------
; conio libary


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
; int cputs(const char * str)
; ------------------------------------------------------------------
; Returns a string to the screen.

_cputs PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP
    mov si, [bp + 4]					    ; Point to param address

    xor cx, cx						    ; Store len of string in cx

  @@len:
    lodsb						    ; Get character from string
    or al, al						    ; End of string
    jz @@puts
    inc cx
    jmp @@len

  @@puts:
    push bp						    ; Preserve bp
    mov al, 1						    ; Assign all characters the attribute in BL, update cursor
;    mov bh, page					    ; Page
    mov bl, txtbg					    ; Attribute (color)
    rol bl, 4						    ; Rotate left 4 bits
    or bl, txtc						    ; Bitwise or
;    mov dl, column					    ; Column
;    mov dh, row					    ; Row
    mov bp, [bp + 4]					    ; String
    mov	ah, 13h						    ; Write string
    int     10h						    ; Video interupt
    pop bp						    ; Restore destroyed bp

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_cputs ENDP


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
; int clrscr(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character
; is a hexadecimal digit.

_clrscr PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP

	mov al, 02h
	mov ah, 00h
    int		10h

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register
	ret
_clrscr ENDP



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
; void gotoxy(char x, char y)
; ------------------------------------------------------------------
; This function moves the cursor to a new pos

_gotoxy PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP

	mov dl, [bp + 4]					; xpos
	mov dh, [bp + 6]					; ypos
	mov bh, 0
	mov ah, 2
	int 10h								; BIOS interrupt to move cursor

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register
	ret
_gotoxy ENDP



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


; ------------------------------------------------------------------
; int wherex(void)
; ------------------------------------------------------------------
; This function moves the cursor to a new pos

_wherex PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP

	mov bh, 0
	mov ah, 3
	int		10h							; Video interupt

	mov ah, 0
	mov al, dl

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register
	ret
_wherex ENDP


; ------------------------------------------------------------------
; int wherey(void)
; ------------------------------------------------------------------
; This function returns the cursor y pos

_wherey PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP

	mov bh, 0
	mov ah, 3
	int		10h							; Video interupt

	mov ah, 0
	mov al, dh

	mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register
	ret
_wherey ENDP



END