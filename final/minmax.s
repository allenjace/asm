; minmax.s

section .data

section .text

global _start
_start:
	; rdi = qword address of array
	; rsi = qword length 
	; rdx = min 
	; rcx = max

	push rbp
	mov rbp, rsp

	lea [rdi * 8 + rsi]
	
.smallestLoop:
	cmp qword[rdi] ; compare each element to find the smallest number
	jmp .minFound
	
	
.largestLoop:
	cmp qword[rdi] ; compare each element to find the largest number
	jmp .largestFound

.minFound:
	mov rdx, rdi ; pointer to the smallest element
	jmp .largestLoop

		
.maxFound:
	mov rcx, rdi ; pointer to the largest element
	jmp .done

.done:
	mov rsp, rbp
	pop rbp
	ret
	
