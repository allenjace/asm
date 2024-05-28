; count_chars.s
; counts and returns the number of times a digit character (0-9)
; occurs in the (NUL-terminated) string s

section .data

section .text

global _start
_start:
	push rbp
	mov rbp, rsp
	; rsi = char* s
	; rcx = length of the string
	; rax = returned number of times a digit character occurs
xor rax, rax ; clear out uses to prepare for returned number


.count_digit:
	mov rcx, rsi 
	cmp byte [rcx], 0
	rep 

	
	cmp byte[rsi], 0
	jnae .foundCharacter

	cmp byte[rsi]  9
	jnbe .foundCharacter 
	
	je .done
	

.foundCharacter:
	inc rax
	jmp .count_digit


.done:
	mov rsp, rbp 
	pop rbp
	
	ret


