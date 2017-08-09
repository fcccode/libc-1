; ------------------------------------------------------------------
	.286							; CPU type
	.model tiny						; Tiny memoy model
	 _printf proto						; Externel _printf function
	.data							; Data segment
	    error_fmt db "Assertion failed: %s, file %s, line %d", 10, 13, 0
	.code							; Start of code segment
; ------------------------------------------------------------------


; ------------------------------------------------------------------
; void _assert(const char *file, int line, const char *e)
; ------------------------------------------------------------------
; This function returns an assertion error if vaid, calls
; to the _printf function within the library and uses
; a string fmt method for producing the error msg in the
; system console.

__assert PROC
    push bp							; Save BP on stack
    mov bp, sp							; Set BP to SP
	mov di, offset error_fmt				; Error string to format
	mov ax, [bp + 4]					; Filename
	mov bx, [bp + 6]					; Line number
	mov cx, [bp + 8]					; Failed input

	push cx
	push bx
	push ax
	push di
	call _printf
	pop cx
	pop bx
	pop ax
	pop di

	mov sp, bp						; Restore stack pointer
	pop bp							; Restore BP register
	ret
__assert ENDP

end