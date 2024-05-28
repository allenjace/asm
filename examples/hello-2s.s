;;;
;;; hello-2s.s
;;; Hello, world in two stages.
;;;
bits 16
org 0x7c00

; ------------------------
; Stage 1 
; ------------------------

	; 1. Reset disk
	mov ah, 0x0				; Subfunction 0 = reset disk
	mov al, 0x80			; Disk number(first "fixed" disk)
	int 0x13				; 0x13 = disk related functions
	jmp skip

.skip:
	; 2. Perform extended read
	mov ah, 0x42			; Subfunction 0x42 = extended read
	mov dl, 0x80			;	 Disk read
	mov si, disk_pkt			; Address of disk packet
	int 0x13

	jmp begin_stage2

; ------------------
; Stage 1 data section
; -------------------

align 2
disk_pkt:
	db	  16				; Always 16
	db 	  0 				; Always 0 (reserved)
	dw	  blk_count			; Number of blocks to read
	dd    begin_stage2		; Addr. to read into
	dd	  1                 ; Block to start at

; Pad with 0s
times 510 - ($ - $$) db 0

; Signature bytes
dw 0xaa55




; ----------------------
; Stage 2
; ----------------------
begin_stage2:



; Number of blocks, rounded up
blk_count: equ ($ - begin_stage2 + 511) / 512
