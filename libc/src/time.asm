; ------------------------------------------------------------------
.model tiny, c							; Small memoy model
.386								; 80386 CPU
include libc.inc						; Include library headers
.code								; Start of code segment
; ------------------------------------------------------------------
_tmbuf tm <>

; ------------------------------------------------------------------
; Converts binary coded decimal number to an integer

bcd PROC uses bx cx num:BYTE
	mov ah, num
	mov bl, al			; Store entire number for now

	and ax, 0Fh			; Zero-out high bits
	mov cx, ax			; CH/CL = lower BCD number, zero extended

	shr bl, 4			; Move higher BCD number into lower bits, zero fill msb
	mov al, 10
	mul bl				; AX = 10 * BL

	add ax, cx			; Add lower BCD to 10*higher

	ret
bcd ENDP

localtime PROC
LOCAL hour: BYTE
LOCAL min: BYTE
LOCAL sec: BYTE
LOCAL isdst: BYTE
LOCAL year: BYTE
LOCAL mon: BYTE
LOCAL mday: BYTE

    mov ah, 02h
    int	    1ah
    mov hour, ch
    mov min, cl
    mov sec, dh
    mov isdst, dl

    mov ah, 04h
    int	    1ah
    mov year, cl
    mov mon, dh
    mov mday, dl

    invoke bcd, hour
    mov _tmbuf.tm_hour, ax
    invoke bcd, min
    mov _tmbuf.tm_min, ax
    invoke bcd, sec
    mov _tmbuf.tm_sec, ax
    invoke bcd, isdst
    mov _tmbuf.tm_isdst, ax
    invoke bcd, year
    mov _tmbuf.tm_year, ax
    invoke bcd, mon
    mov _tmbuf.tm_mon, ax
    invoke bcd, mday
    mov _tmbuf.tm_mday, ax

    lea ax, _tmbuf
    ret
localtime ENDP
; ------------------------------------------------------------------
; char *asctime(const struct tm *timeptr)
; ------------------------------------------------------------------
; returns a pointer to a string which represents the day
; and time of the structure struct timeptr.



end