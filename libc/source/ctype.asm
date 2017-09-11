;---------------------------------------------------
;
; Details
;----------------------------------
; This file is part of a 16 bit	C library devoloped for
; hobby os devolopment, by Joshua Riek, 2017. The file
; ctype.asm is a replica of the Standard C Library ctype.h,
; that declares several functions that are useful for
; testing and mapping characters.
;
; Copyright 2017 Joshua Riek. No part of this file may be
; reproduced, in any form or by any other means, without
; permission in writing from the author.
;
; Available Procedures
;----------------------------------
; isalnum
; isalpha
; iscntrl
; isdigit
; isgraph
; islower
; isprint
; ispunct
; isspace
; isupper
; isxdigit
; tolower
; toupper
;
;---------------------------------------------------

.model tiny, C					; Small memoy model
.386						; 80386 CPU
.code

;---------------------------------------------------
isalnum PROC C char:PTR BYTE
;
; Summary: Checks whether the passed character
;	   is alphanumeric or not.
;
; Params:  char - Character to be checked.
;
; Returns: Non-zero value if the char is a digit
;	   or a letter, else it returns 0.
;
; Date: 9/9/2017
;---------------------------------------------------
    mov ax, char				; Move the char into ax

    .IF (ax >= 48 && ax <= 57) 			; If input is a digit return 4
   	mov ax, 4
    .ELSEIF (ax >= 65 && ax <= 90)		; If input is uppercase char return 1
	mov ax, 1
    .ELSEIF (ax >= 97 && ax <= 122)		; If input is lowercase char return 2
	mov ax, 2
    .ELSE					; Return 0 on non-alphanumeric
	mov ax, 0
    .ENDIF

    ret
isalnum ENDP


;---------------------------------------------------
isalpha PROC C char:PTR BYTE
;
; Summary: Checks whether the passed character
;	   is alphabetic.
;
; Params:  char - Character to be checked.
;
; Returns: Non-zero value if the char is letter,
;	   else it returns 0.
;
; Date: 9/9/2017
;---------------------------------------------------
    mov ax, char				; Move the char into ax

    .IF (ax >= 65 && ax <= 90)			; If input is uppercase char return 1
    	mov ax, 1
    .ELSEIF (ax >= 97 && ax <= 122)		; If input is lowercase char return 2
    	mov ax, 2
    .ELSE					; Return 0 on non-alphanumeric
    	mov ax, 0
    .ENDIF

    ret
isalpha ENDP


;---------------------------------------------------
iscntrl PROC C char:PTR BYTE
;
; Summary: This function checks whether the passed
;	   character is a control character.
;
; Params:  char - Character to be checked.
;
; Returns: Non-zero value if the char is a control
;	   character, else it returns 0.
;
; Date: 9/9/2017
;---------------------------------------------------
    mov ax, char				; Move the char into ax

    .IF (ax >= 0 && ax <= 31)			; If input is control character return 32
	mov ax, 32
    .ELSEIF (ax == 127)				; If input is control character return 32
	mov ax, 32
    .ELSEIF (ax == 256)				; If input is control character return 32
	mov ax, 32
    .ELSE					; Return 0 on non-control character
	mov ax, 0
    .ENDIF

    ret
iscntrl ENDP


;---------------------------------------------------
isdigit PROC C char:PTR BYTE
;
; Summary: This function checks whether the passed
;	   character is a decimal digit.
;
; Params:  char - Character to be checked.
;
; Returns: Non-zero value if the char is a decimal
;	   digit, else it returns 0.
;
; Date: 9/9/2017
;---------------------------------------------------
    mov ax, char				; Move the char into ax

    .IF (ax >= 48 && ax <= 57)			; If input is a digit
	mov ax, 1
    .ELSE					; Return 0 on non-digit
	mov ax, 0
    .ENDIF

    ret
isdigit ENDP


;---------------------------------------------------
isgraph PROC C char:PTR BYTE
;
; Summary: This function checks whether the passed
;	   character has a graphical represatation.
;
; Params:  char - Character to be checked.
;
; Returns: Non-zero value if the char has a graphical
;	   represatation, else it returns 0.
;
; Date: 9/9/2017
;---------------------------------------------------
    mov ax, char				; Move the char into ax

    .IF (ax >= 33 && ax <= 47)			; If input is a special char return 16
	mov ax, 16
    .ELSEIF (ax >= 48 && ax <= 57)		; If input is a digit return 4
    	mov ax, 4
    .ELSEIF (ax >= 58 && ax <= 64)		; If input is a special char return 16
	mov ax, 16
    .ELSEIF (ax >= 65 && ax <= 90)		; If input is uppercase char return 1
	mov ax, 1
    .ELSEIF (ax >= 91 && ax <= 96)		; If input is a special char return 16
	mov ax, 16
    .ELSEIF (ax >= 97 && ax <= 122)		; If input is lowercase char return 2
	mov ax, 2
    .ELSEIF (ax >= 123 && ax <= 126)		; If input is a special char return 16
	mov ax, 16
    .ELSE					; Return 0 if no graphical represatation
	mov ax, 0
    .ENDIF

    ret
isgraph ENDP


;---------------------------------------------------
islower PROC C char:PTR BYTE
;
; Summary: This function checks whether the passed
;	   character is a lowercase letter.
;
; Params:  char - Character to be checked.
;
; Returns: Non-zero value if the char is a lowercase
;	   letter, else it returns 0.
;
; Date: 9/9/2017
;---------------------------------------------------
    mov ax, char				; Move the char into ax

    .IF (ax >= 97 && ax <= 122)			; If input is lowercase char return 2
	mov ax, 2
    .ELSE					; Return 0 on non-lowercase
	mov ax, 0
    .ENDIF

    ret
islower ENDP


;---------------------------------------------------
isprint PROC C char:PTR BYTE
;
; Summary: This function checks whether the passed
;	   character is printable.
;
; Params:  char - Character to be checked.
;
; Returns: Non-zero value if the char is printable,
;	   else it returns 0.
;
; Date: 9/9/2017
;---------------------------------------------------
    mov ax, char				; Move the char into ax

    .IF (ax == 32)				; If input is a special char return 32
	mov ax, 64
    .ELSEIF (ax >= 33 && ax <= 47)		; If input is a special char return 16
	mov ax, 16
    .ELSEIF (ax >= 48 && ax <= 57) 		; If input is a digit return 4
	mov ax, 4
    .ELSEIF (ax >= 58 && ax <= 64)		; If input is a special char return 16
	mov ax, 16
    .ELSEIF (ax >= 65 && ax <= 90)		; If input is lowercase char return 1
	mov ax, 1
    .ELSEIF (ax >= 91 && ax <= 96)		; If input is a special char return 16
	mov ax, 16
    .ELSEIF (ax >= 97 && ax <= 122)		; If input is uppercase char return 2
	mov ax, 2
    .ELSEIF (ax >= 123 && ax <= 126)		; If input is a special char return 16
	mov ax, 16
    .ELSE					; Return 0 on non-printable char
	mov ax, 0
    .ENDIF

    ret
isprint ENDP


;---------------------------------------------------
ispunct PROC C char:PTR BYTE
;
; Summary: This function checks whether the passed
;	   character is punctuation.
;
; Params:  char - Character to be checked.
;
; Returns: Non-zero value if the char is punctuation,
;	   else it returns 0.
;
; Date: 9/9/2017
;---------------------------------------------------
    mov ax, char				; Move the char into ax

    .IF (ax >= 33 && ax <= 47)			; If input is punctuation return 16
	mov ax, 16
    .ELSEIF (ax >= 58 && ax <= 64)		; If input is punctuation return 16
	mov ax, 16
    .ELSEIF (ax >= 91 && ax <= 96)		; If input is punctuation return 16
	mov ax, 16
    .ELSEIF (ax >= 123 && ax <= 126)		; If input is punctuation return 16
	mov ax, 16
    .ELSE					; Return 0 on non-punctuation char
	mov ax, 0
    .ENDIF

    ret
ispunct ENDP


;---------------------------------------------------
isspace PROC C char:PTR BYTE
;
; Summary: This function checks whether the passed
;	   character is a white-space.
;
; Params:  char - Character to be checked.
;
; Returns: Non-zero value if the char is a white-space,
;	   else it returns 0.
;
; Date: 9/9/2017
;---------------------------------------------------
    mov ax, char				; Move the char into ax

    .IF (ax >= 9 && ax <= 13)			; If input is white-space return 8
	mov ax, 8
    .ELSEIF (ax == 32)				; If input is white-space return 8
	mov ax, 8
    .ELSE					; Return 0 on a non-white-space char
	mov ax, 0
    .ENDIF

    ret
isspace ENDP


;---------------------------------------------------
isupper PROC C char:PTR BYTE
;
; Summary: This function checks whether the passed
;	   character is an uppercase letter.
;
; Params:  char - Character to be checked.
;
; Returns: Non-zero value if the char is a uppercase
;	   letter, else it returns 0.
;
; Date: 9/9/2017
;---------------------------------------------------
    mov ax, char				; Move the char into ax

    .IF (ax >= 65 && ax <= 90)			; If input is uppercase char return 1
	mov ax, 1
    .ELSE					; Return 0 on non uppercase
	mov ax, 0
    .ENDIF

    ret
isupper ENDP


;---------------------------------------------------
isxdigit PROC C char:PTR BYTE
;
; Summary: This function checks whether the passed
;	   character is a hexadecimal digit.
;
; Params:  char - Character to be checked.
;
; Returns: Non-zero value if the char is a hexadecimal
;	   digit, else it returns 0.
;
; Date: 9/9/2017
;---------------------------------------------------
    mov ax, char				; Move the char into ax

    .IF (ax >= 48 && ax <= 57)			; If input is a hexadecimal digit return 128
    	mov ax, 128
    .ELSEIF (ax >= 65 && ax <= 70)		; If input is a hexadecimal digit return 128
    	mov ax, 128
    .ELSEIF (ax >= 97 && ax <= 102)		; If input is a hexadecimal digit return 128
    	mov ax, 128
    .ELSE					; Return 0 on non-hexadecimal digit
    	mov ax, 0
    .ENDIF

    ret
isxdigit ENDP


;---------------------------------------------------
tolower PROC C char:PTR BYTE
;
; Summary: This function converts uppercase letters
;	   to lowercase.
;
; Params:  char - Character to be converted.
;
; Returns: Converted lowercase character.
;
; Date: 9/9/2017
;---------------------------------------------------
    mov ax, char				; Move the char into ax

    .IF ax >= 65 && ax <= 90			; If input is a uppercase character
	add ax, 32
    .ENDIF

    ret
tolower  ENDP


toupper PROC C char:PTR BYTE
;
; Summary: This function converts lowercase letters
;	   to uppercase.
;
; Params:  char - Character to be converted.
;
; Returns: Converted uppercase character.
;
; Date: 9/9/2017
;---------------------------------------------------
    mov ax, char				; Move the char into ax

    .IF ax >= 97 && ax <= 122			; If input is a lowercase character
	sub ax, 32
    .ENDIF

    ret
toupper  ENDP

END