; group members allen pulido and jacob kim

section .data

section .text

global strcat
global strncat
global strchr

strcat:
	; rdi = destination
	; rsi = source
.while_dest_loop:
	cmp byte[rdi], 0
	je .while_source_loop
	inc rdi
	jmp .while_dest_loop

.while_source_loop:
	cmp byte[rsi], 0
	je .done
	movsb
	inc rdi
	inc rsi
	jmp .while_source_loop
	
.done:
	xor rdi, rdi
	ret


strncat:
	; rdi = destination
	; rsi = source
	; rax = n
.while_dest_loop:
	cmp byte[rdi], 0
	je .while_source_loop
	inc rdi
	jmp .while_dest_loop

.while_source_loop:
	cmp byte[rsi], 0
	je .done
	cmp byte [rax], 0
	je .done
	movsb
	inc rdi
	dec rax
	jmp .while_source_loop

.done:
	xor rdi, rdi
	ret


strchr:
	; rsi = char* s
	; rdi = char c

.while:
	cmp byte[rsi], 0
	je .nullptr
	
	cmp byte[rsi], byte[rdi]
	
	inc rsi
	jmp .while

.nullptr:
	ret
		
	
