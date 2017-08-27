; ------------------------------------------------------------------
.model tiny, c							; Small memoy model
.386								; 80386 CPU
include libc.inc						; Include library headers
.data								; Data segment
 txtc  db 15							; Text color
 txtbg db 0							; Text background
buffered BYTE 64 dup(?)					; Buffer for returning data
 hexstr   db '0123456789ABCDEF'
outstr16   db '00', 0  ;register value string
    .code								; Start of code segment
; ------------------------------------------------------------------

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

getch PROC
    mov ah, 0
    int	    16h						    ; Keybord interupt
    xor ah, ah						    ; Clear higher-half of ax

    ret
getch ENDP


; ------------------------------------------------------------------
; int getche(void)
; ------------------------------------------------------------------
; Gets a character (an unsigned char) input and echo output.

getche PROC
    mov ah, 0
    int	    16h						    ; Keybord interupt
    mov ah, 0eh						    ; Teletype output
    int     10h						    ; Video interupt
    xor ah, ah						    ; Clear higher-half of ax

    ret
getche ENDP


; ------------------------------------------------------------------
; int kbhit(void);
; ------------------------------------------------------------------
; Gets a character (an unsigned char) input and echo output.

kbhit PROC
    mov ah, 0
    int	    16h						    ; Keybord interupt
    mov ax, 1						    ; Return true

    ret
kbhit ENDP


; ------------------------------------------------------------------
; int putch(int n)
; ------------------------------------------------------------------
; Writes a character (an unsigned char) specified
; by the argument char to stdout.

putch PROC n:PTR BYTE
    mov ax, n						    ; Move char into ax
    mov ah, 0eh						    ; Teletype output

    .IF al == 0dh					    ; Newline on enter
	int	10h					    ; Video interupt
	mov al, 0ah					    ; Line feed
	int	10h					    ; Video interupt
    .ELSE
	int	10h					    ; Video interupt
    .ENDIF

    ret
putch ENDP


; ------------------------------------------------------------------
; int ungetch(int n)
; ------------------------------------------------------------------
; Pushes a character back into the keyboard buffer.

ungetch PROC uses cx n:PTR BYTE
    mov ax, n						    ; Move char into ax
    mov ah, 5						    ; Keybord buffer write
    mov cl, al						    ; Char to write into buffer
    int	    16h						    ; Keyboard interupt

    ret
ungetch ENDP


; ------------------------------------------------------------------
; int clrscr()
; ------------------------------------------------------------------
; This function clears the screen.

clrscr PROC
    mov al, 02h
    mov ah, 00h
    int	    10h						    ; Video interupt

    ret
clrscr ENDP


; ------------------------------------------------------------------
; void gotoxy(int x, int y)
; ------------------------------------------------------------------
; This function moves the cursor to a new pos.

gotoxy PROC x:BYTE, y:BYTE
    mov dl, x						    ; xpos
    mov dh, y						    ; ypos
    mov bh, 0
    mov ah, 2
    int	    10h						    ; Video interupt

    ret
gotoxy ENDP


; ------------------------------------------------------------------
; void highvideo(void)
; ------------------------------------------------------------------
; This function sets high intensity bits for the current
; foreground color.

highvideo PROC
    mov	al, txtc					    ; Get text color

    .IF al <= 7						    ; Set to high intensity bit if less than or equal to 7
	add al, 8
    .ENDIF

    mov	txtc, al					    ; Store text color

    ret
highvideo ENDP


; ------------------------------------------------------------------
; void lowvideo(void)
; ------------------------------------------------------------------
; This function sets low intensity bits for the current
; foreground color.

lowvideo PROC
    mov	al, txtc					    ; Get text color

    .IF al >= 7						    ; Set to low intensity bit if greater than or equal to 7
	sub al, 8
    .ENDIF

    mov	txtc, al					    ; Store text color

    ret
lowvideo ENDP


; ------------------------------------------------------------------
; void insline(void)
; ------------------------------------------------------------------
; A blank line is inserted at the current cursor position.
; The previous line and lines below it scroll down.


insline PROC
    mov ah, 0eh						    ; Teletype output
    mov al, 0dh						    ; Carriage return
    int	    10h						    ; Video interupt
    mov al, 0ah						    ; Line feed
    int	    10h

    ret
insline ENDP

; ------------------------------------------------------------------
; int wherex(void)
; ------------------------------------------------------------------
; This function returns the cursor x pos.

wherex PROC uses bx dx
    mov bh, 0
    mov ah, 3
    int	    10h						    ; Video interupt

    mov ah, 0
    mov al, dl

    ret
wherex ENDP


; ------------------------------------------------------------------
; int wherey(void)
; ------------------------------------------------------------------
; This function returns the cursor y pos.

wherey PROC uses bx dx
    mov bh, 0
    mov ah, 3
    int	    10h						    ; Video interupt

    mov ah, 0
    mov al, dh

    ret
wherey ENDP


; ------------------------------------------------------------------
; int cputs(const char * str)
; ------------------------------------------------------------------
; Returns a string to the screen.

cputs PROC uses si string:WORD
    mov si, string					    ; Point to param address

  @@puts:
    lodsb						    ; Get character from string
    or al, al						    ; End of string
    jz @@done
    ColorAL
    jmp @@puts

  @@done:
    ret
cputs ENDP


 ; ------------------------------------------------------------------
; int cputsxy(int x, int y, const char * str)
; ------------------------------------------------------------------
; Returns a string to the screen at the specified pos

cputsxy PROC x:BYTE, y:BYTE, string:WORD
    invoke gotoxy, x, y					    ; Move cursor to pos
    invoke cputs, string				    ; Print colored text

    ret
cputsxy ENDP


; ------------------------------------------------------------------
; int cprintf(const char *format, ...)
; ------------------------------------------------------------------
; Sends formatted output to stdout.


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
		    ColorAL
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
		    ColorAL
		.UNTIL 0
		pop si
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

    ret
cscanf ENDP


; ------------------------------------------------------------------
; void textbackground(int color)
; ------------------------------------------------------------------
; Change of current background color in text mode.

textbackground PROC uses ax color:BYTE
    mov al, color					    ; Move color to al
    mov	txtbg, al					    ; Set text background color to al

    ret
textbackground ENDP


; ------------------------------------------------------------------
; void textcolor(int color)
; ------------------------------------------------------------------
; change the color of drawing text where color is a integer variable.

textcolor PROC uses ax color:BYTE
    mov al, color					    ; Move color to al
    mov	txtc, al					    ; Set text color to al

    ret
textcolor ENDP


; ------------------------------------------------------------------
; void cursoroff(void)
; ------------------------------------------------------------------
; This function turns the cursor off

cursoroff PROC uses ax cx
    mov ch, 32
    mov ah, 1
    mov al, 3
    int	    10h

    ret
cursoroff ENDP


; ------------------------------------------------------------------
; void cursoron(void)
; ------------------------------------------------------------------
; This function turns the cursor on

cursoron PROC uses ax cx
    mov ch, 6
    mov cl, 7
    mov ah, 1
    mov al, 3
    int	    10h

    ret
cursoron ENDP


; ------------------------------------------------------------------
; void delay(int ms)
; ------------------------------------------------------------------
; This function delays the program

delay PROC uses ax cx dx ms:PTR BYTE
    mov cx, ms						    ; ms delay
    mov dx, 4240h
    mov ah, 86h
    int 15h

    ret
delay ENDP


; ------------------------------------------------------------------
; void newline(void)
; ------------------------------------------------------------------
; This function writes a new line

newline PROC uses ax
    mov ah, 0eh						    ; Teletype output
    mov al, 0dh						    ; Carriage return
    int	    10h						    ; Video interupt
    mov al, 0ah						    ; Line feed
    int	    10h						    ; Video interupt

    ret
newline ENDP


; ------------------------------------------------------------------
; void setcursortype(int cur)
; ------------------------------------------------------------------
; This function moves the cursor to a new pos

setcursortype PROC uses ax cx cur:BYTE
    mov ch, cur						; Cursor type
    mov cl, 7
    mov ah, 1
    mov al, 3
    int	    10h

    ret
setcursortype ENDP

END