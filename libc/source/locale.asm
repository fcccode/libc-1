; ------------------------------------------------------------------
.model tiny, c							; Small memoy model
.386								; 80386 CPU
 include locale.inc						; Include library headers

.code							; Start of code segment
; ------------------------------------------------------------------

; ------------------------------------------------------------------
; char *localtime(const struct tm *timeptr)
; ------------------------------------------------------------------
; returns a pointer to a the localtime struct with current
; time and date values

localeconv PROC
    mov _lconvbuf.decimal_point, offset decimal_point
    mov _lconvbuf.thousands_sep, offset thousands_sep
    mov _lconvbuf.grouping, offset grouping
    mov _lconvbuf.int_curr_symbol, offset int_curr_symbol
    mov _lconvbuf.currency_symbol, offset currency_symbol
    mov _lconvbuf.mon_decimal_point, offset mon_decimal_point
    mov _lconvbuf.mon_thousands_sep, offset mon_thousands_sep
    mov _lconvbuf.mon_grouping, offset mon_grouping
    mov _lconvbuf.positive_sign, offset positive_sign
    mov _lconvbuf.negative_sign, offset negative_sign
    mov _lconvbuf.int_frac_digits, int_frac_digits
    mov _lconvbuf.frac_digits, frac_digits
    mov _lconvbuf.p_cs_precedes, p_cs_precedes
    mov _lconvbuf.p_sep_by_space, p_sep_by_space
    mov _lconvbuf.n_cs_precedes, n_cs_precedes
    mov _lconvbuf.n_sep_by_space, n_sep_by_space
    mov _lconvbuf.p_sign_posn, p_sign_posn
    mov _lconvbuf.n_sign_posn, n_sign_posn
    lea ax, _lconvbuf
    ret
localeconv ENDP


end