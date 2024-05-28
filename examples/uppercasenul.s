section .data

string: db "hello i am allen! ", 10

section .text

global _start
_start:

	mov rdi, string
	call to_upper


to_upper:
	mov rax, 0

.begin_loop:
	cmp byte [rdi], 0
	je .end_loop

	cmp byte [rdi], 'a'
	jnae .continue
	cmp byte [rdi], 'z'
	jnbe .continue

	; [rdi] is lowercase

	sub byte[rdi], 'a' - 'A' 	; make upper
	inc rax

.continue:
	inc rdi
	jmp .begin_loop

.end_loop:
	ret
