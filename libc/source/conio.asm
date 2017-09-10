;---------------------------------------------------
;
; Details
; ----------------------------------
; This file is part of a 16 bit	C library devoloped for
; hobby os devolopment, by Joshua Riek, 2017. The file
; conio.asm is an replica of an old MS-DOS header used
; to create text user interfaces.
;
; Copyright 2017 Joshua Riek. No part of this file may be
; reproduced, in any form or by any other means, without
; permission in writing from the author.
;
; TODO
; ----------------------------------
; Clean up cprintf, cscanf, colorPrint.
;
; Available Procedures
; ----------------------------------
; getch
; getche
; kbhit
; putch
; ungetch
; clrscr
; gotoxy
; highvideo
; lowvideo
; isline
; wherex
; wherey
; cputs
; cputsxy
; textbackground
; textcolor
; cursoroff
; cursoron
; delay
; newline
; cprintf
; cscanf
;
;---------------------------------------------------

.model tiny, C					; Small memoy model
.386						; 80386 CPU
.code

;---------------------------------------------------
getch PROC C
;
; Summary: Gets and returns a character.
;
; Params:  None
;
; Returns: Char hit
;
; Date: 9/6/2017
;---------------------------------------------------
    mov ah, 0
    int	    16h					; Keybord interupt
    xor ah, ah					; Clear higher-half of ax

    ret
getch ENDP


;---------------------------------------------------
getche PROC C
;
; Summary: Gets a char and writes it to the screen.
;
; Params:  None
;
; Returns: Char hit
;
; Date: 9/6/2017
;---------------------------------------------------
    mov ah, 0
    int	    16h					; Keybord interupt
    mov ah, 0eh					; Teletype output
    int     10h					; Video interupt
    xor ah, ah					; Clear higher-half of ax

    ret
getche ENDP


;---------------------------------------------------
kbhit PROC C
;
; Summary: Has a key been pressed?
;
; Params:  None
;
; Returns: 1 if key hit
;
; Date: 9/6/2017
;---------------------------------------------------
    mov ah, 0
    int	    16h					; Keybord interupt
    mov ax, 1					; Return true

    ret
kbhit ENDP


;---------------------------------------------------
putch PROC C,
    char:BYTE
;
; Summary: Writes a character specified by the
;          argument char to stdout.
;
; Params:  char - character to write
;
; Returns: Char hit
;
; Date: 9/6/2017
;---------------------------------------------------
    mov al, char				; Move char into al
    mov ah, 0eh					; Teletype output

    .IF al == 0dh				; Newline on enter
	int	10h				; Video interupt
	mov al, 0ah				; Line feed
	int	10h				; Video interupt
    .ELSE
	int	10h				; Video interupt
    .ENDIF

    ret
putch ENDP


;---------------------------------------------------
ungetch PROC C USES cx,
    char:BYTE
;
; Summary: Pushes a character back into the
;	   keyboard buffer.
;
; Params:  char - character to write
;
; Returns: Char hit
;
; Date: 9/7/2017
;---------------------------------------------------
    mov ah, 5					; Keybord buffer write
    mov cl, char				; Char to write into buffer
    int	    16h					; Keyboard interupt

    ret
ungetch ENDP


;---------------------------------------------------
clrscr PROC C USES ax
;
; Summary: Clears the screen.
;
; Params:  None
;
; Returns: None
;
; Date: 9/7/2017
;---------------------------------------------------
    mov al, 02h
    mov ah, 00h
    int	    10h					; Video interupt

    ret
clrscr ENDP


;---------------------------------------------------
gotoxy PROC C USES ax dx,
    xpos:BYTE,
    ypos:BYTE
;
; Summary: Moves the cursor to a new x, y pos.
;
; Params:  xpos - x position to set the cursor
;          ypos - Y position to set the cursor
;
; Returns: None
;
; Date: 9/7/2017
;---------------------------------------------------
    mov dl, xpos				; xpos
    mov dh, ypos				; ypos
    mov bh, 0
    mov ah, 2					; Move cursor func
    int	    10h					; Video interupt

    ret
gotoxy ENDP


colorPrint MACRO
   .IF !(al >= 0 && al <= 22)			; Ignore line feed and newline
        mov bl, staticTextBackground		; Attribute (color)
	rol bl, 4				; Rotate left 4 bits
	or bl, staticTextColor			; Move text color and bg in bl
	mov ah, 09h				; Write char and attrib at cursor pos
	mov cx, 1				; Repeat once
	int     10h				; Video interupt

	mov ah, 0eh				; Teletype output
	int	10h				; Video interupt
    .ELSE
	int	10h				; Video interupt
	mov al, 0dh				; Carriage return
	int	10h				; Video interupt
    .ENDIF
ENDM


;---------------------------------------------------
highvideo PROC C USES ax
;
; Summary: Sets high intensity bits for the current foreground color.
;
; Uses:	   staticTextColor - Current foreground color.
;
; Params:  None
;
; Returns: None
;
; Date: 9/7/2017
;---------------------------------------------------
    mov	al, staticTextColor			; Get text color
    .IF al <= 7					; Set to high intensity bit if less than or equal to 7
	add al, 8
    .ENDIF
    mov	staticTextColor, al			; Store text color

    ret
highvideo ENDP


;---------------------------------------------------
lowvideo PROC C	USES ax
;
; Summary: Sets low intensity bits for the current foreground color.
;
; Uses:	   staticTextColor - Current foreground color.
;
; Params:  None
;
; Returns: None
;
; Date: 9/7/2017
;---------------------------------------------------
    mov	al, staticTextColor			; Get text color
    .IF al >= 7					; Set to low intensity bit if greater than or equal to 7
	sub al, 8
    .ENDIF
    mov	staticTextColor, al			; Store text color

    ret
lowvideo ENDP


;---------------------------------------------------
insline PROC C USES ax
;
; Summary: A blank line is inserted at the current cursor position.
;
; Params:  None
;
; Returns: None
;
; Date: 9/7/2017
;---------------------------------------------------
    mov ah, 0eh					; Teletype output
    mov al, 0dh					; Carriage return
    int	    10h					; Video interupt
    mov al, 0ah					; Line feed
    int	    10h

    ret
insline ENDP


;---------------------------------------------------
wherex PROC C USES bx dx
;
; Summary: Gets the current cursor x pos.
;
; Params:  None
;
; Returns: X pos
;
; Date: 9/7/2017
;---------------------------------------------------
    mov bh, 0					; Page number
    mov ah, 3					; Get cursor pos
    int	    10h					; Video interupt
    movsx ax, dl				; Move the x pos into return reg

    ret
wherex ENDP


;---------------------------------------------------
wherey PROC C USES bx dx
;
; Summary: Gets the current cursor y pos.
;
; Params:  None
;
; Returns: Y pos
;
; Date: 9/7/2017
;---------------------------------------------------
    mov bh, 0					; Page number
    mov ah, 3					; Get cursor pos
    int	    10h					; Video interupt
    movsx ax, dh				; Move the y pos into return reg

    ret
wherey ENDP


;---------------------------------------------------
cputs PROC C USES si ax bx cx,
    string:PTR BYTE
;
; Summary: Write a colored string directly to the screen memory.
;
; Uses:	   staticTextColor - Current foreground color.
;	   staticTextBackground - Current background color.
;
; Params:  string - String to print out.
;
; Returns: None
;
; Date: 9/7/2017
;---------------------------------------------------
    mov si, string				; Point to param address

  @@puts:
    lodsb					; Get character from string
    or al, al					; End of string?
    jz @@done					; If so, finish

    mov bl, staticTextBackground		; Attribute (color)
    rol bl, 4					; Rotate left 4 bits
    or bl, staticTextColor			; Move text color and bg in bl
    mov ah, 09h					; Write char and attrib at cursor pos
    mov cx, 1					; Repeat once
    int     10h					; Video interupt

    mov ah, 0eh					; Teletype output
    int 10h					; Video interupt
    jmp @@puts

  @@done:
    ret
cputs ENDP


;---------------------------------------------------
cputsxy PROC C,
    xpos:BYTE,
    ypos:BYTE,
    string:PTR BYTE
;
; Summary: Write a colored string directly to the screen memory
;	   at the given position.
;
; Calls:   gotoxy - Move cursor to x an y position.
;	   cputs - Print out a colored string.
;
; Params:  xpos	- X position to set the cursor.
;	   ypos	- Y position to set the cursor.
;	   string - String to print out.
;
; Returns: None
;
; Date: 9/7/2017
;---------------------------------------------------
    invoke gotoxy, xpos, ypos			; Move cursor to pos
    invoke cputs, string			; Print colored text

    ret
cputsxy ENDP


;---------------------------------------------------
textbackground PROC C USES ax,
    color:BYTE
;
; Summary: Change the current background color in text mode.
;
; Uses:	   staticTextBackground - Current background color.
;
; Params:  color - The color to set the background (0- 15).
;
; Returns: None
;
; Date: 9/7/2017
;---------------------------------------------------
    mov al, color				; Move color to al
    mov	staticTextBackground, al		; Set text background color to al

    ret
textbackground ENDP


;---------------------------------------------------
textcolor PROC C USES ax,
    color:BYTE
;
; Summary: Change the current text color in text mode.
;
; Uses:	   staticTextColor - Current text color.
;
; Params:  color - The color to set the text (0- 15).
;
; Returns: None
;
; Date: 9/7/2017
;---------------------------------------------------
    mov al, color				; Move color to al
    mov	staticTextColor, al			; Set text color to al

    ret
textcolor ENDP


;---------------------------------------------------
cursoroff PROC C USES ax cx
;
; Summary: Turns the cursor off.
;
; Params:  None
;
; Returns: None
;
; Date: 9/7/2017
;---------------------------------------------------
    mov ch, 32
    mov ah, 1
    mov al, 3
    int	    10h

    ret
cursoroff ENDP


;---------------------------------------------------
cursoron PROC C USES ax cx
;
; Summary: Turns the cursor on.
;
; Params:  None
;
; Returns: None
;
; Date: 9/7/2017
;---------------------------------------------------
    mov ch, 6
    mov cl, 7
    mov ah, 1
    mov al, 3
    int	    10h

    ret
cursoron ENDP


;---------------------------------------------------
delay PROC C USES ax cx dx,
    ms:PTR BYTE
;
; Summary: Delays the program.
;
; Params:  ms - Time to delay.
;
; Returns: None
;
; Date: 9/7/2017
;---------------------------------------------------
    mov cx, ms
    mov dx, 4240h
    mov ah, 86h
    int	    15h

    ret
delay ENDP


;---------------------------------------------------
newline PROC C USES ax
;
; Summary: Writes a new light to the screen.
;
; Params:  None
;
; Returns: None
;
; Date: 9/7/2017
;---------------------------------------------------
    mov ah, 0eh					; Teletype output
    mov al, 0dh					; Carriage return
    int	    10h					; Video interupt
    mov al, 0ah					; Line feed
    int	    10h					; Video interupt

    ret
newline ENDP


;---------------------------------------------------
setcursortype PROC C USES ax cx,
    cur:BYTE
;
; Summary: Changes the cursor type (6, 32, 256)
;
; Params:  cur - Cursor type.
;
; Returns: None
;
; Date: 9/7/2017
;---------------------------------------------------
    mov ch, cur
    mov cl, 7
    mov ah, 1
    mov al, 3
    int	    10h

    ret
setcursortype ENDP


; ------------------------------------------------------------------
; int cprintf(const char *format, ...)
; ------------------------------------------------------------------
; Sends formatted output to stdout.
.data
 hexstr		      db '0123456789ABCDEF'
 outstr16	      db '0000', 0
.code
cprintf PROC uses di si ax bx cx dx format:WORD, args:VARARG
local temp:word
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
		    colorPrint
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
		    colorPrint
		.UNTIL 0
		pop si
		pop si
		.CONTINUE
	    .ELSEIF al == 'c'				    ; Format char
		mov ax,  si
		colorPrint
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
		    colorPrint
		.UNTILCXZ
		pop si
		.CONTINUE
	    .ENDIF
	.ENDIF
	colorPrint
    .UNTIL 0
    ret
cprintf ENDP


  ; ------------------------------------------------------------------
; int cscanf(const char *format, ...);
; ------------------------------------------------------------------
; Reads formatted input from stdin.

cscanf PROC uses di si ax bx cx dx format:WORD, args:VARARG
    mov si, format					    ; Point to param address
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
		colorPrint
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

    ret
cscanf ENDP


.data
 staticTextColor      db 15
 staticTextBackground db 0
.code
END