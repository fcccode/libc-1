;------------------------------------------------------------
.286							; CPU type
;------------------------------------------------------------
.model tiny						; Tiny memoy mod
;------------------------------------------------------------
extern _kmain:near				; Externel C kernel
 ;------------------------------------------------------------
.data							; Data segment
	BootDrive db  0				; Store bootdrive number
;------------------------------------------------------------
.code							; Code segment
	org			  0				; Start of code
;------------------------------------------------------------

main:
	jmp short main_kernel
	nop		

; ------------------------------------------------------------------
; main_kernel -- The main MASM kernel 
; IN/OUT: Nothing
   
main_kernel:
	cli                         ; Clear interrupts
	mov	ax, 0   
	mov	ss, ax                  ; Set stack pointer
	mov	sp, 0FFFFh
	sti                         ; Restore interrupts

	mov	ax, 2000h               ; Set segments to match where the kernel loaded 
	mov	ds, ax
	mov	es, ax


	mov	[BootDrive], dl         ; Save the boot drive number
	call _kmain					; Call the C kernel
	
	hlt							; Halt the system 
	
END main

END