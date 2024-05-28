section .data

msg:	db 10, "Hello, world!"
MSGLEN:	equ	$-msg

global _start
_start:

	mov rdi, 1
	mov rdx, 1

	mov rcx, MSGLEN

.begin_loop

	; Print 1 char at [msg + rcx - 1]

	mov rax, 1	; Syscall code in rax

	mov rsi, rcx	; rsi = addr to print
	add rsi, msg
	dec rsi

	mov r15, rcx	; Save rcx before syscall
	syscall

	mov rcx, r15	; Restore rcx

	loop .begin_loop

	;; Terminate process

	mov rax, 60
	mov rdi, 0
	syscall
