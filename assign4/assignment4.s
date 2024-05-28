;;;;
;;;; xoroshiro64.s
;;;; 
section .data

s0:	dd	137546
s1:	dd	729

buffer:	dd	0

section	.text

global	_start
_start:

	push rbp
	mov rbp, rsp

.loop:
	call next
	mov dword[buffer], eax; ; Return value from next in eax

	mov rax, 1 			; Write syscall
	mov rdi, 1 			; Stdout
	mov rsi, buffer		; Address
	mov rdx, 4			; Length
	syscall

	jmp .loop

	pop rbp

	mov rax, 60
	mov rdi, 0
	syscall

next:
	; Next function here.
	
	mov eax, dword[s0] 
	mov ebx, dword[s1]

	mov r8d, 0x9E3779BB ; constant
	
	mov ecx, eax
	imul ecx, r8d
	rol ecx, 5
	imul ecx, 5
	mov dword[buffer], ecx

	xor ebx, eax ; s1 ^= s0
	
	; mov edx, eax ; moves value of eax into edx 
	rol eax, 26 ; rotates state 0 by 26
	xor eax, ebx ; state 1 ^ state 0 
	shl ebx, 9 ; shifting state 1 by 9
	xor eax, ebx
	mov dword[s0], eax
	
;	mov r9d, ebx ; moves state 1 into another register
	rol ebx, 13 ; rotates state 1 by 13
	mov dword[s1], ebx ; puts the result back in dword value of state 1
	
	
	
	; Return results in eax.
	mov eax, dword[buffer]
	
	ret
