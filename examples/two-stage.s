;;;
;;; two-stage.s
;;
;;;

bits 16
org 0x7c00

start:
origin:		equ 0x7c00
blk_count:	equ	(end - loaded_code) / 512 + 1

;
; First stage lodaer

; Reset disk
mov ah, 0x0  ; Subfunction reset
mov dl, 0x80 ; Disk number
int 0x13

jmp loaded_code

; Begin "pusedo-data" section

string:			db "Hello, world!"
strlen: 		equ $-string
screen_addr:	equ 0xb8000

align 2
disk_packet:	db 0x10 		; Packet size
				db 0 			; Reserved
				dw blk_count	; Block count
				dd loaded_code	; Addr. to load
				dd 16			;  Starting block

; Pad remainder with 0 bytes
times 510 - ($ - $$) db 0

; Write boot signature at end
dw 0xaa55
