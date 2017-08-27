; ------------------------------------------------------------------
.model tiny, c							; Small memoy model
.386								; 80386 CPU
include libc.inc						; Include library headers
.data								; Data segment
 error_fmt db "    [-] Assertion failed: file %s, line %d", 10, 13, 0
.code								; Start of code segment
; ------------------------------------------------------------------


; ------------------------------------------------------------------
; void _assert(const char *e ,const char *file, int line)
; ------------------------------------------------------------------
; This function returns an assertion error if vaid, calls
; to the _printf function within the library and uses
; a string fmt method for producing the error msg in the
; system console.

_assert PROC func:WORD, file:WORD, line:PTR BYTE
    pusha

    mov	ah, 09h
    mov	al, ' '
    mov	bl, 0ch						    ; Format text red
    mov	cx, 84
    int	10h

    mov di, offset error_fmt				    ; Error string to format
    mov ax,func					    ; Filename
    mov bx, file					    ; Line number
    mov cx, line					    ; Failed input

    push cx
    push bx
    push di
    call printf
    pop cx
    pop bx
    pop di

    popa
    mov sp, bp						    ; Restore stack pointer
    pop bp						    ; Restore BP register
    ret
_assert ENDP

end