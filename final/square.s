
; square.s 
;
;
;
section .data

newline:	db	10
star: 		db '*'
space:		db ' '

buffer:		times 1000 db 0

section .text

global _start
_start:	
	mov rsi, 5
print_stars:
	cmp rsi, 0
	je .done

	mov r12, rsi ; outer loop index
	mov r13, rsi ; saved size

.outer_loop:
	mov r14, r12 ; inner loop index

.inner_loop:
	; print one #

	mov rax, 1 
	mov rdi, 1 
	mov rsi, star
	mov rdx, 1
	syscall

	dec r14 
	cmp r14, 0

	jne .inner_loop

	mov rax, 1
	mov rdi, 1
	mov rsi, newline
	mov rdx, 1
	syscall


.done:
	ret

	
