;---------------------------------------------------
;
; Details
;----------------------------------
; This file is part of a 16 bit	C library devoloped for
; hobby os devolopment, by Joshua Riek, 2017. The file
; string.asm is a replica of the Standard C Library string.h,
; that declares several functions that are useful for
; manipulating arrays of characters.
;
; Copyright 2017 Joshua Riek. No part of this file may be
; reproduced, in any form or by any other means, without
; permission in writing from the author.
;
; Available Procedures
;----------------------------------
;
;---------------------------------------------------
.model tiny, C					; Small memoy model
.386						; 80386 CPU
include string.inc
 include conio.inc
 include art.inc
 .code
; ------------------------------------------------------------------

clearBuff MACRO arg
    push di
    push cx
    push ax
    cld
    mov di, offset arg
    mov cx, sizeof arg				; Repeat for the length of the buffer
    mov al, 0					; Clear with null (0)
    rep stosb
    pop di
    pop cx
    pop ax
ENDM


plotImage PROC
    mov cx, memesSize
    mov si, offset memesImage
    xor ax, ax
    xor bx, bx
  @@:
    mov ax, [si]
    inc si
    mov bx, [si]
    inc si
    push bx
    push ax
    call gotoxy
    pop ax
    pop bx
    pusha
    mov bl, [si]
    mov	cx, 1
    mov bh, 00 ; page | color
    mov	ax, 0920h ; int | char
    int	    10h
    mov ax, 0edbh  ; int | char
    int	    10h							; Video interupt
    popa
    inc si
  loop @b

    ret
plotImage ENDP

;---------------------------------------------------
strcmp PROC C USES si di bx,
    str1:PTR BYTE,
    str2:PTR BYTE
;
; Summary: Checks whether the two passed strings
;	   are equal to eachother.
;
; Params:  str1 - This is the first string to be compared.
;	   str2 - This is the second string to be compared.
;
; Returns: If str1 less than str2 return 1,
;	   If str2 less than str1 return -1,
;	   If str2 is equal to str1 return 0.
;
; Date: 9/10/2017
;---------------------------------------------------
    mov di, str1				; Point to str1 address
    mov si, str2				; Point to str2 address

    xor ax, ax					; Char number total for SI
    xor bx, bx					; Char number total for DI

  @@cmp:
    mov al, [si]				; Byte from SI
    add ah, al					; Total ascii char number
    mov bl, [di]				; Byte from DI
    add bh, bl					; Total ascii char number
    cmp al, bl					; Is both bytes equal?
    jne @@done					; If not, we are finished
    cmp al, 0					; If string is empty, we are finished
    je @@done
    inc di					; Point to next char
    inc si					; Point to next char
    jmp @@cmp

  @@done:
    .IF bh == ah				; Return 0 if both str inputs equal
	mov ax, 0
    .ELSEIF bh > ah				; Return 1 if str1 is greater than str2
	mov ax, 1
    .ELSEIF bh < ah				; Return -1 if str1 is less than str2
	mov ax, -1
    .ENDIF

    ret
strcmp ENDP


;---------------------------------------------------
strncmp PROC C USES si di bx cx,
    str1:PTR BYTE,
    str2:PTR BYTE,
    n:PTR BYTE
;
; Summary: Checks whether the first n chars of the
;          two passed strings are equal to eachother.
;
; Params:  str1 - This is the first string to be compared.
;	   str2 - This is the second string to be compared.
;	   n - Number of chars to test if equal.
;
; Returns: If str1 less than str2 return 1,
;	   If str2 less than str1 return -1,
;	   If str2 is equal to str1 return 0.
;
; Date: 9/10/2017
;---------------------------------------------------
    mov di, str1				; Point to str1 address
    mov si, str2				; Point to str2 address
    mov cx, n					; Store n in cx for loop

    xor ax, ax					; Char number total for SI
    xor bx, bx					; Char number total for DI

   @@cmp:
    mov al, [si]				; Byte from SI
    add ah, al					; Total ascii char number
    mov bl, [di]				; Byte from DI
    add bh, bl					; Total ascii char number
    cmp al, bl					; Is both bytes equal?
    jne @@done					; If not, we are finished
    cmp al, 0					; If string is empty, we are finished
    je @@done
    inc di					; Point to next char
    inc si					; Point to next char
    loop @@cmp

  @@done:
    .IF bh == ah				; Return 0 if both str inputs equal
	mov ax, 0
    .ELSEIF bh > ah				; Return 1 if str1 is greater than str2
	mov ah, 1
    .ELSEIF bh < ah				; Return -1 if str1 is less than str2
	mov ah, -1
    .ENDIF

    ret
strncmp ENDP


;---------------------------------------------------
strcoll PROC C USES si di bx,
    str1:PTR BYTE,
    str2:PTR BYTE
;
; Summary: Compares the string pointed to, by str1 to the string
;	   pointed to by str2.
;
; Note:    Same thing as strcmp?
;
; Params:  str1 - This is the first string to be compared.
;	   str2 - This is the second string to be compared.
;
;
; Returns: If str1 less than str2 return 1,
;	   If str2 less than str1 return -1,
;	   If str2 is equal to str1 return 0.
;
; Date: 9/10/2017
;---------------------------------------------------
    mov di, str1				; Point to str1
    mov si, str2				; Point to str2

    xor ax, ax					; Char number total for SI
    xor bx, bx					; Char number total for DI

   .REPEAT
	mov al, [si]				; Byte from SI
	add ah, al				; Total ascii char number
	mov bl, [di]				; Byte from DI
	add bh, bl				; Total ascii char number
	.IF al != bl				; Both bytes equal before null?
	    .BREAK
	.ELSEIF !al				; If string is empty, we are finished
	    .BREAK
	.ENDIF
	inc di
	inc si
    .UNTIL 0

    .IF bh == ah				; Return 0 if both str inputs equal
    	mov ax, 0
    .ELSEIF bh > ah				; Return 1 if str1 is greater than str2
    	mov ah, 1
    .ELSEIF bh < ah				; Return -1 if str1 is less than str2
    	mov ah, -1
    .ENDIF

    ret
strcoll ENDP


;---------------------------------------------------
strcpy PROC C USES si di,
    dest:PTR BYTE,
    src:PTR BYTE
;
; Summary: Copy string in src to dest.
;
; Params:  dest - Where to copy the string to.
;	   src - What to copy to the dest.
;
; Returns: Pointer to the dest.
;
; Date: 9/10/2017
;---------------------------------------------------
    mov di, dest				; Point to dest address
    mov si, src					; Point to src address

  @@cpy:
    lodsb					; Load char from si to al
    stosb					; Store char from al to di
    or al, al					; If source string is empty stop cpy loop
    jnz @@cpy

    mov ax, dest				; Return a pointer to the dest

    ret
strcpy ENDP


;---------------------------------------------------
strncpy PROC C USES si di cx,
    dest:PTR BYTE,
    src:PTR BYTE,
    n:PTR BYTE
;
; Summary: Copy string in src to dest up to n chars.
;
; Params:  dest - Where to copy the string to.
;	   src - What to copy to the dest.
;	   n - Number of times to copy.
;
; Returns: Pointer to the dest.
;
; Date: 9/10/2017
;---------------------------------------------------
    mov di, dest				; Point to dest address
    mov si, src					; Point to src address
    mov cx, n					; Times to iterate

  @@cpy:
    lodsb					; Load char from si to al
    stosb					; Store char from al to di
    or al, al					; If source string is empty stop cpy loop
    jz @@done
    loop @@cpy					; Loop up to n times

  @@done:
    mov ax, dest				; Return a pointer to the dest

    ret
strncpy ENDP


;---------------------------------------------------
strlen PROC C USES si cx,
    string:PTR BYTE
;
; Summary: Get the length of the string.
;
; Params:  string - String to get the length of.
;
; Returns: Length of the string.
;
; Date: 9/10/2017
;---------------------------------------------------
    mov si, string				; Point to string address
    xor cx, cx					; Store length in cx

  @@loop:
    lodsb					; Load char from si to al
    or al, al					; If al is empty stop loopg
    jz @@done
    inc cx					; Increase the counter
    jmp @@loop					; Loop again

  @@done:
    mov ax, cx					; Return the length of the string

    ret
strlen ENDP


;---------------------------------------------------
strchr PROC C USES si di cx,
    string:PTR BYTE,
    n:BYTE
;
; Summary: Searches for the first occurrence of
;	   the character n in the string pointed
;	   to, by the argument string.
;
; Params:  string - String to to search.
;	   n - What character to find.
;
; Returns: Character found and string after.
;
; Date: 9/10/2017
;---------------------------------------------------
    clearBuff return_buffer			; Clear the return buffer
    mov si, string				; Point to string address
    mov di, offset return_buffer		; Point to the static return buffer
    mov cl, n					; Char to find

  @@loop:					; Loop to find the char in the string
    lodsb					; Load char from si to al
    or al, al					; If al is empty stop looping
    jz @@done
    cmp al, cl					; Character found?
    jne @@loop
    stosb					; Store char from al to di

  @@found:					; Found the char in the string
    lodsb					; Get character from string
    or al, al					; If al is empty stop looping
    jz @@done
    stosb					; Store char from al to di
    jmp @@found

  @@done:
    mov ax, offset return_buffer		; Point to the return buffer address

    ret
strchr ENDP


;---------------------------------------------------
strcat PROC C USES si di,
    dest:PTR BYTE,
    src:PTR BYTE
;
; Summary: Concatenates or appends src to dest.
;	   All characters from src are copied
;	   including the terminating null character.
;
; Params:  dest - Where to append the string to.
;	   src - String to be appended.
;
; Returns:  Pointer to the resulting string dest.
;
; Date: 9/10/2017
;---------------------------------------------------
    mov di, dest				; Point to dest address
    mov si, src					; Point to source address

  @@destEnd:					; Find the end of the dest string
    inc di					; Increase char in di
    mov al, [di]				; Get a char from di
    or al, al					; End of dest string?
    jnz @@destEnd

  @@destAppend:					; Append the dest string
    lodsb					; Load char from si to al
    stosb					; Sotre char in al to di
    or al, al					; End of string in si?
    jnz @@destAppend

    mov ax, dest				; Point to the dest

    ret
strcat ENDP


;---------------------------------------------------
strncat PROC C USES si di cx,
    dest:PTR BYTE,
    src:PTR BYTE,
    n:PTR BYTE
;
; Summary: Concatenates or appends first n characters
;	   from src to dest. All characters from src
;	   are copied including the terminating null
;	   character.
;
; Params:  dest - Where to append the string to.
;	   src - String to be appended.
;	   n - Maximum number of characters to be appended.
;
; Returns:  Pointer to the resulting string dest.
;
; Date: 9/10/2017
;---------------------------------------------------
    mov di, dest				; Point to dest address
    mov si, src					; Point to source address
    mov cx, n					; Point to n address

  @@destEnd:					; Find the end of the dest string
    inc di					; Increase char in di
    mov al, [di]				; Get a char from di
    or al, al					; End of dest string?
    jnz @@destEnd

  @@destAppend:					; Append the dest string up to n
    lodsb					; Load char from si to al
    stosb					; Sotre char in al to di
    or al, al					; End of string in si?
    loop @@destAppend				; Repeat n times

    mov ax, dest				; Return a pointer to the dest

    ret
strncat ENDP


;---------------------------------------------------
memset PROC C USES di cx,
    string:PTR BYTE,
    char:BYTE,
    n:PTR BYTE
;
; Summary: Copies the character c to the first n
;	   characters of the string pointed to,
;	   by the argument string.
;
; Params:  string - Ptr to the block of memory to fill.
;	   char - This is the value to be set.
;	   n - Number of bytes to be set to the value.
;
; Returns:  Pointer to the resulting string dest.
;
; Date: 9/10/2017
;---------------------------------------------------
    mov di, string				; Point to str address
    mov cx, n					; Point to n address

  @@append:
    mov al, char				; Char to fill mem with
    mov [di], al				; Move the char into di
    inc di					; Increase di for next char
    loop @@append				; Loop n times

    mov ax, string				; Return a pointer to the string

    ret
memset ENDP


;---------------------------------------------------
memmove PROC C USES si di cx,
    dest:PTR BYTE,
    src:PTR BYTE,
    n:PTR BYTE
;
; Summary:  Copies n characters from src to dest.
;
; Params:  dest - Ptr to the dest array where
;		  the content is to be copied.
;	   src - Ptr to the src of data to be copied,
;	   n - Number of bytes to be copied.
;
; Returns:  Pointer to the resulting string dest.
;
; Date: 9/10/2017
;---------------------------------------------------
    mov di, dest				; Point to dest address
    mov si, src					; Point to src address
    mov cx, n					; Point to n address

  @@cpy:
    mov al, [si]				; Char from si to al
    mov [di], al				; Char from al moves into di
    inc di					; Increase di
    inc si					; Increase si
    loop @@cpy					; Repeat n times

    mov ax, dest				; Return a pointer to the dest

    ret
memmove ENDP


;---------------------------------------------------
memcpy PROC C USES si di cx,
    dest:PTR BYTE,
    src:PTR BYTE,
    n:PTR BYTE
;
; Summary:  Copies n characters from memory at the
;	    src to the memory area at the dest.
;
; Params:  dest - Ptr to the dest array where
;		  the content is to be copied.
;	   src - Ptr to the src of data to be copied,
;	   n - Number of bytes to be copied.
;
; Returns:  Pointer to the resulting string dest.
;
; Date: 9/10/2017
;---------------------------------------------------
    mov di, dest				; Point to dest address
    mov si, src					; Point to src address
    mov cx, n					; Point to n address

  @@cpy:
    mov al, [si]				; Char from si to al
    or al, al					; Is byte from si empty?
    jz @@done
    mov [di], al				; Char from al moves into di
    inc di					; Increase di
    inc si					; Increase si
    loop @@cpy					; Repeat n times

  @@done:
    mov ax, dest				; Return a pointer to the dest

    ret
memcpy ENDP


;---------------------------------------------------
memcmp PROC C USES si di bx cx,
    str1:PTR BYTE,
    str2:PTR BYTE,
    n:PTR BYTE
;
; Summary:  Compares at most the first n bytes
;	    of str1 and str2.
;
; Params:  str1 - Ptr to the dest array where
;		  the content is to be copied.
;	   str2 - Ptr to the src of data to be copied.
;	   n - Number of bytes to be copied.
;
; Returns: If str1 less than str2 return 1,
;	   If str2 less than str1 return -1,
;	   If str2 is equal to str1 return 0.
;
; Date: 9/10/2017
;---------------------------------------------------
    mov di, str1				; Point to str1 address
    mov si, str2				; Point to str2 address
    mov cx, n					; Point to n addres

    xor ax, ax					; Char number total for SI
    xor bx, bx					; Char number total for DI

  @@cmp:
    mov al, [si]				; Byte from SI
    add ah, al					; Add byte value to ah
    mov bl, [di]				; Byte from DI
    add bh, bl					; Add byte value to bh
    cmp al, bl					; If both bytes not equal then exit
    jne @@done
    or al, al					; If no bytes left then exit
    jz @@done
    inc di
    inc si
    loop @@cmp

  @@done:
    .IF bh == ah				; Return 0 if both str inputs equal
    	mov ax, 0
    .ELSEIF bh > ah				; Return 1 if str1 is greater than str2
    	mov ah, 1
    .ELSEIF bh < ah				; Return -1 if str1 is less than str2
    	mov ah, -1
    .ENDIF

    ret
memcmp ENDP


;---------------------------------------------------
memchr PROC C USES si di cx,
    string:PTR BYTE,
    char:BYTE,
    n:PTR BYTE
;
; Summary:  Searches for the first occurrence of
;	    the character c in the first n bytes
;	    of the string pointed to, by the
;	    argument string.
;
; Params:  string - Ptr to the block of memory to search.
;	   char - This is the value to search for.
;	   n - Number of bytes to be analyzed.
;
; Returns:  Pointer to the resulting string dest.
;
; Date: 9/10/2017
;---------------------------------------------------
    clearBuff return_buffer			; Clear the return buffer
    mov si, string				; Point to param address string
    mov di, offset return_buffer		; Point to the return buffer

  @@loop:
    mov al, [si]				; Get character from string
    or al, al					; End of string?
    jz @@done
    inc si					; Increase si
    cmp al, char				; Byte equal to char passed?
    jne @@loop

    mov [di], al				; Add n to buffer
    inc di					; Increase buffer

    mov cx, n					; Times to iterate
    or cx, cx					; Is n zero?
    jz @@done

  @@iterate:
    mov al, [si]				; Get character from string
    or al, al					; End of string?
    jz @@done
    mov [di], al				; Store string in return buffer
    inc di					; increase di
    inc si					; Increase si
    loop @@iterate

  @@done:
    mov ax, offset return_buffer

    ret
memchr ENDP


; ------------------------------------------------------------------
; size_t strcspn(const char *str1, const char *str2);
; ------------------------------------------------------------------
; This function calculates the length of the initial
; segment of str1, which consists entirely of characters
; not in str2.

strcspn PROC uses si di bx cx str1:WORD, str2:WORD
    mov si, str1					    ; Point to str1 address
    mov di, str2					    ; Point to str2 address

    xor cx, cx

  @@cmp:
    mov al, [si]					    ; Byte from SI
    push di						    ; Save DI

  @@char:
    mov bl, [di]					    ; Byte from DI
    cmp al, bl						    ; If both bytes equal then exit
    je @@exit
    inc di						    ; Increase DI untill zero
    or bl, bl
    jnz @@char
    pop di						    ; Restore DI
    or al, al						    ; If no bytes left then exit
    jz @@done
    inc si
    inc cx
    jmp @@cmp

  @@exit:
     pop di						    ; Restore DI

  @@done:
    mov ax, cx
    ret
strcspn ENDP


; ------------------------------------------------------------------
; char *strpbrk(const char *str1, const char *str2);
; ------------------------------------------------------------------
; This function finds the first character in the string str1
; that matches any character specified in str2. This does
; not include the terminating null-characters.

strpbrk PROC uses si di bx str1:WORD, str2:WORD
    clearBuff return_buffer

    mov si, str1						; Point to str1 address
    mov di, str2						; Point to str2 address

  @@cmp:
    mov al, [si]						; Byte from SI
    push di							; Save DI

  @@char:
    mov bl, [di]						; Byte from DI
    cmp al, bl							; If both bytes equal then exit
    je @@equal
    inc di							; Increase DI untill zero
    or bl, bl
    jnz @@char
    pop di							; Restore DI

    or al, al							; If no bytes left then exit
    jz @@error
    inc si
    jmp @@cmp

  @@equal:
    pop di
    mov di, offset return_buffer				; Found equal char

  @@fill:
    mov al, [si]
    mov [di], al
    or al, al							; If no bytes left then exit
    jz @@buff
    inc si
    inc di
    jmp @@fill

  @@buff:
    mov ax, offset return_buffer
    jmp @@done

  @@error:
    mov ax, 0							 ; Return null on char not found

  @@done:
    ret
strpbrk ENDP


; ------------------------------------------------------------------
; char *strrchr(const char *str, int n);
; ------------------------------------------------------------------
; This function searches for the last occurrence of the
; character c (an unsigned char) in the string pointed
; to, by the argument str.

strrchr PROC uses si di bx cx str1:WORD, n:BYTE
    clearBuff return_buffer

    mov si, str1						; Point to str1 address
    push si							; Save SI

    xor cx, cx							; Clear counter
    xor bx, bx							; Clear counter storage

  @@cmp:
    mov al, [si]						; Byte from SI
    cmp al, n
    je @@found							; If equal store counter in BX
    jne @@cont							; Else continue

  @@found:
    mov bx, cx

  @@cont:
    or al, al
    jz @@fill							; If no more bytes left we need to now fill the buffer
    inc si							; Increment string
    inc cx							; Increment counter
    jmp @@cmp

  @@fill:
    pop si							; Restore the string
    or bx, bx							; If stored counter is null return null
    jz @@error
    add si, bx							; Add offfset of counter and string
    mov di, offset return_buffer				; Point DI to the offset of return_buffer

  @@iterate:
    lodsb							; Get character from string
    or al, al							; End of string
    jz @@finished
    mov [di], al						; Store char into DI
    inc di							; Increase DI
    jmp @@iterate

  @@error:
    xor ax, ax
    jmp @@done

  @@finished:
    mov ax, offset return_buffer

  @@done:
    ret
strrchr ENDP


; ------------------------------------------------------------------
; size_t strspn(const char *str1, const char *str2);
; ------------------------------------------------------------------
; This function calculates the length of the initial
; segment of str1 which consists entirely of chars
; in str2.

strspn PROC uses di si cx str1:PTR WORD, str2:WORD
    mov si, str1						; Point to str1 address
    mov di, str2						; Point to str2 address

    xor cx, cx							; Clear counter

  @@cmp:
    mov al, [si]						; Byte from S
    mov bl, [di]						; Byte from DI
    cmp al, bl							; If both bytes not equal then exit
    jne @@done
    or al, al							; If no bytes left then exit
    jz @@done
    inc di
    inc si
    inc cx
    jmp @@cmp

  @@done:
    mov ax, cx							; Return counter number
    ret
strspn ENDP


; ------------------------------------------------------------------
; char *strstr(const char *haystack, const char *needle)
; ------------------------------------------------------------------
; This function finds the first occurrence of the substring
; needle in the string haystack. The terminating '\0'
; characters are not compared.

strstr PROC uses si di bx cx haystack:WORD, needle:WORD
    clearBuff return_buffer

    mov si, haystack						; Point to haystack address
    mov di, needle						; Point to needle address

    xor cx, cx							; Store n in cx for loop

  @@cmp:
    mov al, [si]						; Byte from SI
    mov bl, [di]						; Byte from DI
    cmp al, bl							; If not equal continue to iterate
    jne @@cont
    pusha

  @@cmpstr:
    mov al, [si]						; Byte from SI
    mov bl, [di]						; Byte from DI
    or bl, bl							; If end of needle return true
    je @@equal
    cmp al, bl							; Test if equal
    jne @@notequal						; If not equal continue @@cmp loop
    inc di
    inc si
    jmp @@cmpstr

  @@notequal:
    popa

  @@cont:
    or al, al							; If no bytes left then exit
    jz @@done
    inc si
    inc cx
    jmp @@cmp

 @@equal:
    popa
    mov di, offset return_buffer				; Point DI to the offset of return_buffer
    mov si, haystack						; Point to haystack address
    add si, cx

 @@iterate:
   lodsb							; Get character from string
   or al, al							; End of string
   jz @@done
   mov [di], al							; Store char into DI
   inc di							; Increase DI
   jmp @@iterate

  @@done:
    mov ax, offset return_buffer				; Return the buffer
    ret
strstr	ENDP

; ------------------------------------------------------------------
; char *strtok(char *str, const char *delim)
; ------------------------------------------------------------------
strtok PROC uses si di bx string:WORD, delim:WORD
    mov si, string						; Point to haystack address
    mov di, string						; This function makes me wanta kill myself

    clearBuff return_buffer

    mov bl, [di]						; Byte from DI
    or bl, bl
    jz @@s
    jmp @@f

  @@s:
    mov si, offset strtok_buffer
    mov di, offset return_buffer
    mov al, [si]
    or al, al
    jnz @@s_fill_return
    mov ax, 0
    jmp @@done

  @@s_fill_return:
    lodsb							; Get byte from SI into AL
    cmp al, [bp + 6]
    je @@s_found_delim
    stosb							; Store AL into DI
    or al, al							; End of string?
    jnz @@s_fill_return

  @@s_found_delim:
    mov di, offset token_buffer

  @@s_fill_token:
    lodsb							; Get byte from SI into AL
    stosb							; Store AL into DI
    or al, al							; End of string?
    jnz @@s_fill_token

    clearBuff strtok_buffer

    mov di, offset strtok_buffer
    mov si, offset token_buffer

  @@s_fill_strtok:
    lodsb							; Get byte from SI into AL
    stosb							; Store AL into DI
    or al, al							; End of string?
    jnz @@s_fill_strtok

    clearBuff token_buffer

    mov ax, offset return_buffer
    ret

  @@f:
    clearBuff strtok_buffer
    mov di, offset return_buffer	; Point to buffer address

  @@f_fill_return:
    lodsb							; Get byte from SI into AL
    cmp al, [bp+4]
    je @@f_found_delim
    stosb							; Store AL into DI
    or al, al						; End of string?
    jnz @@f_fill_return

  @@f_found_delim:
    mov di, offset strtok_buffer

  @@f_fill_strtok:
    lodsb							; Get byte from SI into AL
    stosb							; Store AL into DI
    or al, al						; End of string?
    jnz @@f_fill_strtok
    mov ax, offset return_buffer

  @@done:
    ret
strtok ENDP

; ------------------------------------------------------------------
; size_t strxfrm(char *dest, const char *src, size_t n)
; ------------------------------------------------------------------
; This function transforms the first n chars of src
; into the locale and puts them into the dest.

strxfrm PROC uses di si cx dest:WORD, src:WORD, n:PTR BYTE
    mov di, dest							; Point to str1 address
    mov si, src							; Point to str2 address

    xor cx, cx

  @@loop:								; Get length of SI
    lodsb								; Get character from string
    or al, al								; End of string
    jz @@cont
    inc cx
    jmp @@loop

  @@cont:
    push cx								; Save length of SI
    mov cx, n							; Point to n addres
    mov si, src							; Point to str2 address

  @@append:
    mov al, [si]							; Transfer contents of source to dest up to n
    mov [di], al
    inc si
    inc di
    loop @@append

  @@done:
    pop cx
    mov ax, cx
    ret
strxfrm ENDP
END
