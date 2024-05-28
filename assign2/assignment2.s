section .data

BUFLEN:		equ					20
buffer:		times BUFLEN db 	0 ; Buffer of 20 '\0's
newline:	db					10

section .text

global _start
_start:

	mov rsi, 1
	mov rdi, 10
	call print_int

	mov rsi, 1
	mov rdi, 186562354
	call print_int

	mov rsi, 1
	mov rdi, 0xdeadbeef12345678		; = 16045690981402826360 decimal
	call print_int

	;	End program
	mov rax, 60
	mov rdi, 0
	syscall

print_int:
	; dividing repeatedly so use a loop

	xor r10, r10
	mov rcx, BUFLEN ; moving 20 which into rcx to be the loop counter
	mov r10, buffer ; point to the buffer
	add r10, BUFLEN - 1 ; pointing to the end of the array
	mov rax, rdi
	mov rbx, rdi 
	mov r8, 10 ; division by 10 repeatedly

.begin_loop:
	xor rdx, rdx ; clearing out the uses
	div r8 ; division of rax:rdi by 10
	add rdx, 48 ; add zero's ascii value to rdx so it can print out 0's
	mov byte[r10], dl ; store remainder in buffer, dword accumulator
	dec r10 ; continue on to the next byte

	loop .begin_loop

	mov rax, 1
	mov rdi, 1
	mov rsi, buffer
	mov rdx, BUFLEN
	syscall
	
	mov rax, 1
	mov rdi, 1
	mov rsi, newline
	mov rdx, 1
	syscall
	
	ret
