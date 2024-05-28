duplicate:
	push rbp
	mov rbp, rsp
	mov r11, rdi
	lea r12, [rsi * 8 + rdi]

.while_loop:
	cmp r11, r12
	je .noDuplicate



	.yesDuplicate:
		mov rax, 1
		pop rbp 
		ret
		
	.noDuplicate:
		mov rax, 0
		pop rbp
