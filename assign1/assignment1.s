section .data

prompt: 	db	"What is your name? "
prompt_len:	equ	$-prompt

buffer:	times 255 db '!'

resp1:		db		"Hello, "
resp1_len:	equ		$-resp1
resp2:		db		", nice to meet you!", 10
resp2_len:	equ		$-resp2 

section .text

global _start
_start:

	mov rax, 1
	mov rdi, 1
	mov rsi, prompt
	mov rdx, prompt_len
	syscall

	mov rax, 0
	mov rdi, 0
	mov rsi, buffer
	mov rdx, 255
	mov r10, 0
	syscall

	mov r10, rax
	mov rax, 1
	mov rdi, 1
	mov rsi, resp1
	mov rdx, resp1_len-1
	syscall

	mov rax, 1
	mov rdi, 1
	mov rsi, buffer-1
	mov rdx, r10
	syscall
	
	mov rax, 1
	mov rdi, 1
	mov rsi, resp2
	mov rdx, resp2_len
	syscall

	mov rax, 60
	xor rdi, rdi
	syscall
