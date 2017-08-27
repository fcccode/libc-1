; ------------------------------------------------------------------
.model tiny, C
.386
extern main:near
public BootDrive
include libc.inc						; Include library headers
.data							; Data segment
BootDrive db  0					; Store bootdrive number

.code							; Start of code segment
; ------------------------------------------------------------------


start PROC
    cli					; Clear interrupts
    mov	ax, 0
    mov	ss, ax				; Set stack pointer
    mov	sp, 0FFFFh
    sti					; Restore interrupts
    mov	ax, 2000h			; Set segments to match where the kernel loaded
    mov	ds, ax
    mov	es, ax

    call main
    mov [BootDrive], dl			; Save the boot drive number
    ret				; Halt the system
start ENDp
END
