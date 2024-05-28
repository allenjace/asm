section .data

newline: db 10
star: db '*'

section .text

global _start
_start:	

print_stars:
	mov rsi, 5
	mov r12, rsi ; save count

.while1:
	cmp r12, 0
	je .done

	; Print r12 many stars
	mov r13, r12

	.do:
		mov rax, 1
		mov rdi, 1
		mov rsi, star
		mov rdx, 1
		syscall

		dec r13
		cmp r13, 0
		jne .do
		
		; Print newline
		mov rax, 1
		mov rdi, 1
		mov rsi, newline
		mov rdx, 1
		syscall

		dec r12
		jmp .while1

.done
	ret
