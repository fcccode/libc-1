; ------------------------------------------------------------------
.model tiny, c							; Small memoy model
.386								; 80386 CPU
.code								; Start of code segment
; ------------------------------------------------------------------

_acrtused PROC
_acrtused ENDP

; ------------------------------------------------------------------
; void setpage(int page)
; ------------------------------------------------------------------
; This function sets the active page number.

setpage PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP

    mov  al, [bp + 4]						; Select display page
    mov  ah, 05h						; Select active display page
    int  10h

    mov sp, bp							; Restore stack pointer
    pop bp							; Restore BP register
    ret
setpage ENDP

END