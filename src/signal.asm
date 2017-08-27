; ------------------------------------------------------------------
.model tiny, c							; Small memoy model
.386								; 80386 CPU
include libc.inc						; Include library headers
.data								; Data segment
 catch_func db ?						; Buffer for returning data
 SIGCHECK db 1
.code								; Start of code segment
; ------------------------------------------------------------------


clearBuff MACRO arg
    push di
    push cx
    push ax
    cld
    mov di, offset arg
    mov cx, sizeof arg						; Repeat for the length of the buffer
    mov al, 0							; Clear with null (0)
    rep stosb
    pop di
    pop cx
    pop ax
ENDM


signal PROC sig:PTR BYTE, func:WORD
    .IF sig == SIGINT
	.IF SIGCHECK == true					 ; Signal failsafe
	    mov ax, func					 ; Move func into register
	    mov WORD PTR catch_func, ax				 ; Move ax into the static var
	    mov SIGCHECK, false					 ; Set failsafe to false
	    mov ax, 0						 ; Return 0 for success
	.ELSE
	    mov ax, -1
	.ENDIF
    .ELSEIF sig == SIGILL
    .ELSEIF sig == SIGFPE
    .ELSEIF sig == SIGSEGV
    .ELSEIF sig == SIGTERM
    .ELSEIF sig == SIGBREAK
    .ELSEIF sig == SIGABRT
    .ELSEIF sig == NSIG
    .ELSE
	mov ax, -1
    .ENDIF
    ret
signal ENDP


raise PROC sig:PTR BYTE
    .IF sig == SIGINT
    	.IF SIGCHECK == false
	    mov ax, WORD PTR catch_func
	    call ax
	    mov SIGCHECK, true
	    clearBuff catch_func
	    mov ax, 0
	.ELSE
	    mov ax, -1
	.ENDIF
    .ELSEIF sig == SIGILL
    .ELSEIF sig == SIGFPE
    .ELSEIF sig == SIGSEGV
    .ELSEIF sig == SIGTERM
    .ELSEIF sig == SIGBREAK
    .ELSEIF sig == SIGABRT
    .ELSEIF sig == NSIG
    .ELSE
    .ENDIF
    ret
raise ENDP

END