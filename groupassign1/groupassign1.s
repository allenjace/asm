section .data

zero:   dq      0.0
one:    dq      1.0
two:    dq      2.0
four:   dq      4.0
negone: dq      -1.0
limit:  dq      0.0000000001

format: db      "%f", 10, 0

section .text

extern printf

global main
main:

    push rbp
    mov rbp, rsp

    ;; Compute pi 
    movsd xmm0, qword [limit]   
    call compute_pi
    ; Return value in xmm0  

    ;; Print result
    mov rdi, format
    mov al, 1
    call printf

    mov rax, 0
    pop rbp
    ret

compute_pi:
    push rbp
    mov rbp, rsp

    mov rsi, 0                   ; let i = 0 and it increases 

.loop:
    ; 2i + 2
    cvtsi2sd xmm1, rsi           ; convert the i value to double
    mulsd xmm1, qword[two]      ; xmm1 = 2 * i
    addsd xmm1, qword[two]      ; xmm1 = 2 * i + 2

    ; 2i + 3
    movsd xmm2, xmm1             ; xmm2 = xmm1
    addsd xmm2, qword [one]      ; xmm2 = 2 * i + 3

    ; 2i + 4
    movsd xmm3, xmm1             ; xmm3 = xmm1
    addsd xmm3, qword [two]      ; xmm3 = 2 * i + 4

    ; 4/(2i+2)(2i+3)(2i+4)
    movsd xmm4, qword [four]     ; xmm4 = 4.0
    mulsd xmm1, xmm2             ; xmm1 = (2*i + 2) * (2*i + 3)
    mulsd xmm1, xmm3             ; xmm1 = (2*i + 2) * (2*i + 3) * (2*i + 4)
    divsd xmm4, xmm1             ; xmm4 = 4 / [(2*i + 2) * (2*i + 3) * (2*i + 4)]

    ; (-1)^i
    test rsi, 1                  ; check if i is odd or even
    jz .alternating_coefficient         
    mulsd xmm4, qword [negone]   ; if the sign is odd, multiply by -1

.alternating_coefficient:
    addsd xmm0, xmm4             ; add the term to to the result in xmm0

    inc rsi						 ; this increasing the i

    cvtsi2sd xmm1, rsi           
    mulsd xmm1, qword [two]      ; xmm1 = 2 * i
    addsd xmm1, qword [two]      ; xmm1 = 2 * i + 2
    movsd xmm2, xmm1             ; xmm2 = xmm1
    addsd xmm2, qword [one]      ; xmm2 = 2 * i + 3
    movsd xmm3, xmm1             ; xmm3 = xmm1
    addsd xmm3, qword [two]      ; xmm3 = 2 * i + 4
    movsd xmm4, qword [four]     ; xmm4 = 4.0
    mulsd xmm1, xmm2             ; xmm1 = (2*i + 2) * (2*i + 3)
    mulsd xmm1, xmm3             ; xmm1 = (2*i + 2) * (2*i + 3) * (2*i + 4)
    divsd xmm4, xmm1             ; xmm4 = 4 / [(2*i + 2) * (2*i + 3) * (2*i + 4)]

    comisd xmm4, qword [limit]	 ; checks for if the next term is less than the limit
    ja .loop                     ; if the next term is above the limit then it continues the loop

    addsd xmm0, qword[two]
    addsd xmm0, qword[one]

	; xmm0 = approximation limit
	; return result in xmm0
    pop rbp
    ret
