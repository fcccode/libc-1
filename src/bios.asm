; ------------------------------------------------------------------
	.286							; CPU type
	.model tiny						; Tiny memoy model
	.code							; Start of code segment
; ------------------------------------------------------------------

__acrtused PROC
__acrtused ENDP

; ------------------------------------------------------------------
; void setpage(int page)
; ------------------------------------------------------------------
; This function sets the active page number.

_setpage PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP

    mov  al, [bp + 4]						; Select display page
    mov  ah, 05h						; Select active display page
    int  10h

    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
_setpage ENDP

END