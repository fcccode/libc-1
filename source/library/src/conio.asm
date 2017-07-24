; ------------------------------------------------------------------
	.286								; CPU type
	.model tiny							; Tiny memoy model
	.code								; Start of code segment
; ------------------------------------------------------------------
; conio libary


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
; int getch(void)
; ------------------------------------------------------------------
; Gets a character (an unsigned char) from stdin.

_getch PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP     

	mov ah, 0
	int		16h							; Keybord interupt
	xor ah, ah							; Clear higher-half of ax

    mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_getch ENDP


	 
; ------------------------------------------------------------------
; int getche(void)
; ------------------------------------------------------------------
; Gets a character (an unsigned char) from stdin and echo.

_getche PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP     

	mov ah, 0
	int		16h							; Keybord interupt
	mov ah, 0eh							; Teletype output	
	int     10h							; Video interupt

    mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_getche ENDP




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
; void setbackground(int color)
; ------------------------------------------------------------------
; Gets a character (an unsigned char) from stdin and echo.

_setbackground PROC
    push bp								; Save BP on stack
    mov bp, sp							; Set BP to SP     
	
	mov	dx, 0							 ; Set screen colors
	mov	ah, 09h 
	mov	al, ' '
	mov	bh, 0
	mov	bl, [bp + 4]	                ; Bg | sText color
	mov	cx, 2400
	int     10h							; Video interupt

    mov sp, bp							; Restore stack pointer
	pop bp								; Restore BP register   
	ret
_setbackground ENDP




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