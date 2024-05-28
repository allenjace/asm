section .data

newline: db 10
star: db '*'

section .text

global _start
_start:

print_stars:
	mov rdi, 5
	mov r12, rdi

.outer_loop:
	cmp r12, 0
	je .finish_loop
	
	mov r13, r12

	.inner_loop:
		mov rax, 1
		mov rdi, 1
		mov rsi, star
		mov rdx, 1 
		syscall

		dec r13
		cmp r13, 0
		jne .inner_loop

		mov rax, 1
		mov rdi, 1
		mov rsi, newline
		mov rdx, 1
		syscall

	dec r12
	jmp .outer_loop

.finish_loop
	ret
