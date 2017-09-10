; ------------------------------------------------------------------
.model tiny, c							; Small memoy model
.386								; 80386 CPU
 include signal.inc					; Include library headers
 include stdbool.inc
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


signal PROC C sig:PTR BYTE, func:WORD
    .IF sig == SIGINT
	.IF SIGCHECK == true					 ; Signal failsafe
	    mov ax, func					 ; Move func into register
	    mov WORD PTR catch_func, ax				 ; Move ax into the static var
	    mov SIGCHECK, false					 ; Set failsafe to false
	    mov ax, 0						 ; Return 0 for success
	.ELSE
	    mov ax, -1
	.ENDIF
    .ELSEIF sig == SIGTERM
        clearBuff catch_func
    	mov SIGCHECK, true
        mov ax, 0
    .ELSEIF sig == SIGBREAK
    .ELSEIF sig == SIGABRT
    .ELSE
	mov ax, -1
    .ENDIF
    ret
signal ENDP


raise PROC C sig:PTR BYTE
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
    .ELSEIF sig == SIGTERM
        clearBuff catch_func
	mov SIGCHECK, true
        mov ax, 0
    .ELSEIF sig == SIGBREAK
    .ELSEIF sig == SIGABRT
    .ELSE
    .ENDIF
    ret
raise ENDP

END