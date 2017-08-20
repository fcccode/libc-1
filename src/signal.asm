; ------------------------------------------------------------------
.model small, C
.386
	.data							; Data segment
	.code							; Start of code segment
; ------------------------------------------------------------------
_raise PROC
    push bp						    ; Save BP on stack
    mov bp, sp						    ; Set BP to SP

    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_raise ENDP
end