.NOLIST
IFNDEF _LOCALE_
_LOCALE_ EQU <1>

 lconv STRUCT
 decimal_point	    dw ?			; Buffer for returning data
 thousands_sep	    dw ?
 grouping	    dw ?
int_curr_symbol     dw ?
 currency_symbol    dw ?
 mon_decimal_point  dw ?
 mon_thousands_sep  dw ?
 mon_grouping       dw ?
 positive_sign      dw ?
 negative_sign      dw ?
 int_frac_digits    dw ?
 frac_digits	    dw ?
 p_cs_precedes	    dw ?
 p_sep_by_space	    dw ?
 n_cs_precedes	    dw ?
 n_sep_by_space	    dw ?
 p_sign_posn	    dw ?
 n_sign_posn	    dw ?
lconv ENDS
.data
 _lconvbuf lconv <>
 decimal_point	    dw ".", 0
 thousands_sep	    dw 0
 grouping	    dw 0
 int_curr_symbol    dw 0
 currency_symbol    dw 0
 mon_decimal_point  dw 0
 mon_thousands_sep  dw 0
 mon_grouping	    dw 0
 positive_sign	    dw 0
 negative_sign	    dw 0
.code
 int_frac_digits    = 0
 frac_digits	    = 0
 p_cs_precedes	    = 0
 p_sep_by_space	    = 0
 n_cs_precedes	    = 0
 n_sep_by_space	    = 0
 p_sign_posn	    = 0
 n_sign_posn	    = 0

ENDIF
.LIST