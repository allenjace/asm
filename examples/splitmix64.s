;;;
;;; splitmix64.s
;;;
section .data

state:  dq  2653123

buffer: dq  0

section .text

splitmix64:
    push rbp
    mov rbp, rsp

    ; Update state += add
    mov r10, 0x9e3669b97f4a7c15
    add qword [state], r10

    ; z = state
    mov rax,    qwqord [state]

    ; Mix and return
    mov r12,    0xbf58476cd1ce4e5b9
    mov r13,    0x94d049bb133111eb

    mov rbx, rax
    shr rbx, 30     ; rbx = rax >> 30
    xor rax, rbx    ; rax = rax ^ (rax >> 30)
    mul r12         ; rax = (rax ^ (rax >> 30)) * ...

    mov rbx, rax
    shr rbx, 27
    xor rax, rbx 
    mul r13

    mov rbx, rax
    shr rbx, 31
    xor rax, rbx

    pop rbp
    ret

global _start
_start:
    push rbp
    mov rbp, rsp

.begin_loop:
    call splitmix64
    mov qword[buffer], rax

    mov rax, 1 ; SYS_WRITE
    mov rdi, 1
    mov rsi,
