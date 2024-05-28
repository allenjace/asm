section .data
newline: db 10
char: db '0'

section .text

global _start
_start:

	mov rdi, 6
	call print_tri

	mov rax, 60
	mov rdi, 0
	syscall

print_tri:

	; rdi = size
	mov r12, rdi ; triangle size
	mov r13, 0


.begin_out:
	cmp r13, r12
	jnb .end_outer

	mov byte[char], '0'
	mov r14, 0

.begin_inner:
	cmp r14, r13
	jnbe .end_inner

	; Print char
	mov rax, 1
	mov rdi, 1
	mov rsi, char
	mov rdx, 1
	syscall

	inc byte[char]
	inc r14
	jmp .begin_inner

.end_inner:

	; Print newline
	mov rax, 1
	mov rdi, 1
	mov rsi, newline
	mov rdx, 1
	syscall

	inc r13
	jmp .begin_out

.end_outer:
	ret
