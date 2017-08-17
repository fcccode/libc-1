; ------------------------------------------------------------------
.286							; CPU type
.model tiny						; Tiny memoy model
 extern _main:near					; Externel C kernel
.data							; Data segment
 BootDrive db  0					; Store bootdrive number
.code							; Start of code segment
; ------------------------------------------------------------------

start:
    cli					; Clear interrupts
    mov	ax, 0
    mov	ss, ax				; Set stack pointer
    mov	sp, 0FFFFh
    sti					; Restore interrupts

    mov	ax, 2000h			; Set segments to match where the kernel loaded
    mov	ds, ax
    mov	es, ax

    mov [BootDrive], dl			; Save the boot drive number
    call _main				; Call the C kernel

    hlt					; Halt the system

END start

END
