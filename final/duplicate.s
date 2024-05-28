; duplicate .s

section .text

global _start
_start:
	push rbp
	mov rbp, rsp

	add rdx, rsi ; end of the array
	mov rax, 0

has_duplicate_pair:
	cmp rsi, rdx
	je .done

	cmp qword [rsi], rdi
	je .returnFalse

	mov rax, 1
	jmp .done


.returnFalse:
	add rsi, 8
	jmp has_duplicate_pair

.done:
	pop rbp
	ret






	
