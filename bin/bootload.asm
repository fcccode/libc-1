
    BITS 16

    jmp bootEntry

    OEMName		db "LIBCBOOT"
    BytesPerSector	dw 512
    SectorsPerCluster	db 1
    ReservedSectors	dw 1
    Fats		db 2
    RootDirEntries	dw 224
    Sectors		dw 2880
    Media		db 0f0h
    FatSectors		dw 9
    SectorsPerTrack	dw 18
    Heads		dw 2
    HiddenSectors	dd 0
    HugeSectors		dd 0
    DriveNumber		db 0
    Reserved		db 0
    FirstSector		dw 0
    Pointer		dw 0
    BootSignature	db 29h
    VolumeId		dd 0h
    VolumeLabel		db "LIBC VOLUME"
    FileSystemType	db "FAT12   "

bootEntry:
    cli					    ; Set up stack  
    xor ax, ax		
    mov ss, ax
    mov sp, 0ffffh
    mov ax, 07c0h			    ; Set up registers
    mov ds, ax
    mov es, ax
    sti

    mov [DriveNumber], dl		    ; Store bootdrive number
  
    sti
    mov	ch, 0				    ; Track
    mov	cl, 2				    ; Sector
    mov	dh, 1				    ; Head
    mov	bx, buffer			    ; Buffer
    mov	al, 14				    ; Number of sectors
    mov	ah, 2

loadRoot:				    ; Load the root directory
    pusha
    int	    13h
    jnc	loadedRoot
    call resetFloppy
    jmp	loadRoot
loadedRoot:
    popa
    mov	di, buffer
    mov	cx, 224
searchRoot:				    ; Search through the root dir for the kernel image
    push cx
    pop dx
    mov	si, KernelImage
    mov	cx, 11
    rep	cmpsb
    je  foundFile			    ; Found the file!
    add	ax, 32
    mov	di, buffer
    add	di, ax
    push dx
    pop	cx
    loop searchRoot			    ; Cont search root for file
    mov si, BootFailure			    ; Kernel not found!
    call print
    mov ah, 0
    int	    16h				    ; Get keypress and reboot system
    db 0eah 
    dw 0000h
    dw 0ffffh 
foundFile:				    
    mov si, BootSuccess
    call print
    mov	ax, [di + 15]
    mov	[FirstSector], ax		    ; Load file table
    mov	bx, buffer
    mov ax, 1
    call convertSector
    mov	al, 9
    mov	ah, 2
    pusha
loadFat:				    ; Load fat12 system
    int	13h
    jnc	loadedFat
    call resetFloppy
    jmp	loadFat
loadedFat:
    mov ah, 2
    mov al, 1
    push ax
loadFileSector:
    mov ax, [FirstSector]
    add ax, 31
    call convertSector
    mov ax, 2000h			    ; Load file into first sector/ RAM
    mov es, ax
    mov bx, [Pointer]
    pop ax
    push ax
    int	    13h
    jnc calculateNextSector
    call resetFloppy
    jmp loadFileSector
calculateNextSector:
    mov ax, [FirstSector]
    mov dx, 0
    mov bx, 6
    mul bx
    mov bx, 4
    div bx
    mov si, buffer
    add si, ax
    mov ax, [si]
    or dx, dx
    jz evenSector
oddSector:
    shr ax, 4
    jmp short nextSectorCalculated
evenSector:
    and ax, 0fffh
nextSectorCalculated:
    mov [FirstSector], ax
    cmp	ax, 0ff8h
    jae	kernelJump
    add	WORD [Pointer], 512
    jmp	loadFileSector
kernelJump:
    pop ax  
    mov dl, [DriveNumber]
    jmp 2000h:0000h			    ; Jump to our loaded kernel	at 2000h


convertSector:				    ;  Convert fat12 sector
    push bx
    push ax
    mov	bx, ax
    mov	dx, 0
    div	WORD [SectorsPerTrack]
    add	dl, 01h
    mov	cl, dl
    mov	ax, bx
    mov	dx, 0
    div WORD [SectorsPerTrack]
    mov	dx, 0
    div	WORD [Heads]
    mov	dh, dl
    mov	ch, al
    pop	ax
    pop	bx
    mov	dl, [DriveNumber]
    ret

resetFloppy:				    ; Rest the floppy disk on error
    mov ah, 0
    mov dl, [DriveNumber]
    int	    13h
    ret

print:					    ; Print out a string
    lodsb				    ; Get character from string
    or al, al
    jz .done				    ; If char is zero, end of string
    mov ah, 0eh				    ; int 10h 'print char' function
    int     10h				    ; Otherwise, print it
    jmp print
.done: 
    ret
    

    KernelImage		db "KERNEL  BIN"	
    BootSuccess		db "Boot success: loading the boot image", 13, 10, 0
    BootFailure		db "Boot failed: could not find the kernel image", 13, 10, 13, 10,
			db "Press any key to reboot.", 0

    times 510-($-$$) db 0		    ; Fill boot sector to 512 bytes
    dw 0aa55h				    ; Boot sector signature 
    buffer:				    ; byte 513
