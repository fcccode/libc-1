; ------------------------------------------------------------------
.model tiny, c							; Small memoy model
.386								; 80386 CPU
include libc.inc						; Include library headers
.data								; Data segment
.code								; Start of code segment
; ------------------------------------------------------------------


; ------------------------------------------------------------------
; int isalnum(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character
; is alphanumeric or not.

isalnum PROC var:PTR BYTE
    mov ax, var

    .IF ax >= 48 && ax <= 57 					; If input is a digit return 4
   	mov ax, 4
    .ELSEIF ax >= 65 && ax <= 90				; If input is uppercase char return 1
	mov ax, 1
    .ELSEIF ax >= 97 && ax <= 122				; If input is lowercase char return 2
	mov ax, 2
    .ELSE
	mov ax, 0						; Return 0 on non alphanumeric
    .ENDIF

    ret
isalnum ENDP


; ------------------------------------------------------------------
; int isalpha(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character is alphabetic.

isalpha PROC var:PTR BYTE
    mov ax, var

    .IF ax >= 65 && ax <= 90					; If input is uppercase char return 1
    	mov ax, 1
    .ELSEIF ax >= 97 && ax <= 122				; If input is lowercase char return 2
    	mov ax, 2
    .ELSE
    	mov ax, 0						; Return 0 on non alphanumeric
    .ENDIF

    ret
isalpha ENDP


; ------------------------------------------------------------------
; int iscntrl(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character is control character.

iscntrl PROC var:PTR BYTE
    mov ax, var

    .IF ax >= 0 && ax <= 31					; If input is control character return 32
	mov ax, 32
    .ELSEIF ax == 127						; If input is control character return 32
	mov ax, 32
    .ELSEIF ax == 256						; If input is control character return 32
	mov ax, 32
    .ELSE
	mov ax, 0						; Return 0 on non control character
    .ENDIF

    ret
iscntrl ENDP


; ------------------------------------------------------------------
; int isdigit(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character is decimal digit.

isdigit PROC var:PTR BYTE
    mov ax, var

    .IF ax >= 48 && ax <= 57					; If input is a digits 1
	mov ax, 1
    .ELSE
	mov ax, 0						; Return 0 on non control character
    .ENDIF

    ret
isdigit ENDP


; ------------------------------------------------------------------
; int isgraph(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character has a graphical represatation

isgraph PROC var:PTR BYTE
    mov ax, var

    .IF ax >= 33 && ax <= 47
	mov ax, 16
    .ELSEIF ax >= 48 && ax <= 57
    	mov ax, 4
    .ELSEIF ax >= 58 && ax <= 64
	mov ax, 16
    .ELSEIF ax >= 65 && ax <= 90
	mov ax, 1
    .ELSEIF ax >= 91 && ax <= 96
	mov ax, 16
    .ELSEIF ax >= 97 && ax <= 122
	mov ax, 2
    .ELSEIF ax >= 123 && ax <= 126
	mov ax, 16
    .ELSE
	mov ax, 0
    .ENDIF

    ret
isgraph ENDP


; ------------------------------------------------------------------
; int islower(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character is
; a lowercase letter.

islower PROC var:PTR BYTE
    mov ax, var

    .IF ax >= 97 && ax <= 122					; If input is lowercase char return 2
	mov ax, 2
    .ELSE
	mov ax, 0						; Return 0 on non lowercase
    .ENDIF

    ret
islower ENDP


; ------------------------------------------------------------------
; int isprint(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character
; is a printable char

isprint PROC var:PTR BYTE
    mov ax, var

    .IF ax == 32						; If input is a special char return 32
	mov ax, 64
    .ELSEIF ax >= 33 && ax <= 47				; If input is a special char return 16
	mov ax, 16
    .ELSEIF ax >= 48 && ax <= 57 				; If input is a digit return 4
	mov ax, 4
    .ELSEIF ax >= 58 && ax <= 64				; If input is a special char return 16
	mov ax, 16
    .ELSEIF ax >= 65 && ax <= 90				; If input is lowercase char return 1
	mov ax, 1
    .ELSEIF ax >= 91 && ax <= 96				; If input is a special char return 16
	mov ax, 16
    .ELSEIF ax >= 97 && ax <= 122				; If input is uppercase char return 2
	mov ax, 2
    .ELSEIF ax >= 123 && ax <= 126				; If input is a special char return 16
	mov ax, 16
    .ELSE
	mov ax, 0						; Return 0 on non printable char
    .ENDIF

    ret
isprint ENDP


; ------------------------------------------------------------------
; int ispunct(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character
; is a punctuation character.

ispunct PROC var:PTR BYTE
    mov ax, var

    .IF ax >= 33 && ax <= 47					; If input is punctuation return 16
	mov ax, 16
    .ELSEIF ax >= 58 && ax <= 64				; If input is punctuation return 16
	mov ax, 16
    .ELSEIF ax >= 91 && ax <= 96				; If input is punctuation return 16
	mov ax, 16
    .ELSEIF ax >= 123 && ax <= 126				; If input is punctuation return 16
	mov ax, 16
    .ELSE
	mov ax, 0						; Return 0 on non printable char
    .ENDIF

    ret
ispunct ENDP


; ------------------------------------------------------------------
; int isspace(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character is white-space.

isspace PROC var:PTR BYTE
    mov ax, var

    .IF ax >= 9 && ax <= 13					; If input is white-space return 16
	mov ax, 8
    .ELSEIF ax == 32						; If input is white-space return 16
	mov ax, 8
    .ELSE
	mov ax, 0						; Return 0 on non printable char
    .ENDIF

    ret
isspace ENDP


; ------------------------------------------------------------------
; int isupper(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character
; is an uppercase letter.

isupper PROC var:PTR BYTE
    mov ax, var

    .IF ax >= 65 && ax <= 90					; If input is uppercase char return 1
	mov ax, 1
    .ELSE
	mov ax, 0						; Return 0 on non uppercase
    .ENDIF

    ret
isupper ENDP


; ------------------------------------------------------------------
; int isxdigit(int c)
; ------------------------------------------------------------------
; This function checks whether the passed character
; is a hexadecimal digit.

isxdigit PROC var:PTR BYTE
    mov ax, var

    .IF ax >= 48 && ax <= 57					; If input is a hexadecimal digit return 128
    	mov ax, 128
    .ELSEIF ax >= 65 && ax <= 70				; If input is a hexadecimal digit return 128
    	mov ax, 128
    .ELSEIF ax >= 97 && ax <= 102				; If input is a hexadecimal digit return 128
    	mov ax, 128
    .ELSE
    	mov ax, 0						; Return 0 on non uppercase
    .ENDIF

    ret
isxdigit ENDP


; ------------------------------------------------------------------
; int tolower(int c)
; ------------------------------------------------------------------
; This function converts uppercase letters to lowercase.

tolower PROC var:PTR BYTE
    mov ax, var

    .IF ax >= 65 && ax <= 90
	add ax, 32
    .ENDIF

    ret
tolower  ENDP


; ------------------------------------------------------------------
; int toupper(int c)
; ------------------------------------------------------------------
; This function converts lowercase letters to uppercase .

toupper PROC var:PTR BYTE
    mov ax, var

    .IF ax >= 97 && ax <= 122
	sub ax, 32
    .ENDIF

    ret
toupper  ENDP

END