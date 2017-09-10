; ------------------------------------------------------------------
.model tiny, c							; Small memoy model
.386								; 80386 CPU
 include fat.inc						; Include library headers
.code								; Start of code segment
; ------------------------------------------------------------------



;---------------------------------------------------
resetFloppy PROC USES ax dx

; void resetFloppy(void)

; Reset the floppy disk.
; Receives: nothing
; Returns:  carry on error
; Date: 9/6/2017
;---------------------------------------------------
    clc						; Clear carry flag
    mov ah, 0					; Reset Disk Drive
    mov dl, [BootDrive]				; Bootdrive number (default 0 or drive A:)
    int	    13h					; Low-level disk services
    ret
resetFloppy ENDP


; ------------------------------------------------------------------
; void openRoot(void)
; ------------------- -----------------------------------------------
; Open the root directory and set the root directory buffer

openRoot PROC uses ax bx cx dx
    sti
    mov ax, 19					; Root dir starts at logical sector 19
    call convert_sector				; Convert logical root sectors
    mov	si, rootBuffer				; Load the root buffer into si
    mov bx, si					; Load buffer into ES:BX
    mov	al, 14					; Number of sectors
    mov	ah, 2					; Read Sectors From Drive
  @@load:					; Load the root directory
    pusha
    int	    13h					; Low-level disk services
    jnc	@@loaded				; Root has been loaded on no carry set
    call resetFloppy				; Reset the floppy disk
    jmp	@@load					; Try to load the root contents again
  @@loaded:
    popa
    mov ax, offset rootBuffer
    ret
openRoot ENDP


; ------------------------------------------------------------------
; void closeRoot(void)
; ------------------------------------------------------------------
; Close the root directory, flush the root directory buffer and
; reset the file counter

closeRoot PROC
    mov rootBuffer, 24576			; Reset filebuffer
    mov fileStat, 0				; Clear file index
    ret
closeRoot ENDP


fmtFatFilename PROC uses di si cx bx dx string:WORD
    clearBuff fmtBuf
    invoke strlen, string
    mov ax, dx
    mov si, string
    mov di, offset fmtBuf
    xor cx, cx
    xor ax, ax
    .REPEAT
	lodsb					; Load the first
	.IF al == '.'				; If '.' found
	    .IF cx == 0				; Fail if extension dot is first char
		mov ax, 0			; Return -1 on error
		ret
	     .ELSE
		.WHILE cx < 8		        ; Fill filename untill equal to 8
		    mov al, ' '			; Pad with a space
		    stosb			; Store the space
		    inc cx			; Increase the counter
		.ENDW
	    .ENDIF
	     lodsb				; Load the extention
	     .IF al == 0			; If no extension char
		mov ax, 0			; Return -1 on error
		ret
	     .ENDIF
	   invoke toupper, ax			; Convert char to an upercase char
	    stosb				; Store the extention
	    lodsb			        ; Load the extention
	     .IF al == 0			; If no extension char
		mov ax, 0			; Return -1 on error
		ret
	     .ENDIF
	    invoke toupper, ax			; Convert char to an upercase char
	    stosb				; Store the extention
	    lodsb				; Load the extention
	     .IF al == 0			; If no extension char
		mov ax, 0			; Return -1 on error
		ret
	     .ENDIF
	    invoke toupper, ax			; Convert char to an upercase char
	    stosb				; Store the extention
	    mov al, 0				; Zero termanate the string
	    stosb
	    mov ax, offset fmtBuf		; Return the fat12 formatted filename
	    ret
	.ENDIF
	invoke toupper, ax			; Convert char to an upercase char
	stosb					; Store the filename
	inc cx					; Increase counter
	.IF cx > dx				; If no '.' found
	    mov ax, 0				; Return -1 on error
	    ret
	.ELSEIF cx > 8
	    mov ax, 0
	    ret
	.ENDIF
    .UNTIL 0
    ret
fmtFatFilename ENDP


; ------------------------------------------------------------------
; int rename(const char *old_filename, const char *new_filename);
; ------------------------------------------------------------------
; This function renames a file from the old filename
; passed to the new filename input, returns 0 on
; success and -1 on failure.

rename PROC uses si di cx oldName:WORD, newName:WORD
call resetFloppy
    invoke fmtFatFilename, oldName		; Format the old name into the fat filename fmt
    mov dx, ax					; Store the formatted filename in dx
    call openRoot				; Open the root dir and set buffer
    mov si, dx					; Point to the filename to find
    mov	di, rootBuffer				; Move the buffer into di
    mov	cx, 224					; Loop 224 times (max root entrys)
    xor ax, ax					; Clear ax for the root offset
  @@loop:					; Search through the root dir for the file
    push cx					; Save current cx value for loop
    mov	si, dx					; Point to the filename to find
    mov	cx, 11					; Loop 11 times
    repe cmpsb
    je  @@foundFile				; Found the file!
    add	ax, 32					; Add to the root offset
    mov	di, rootBuffer				; Move the buffer into di
    add	di, ax					; Add the offset to the root buffer
    pop	cx					; Restore the cx loop value
    loop @@loop					; Continue to seach through the root dir
    mov ax, -1					; File not found!
    ret
  @@foundFile:
    pop cx					; Restore cx, if not then causes memory error
    sub di, 11					; Reset the root buffer offset to the begining
    invoke fmtFatFilename, newName		; Format the new name into the fat filename fmt
    mov si, ax					; Point to the filename to change
    mov cx, 11					; Loop 11 times
    rep movsb
    call writeRoot				; Write data to the modifyed root entry
    call closeRoot				; Close and flush root buffer
    mov ax, 0
    ret
rename ENDP

; ------------------------------------------------------------------
; struct rootEnt* readRoot(void)
; ------------------------------------------------------------------
; Iterate over the entire root directory, please use the
; openRoot() and  CloseRoot() functions before
; calling to this function. Returns a struct of the root
; entry found, NULL on finished

readRoot PROC uses si
    mov	si, rootBuffer
    mov cx, fileStat
    .IF cx == -1
	mov ax, 0
    .ELSE
	inc cx
	mov fileStat, cx
	.REPEAT
	    mov	al, [si + 11]
	    ; Windows marker || Directory marker || deleted file
	    .IF al == 0fh || al == 18h || al == 0e5h
		add si, 32
		.CONTINUE
	    .ELSEIF al == 0
		mov cx, -1
	    	mov fileStat, cx
		mov ax, 0
		.BREAK
	    .ELSE
		mov dx, si
		mov cx, 8					; Store the filename
		clearBuff staticFileBuf.fileName
		mov di, offset staticFileBuf.fileName
		.REPEAT
		    lodsb					; Load string
		    .IF al == ' '				; Skip over a space
			.CONTINUE
		    .ENDIF
		    stosb					; Store string
		.UNTILCXZ					; Repeat 8 times
		mov cx, 3					; Store the extension
		clearBuff staticFileBuf.fileExtension
		mov di,offset staticFileBuf.fileExtension
		.REPEAT
		    lodsb					; Load string
		    stosb					; Store string
		.UNTILCXZ					; Repeat 8 times
		mov si, dx

		mov ax, [si + 11]			        ; Attribute
		movzx ax, al					; Clear byte ah
		mov staticFileBuf.fileAttribute, ax

		mov ax, [si + 16]			        ; Created Day
    		and ax, 1fh					; Clear year and month bits
   		mov staticFileBuf.fileCreatedDay, ax

		mov ax, [si + 16]			        ; Created Month
		and ax, 1e0h					; Clear year and day bits
		shr ax, 5				        ; Rotate bits right by five
		mov staticFileBuf.fileCreatedMonth, ax

		mov ax, [si + 16]			        ; Created Year
		and ax, 0fe00h 					; Clear day and month bits
		shr ax, 9				        ; Rotate bits right by nine
		add ax, 1980					; Add 1980 to the result to get the year
		mov staticFileBuf.fileCreatedYear, ax

		mov ax, [si + 18]			        ; Last access Day
		and ax, 1fh					; Clear year and month bits
		mov staticFileBuf.fileAccessedDay, ax

		mov ax, [si + 18]			        ; Last access Month
		and ax, 1e0h					; Clear year and day bits
		shr ax, 5				        ; Rotate bits right by five
		mov staticFileBuf.fileAccessedMonth, ax

		mov ax, [si + 18]			        ; Last access Year
		and ax, 0fe00h 					; Clear day and month bits
		shr ax, 9				        ; Rotate bits right by nine
		add ax, 1980					; Add 1980 to the result to get the year
		mov staticFileBuf.fileAccessedYear, ax

		mov ax, [si + 24]			        ; Modified Day
		and ax, 1fh					; Clear year and month bits
		mov staticFileBuf.fileModifiedDay, ax

		mov ax, [si + 24]			        ; Modified Month
		and ax, 1e0h					; Clear year and day bits
		shr ax, 5				        ; Rotate bits right by five
		mov staticFileBuf.fileModifiedMonth, ax

		mov ax, [si + 24]			        ; Modified Year
		and ax, 0fe00h 					; Clear day and month bits
		shr ax, 9				        ; Rotate bits right by nine
		add ax, 1980					; Add 1980 to the result to get the year
		mov staticFileBuf.fileModifiedYear, ax

		mov ax, [si + 26]			        ; Start cluster
		mov staticFileBuf.startCluster, ax

		mov staticFileBuf.FileLength, 0
		mov ax, [si + 28]			        ; File size
		mov staticFileBuf.FileLength, si

		add si, 32
		mov rootBuffer, si
		mov ax, offset staticFileBuf
		.BREAK
	    .ENDIF
	.UNTIL 0
    .ENDIF
  ret
readroot ENDP


writeRoot PROC uses si ax bx cx
    mov ax, 19					; Root dir starts at logical sector 19
    call convert_sector				; Convert root sectors
    mov si, rootBuffer				; Point to the root buffer
    mov bx, ds
    mov es, bx
    mov bx, si
    mov ah, 3					; Write floppy sectors
    mov al, 14					; Write 14 sectors
    stc						; Clear carry flag
    int	    13h					; Write sectors
    jc @@error
    clc						; Clear carry on succuss
    ret
  @@error:
    stc						; Set carry on error
    ret
writeRoot ENDP


convert_sector PROC uses bx ax
    mov bx, ax					; Save logical sector
    xor dx, dx					; First the sector
    div [SecsPerTrack]				; Sectors per track
    add dl, 01h					; Physical sectors start at 1
    mov cl, dl					; Sectors belong in CL for int 13h
    mov ax, bx
    xor dx, dx					; Now calculate the head
    div [SecsPerTrack]				; Sectors per track
    xor dx, dx
    div [Sides]					; Floppy sides
    mov dh, dl					; Head/side
    mov ch, al					; Track
    mov dl, [BootDrive]
    ret
convert_sector ENDP


end