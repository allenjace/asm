section .data

state:	dq	137546 ; Seed value

buffer:	dq	0

section .text

global	_start
_start:

	push rbp
	mov rbp, rsp

.loop:
	call next
	mov [buffer], rax

	mov rax, 1 			; Write syscall
	mov rdi, 1  		; Stdout
	mov rsi, buffer		; Address
	mov rdx, 8			; Length
	syscall

	jmp .loop

	pop rbp

	mov rax, 60
	mov rdi, 0 
	syscall

next:
	push rbp
	mov rbp, rsp

	; Constants
	mov r8, 0xbf58476d1ce4e5b9
	mov r9, 0x94d049bb133111eb
	mov r10, 0x9e3779b97f4a7c15

	; Update state
	add qword [state], r10
	mov rax, qword [state]

	; z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9
	mov rbx, rax
	shr rbx, 30
	xor rax, rbx
	mul r8

	; z = (z ^ (z >> 27)) * 0x94d049bb13311eb
	mov rbx, rax
	shr rbx, 27
	xor rax, rbx
	mul r9

	; return z ^ (z>> 31)
	mov rbx, rax 
	shr rbx, 31
	xor rax, rbx

	pop rbp
	ret
