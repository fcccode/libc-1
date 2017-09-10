.NOLIST
IFNDEF _TIME_
_TIME_ EQU <1>

.data
tm struct
    tm_sec dw ?
    tm_min dw ?
    tm_hour dw ?
    tm_mday dw ?
    tm_mon dw ?
    tm_year dw ?
    tm_wday dw ?
    tm_yday dw ?
    tm_isdst dw ?
tm ENDS
.code

bcd PROTO :BYTE
localtime PROTO
_tmbuf tm <>

ENDIF
.LIST