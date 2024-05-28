;;; 
;;; hello-int.s
;;; Prints Hello, world! from the MBR using interrupts
;;;
bits 16			; We're writing 16-bit code
org 0x7c00		; Code will run at address 0x7c00

;; ---- Boot Code ----

	; Switch to text mode
	mov ah, 0x0		; Subfunction 0 = Set video mode
	mov al, 0x3		; Video mode 3 = 80x25 text mode
	int 0x10		; Interrupt 0x10 (16) = Video-related functions

	; Loop over string, until NUL
	mov edi, 		; String index
begin_loop:
	cmp byte [msg + di], 0
	je forever

	; Write char to screen
	mov ah, 0xa					; Subfunction 0xa (10) = WRite char.
	mov al, byte [msg + di] 	; Char to print
	mov bh, 0					; Page number
	mov cx, 1 					; Number of copies
	int 0x10

	inc edi
	jmp begin_loop

	; Infinite loop
	forever: jmp forever

;; ---- "Data" Section -----

msg: db "Hello, world", 0

;Pad to 510 bytes
times 510 - ($ - $$) db 0

