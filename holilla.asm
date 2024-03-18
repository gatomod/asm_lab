section .data
	res         db	"Response: ", 0
	.len:		    equ	$ - res

section .bss
	char:		resb	1

section .text
        global _start 

_start:
    ; request user
    mov     rax, 0
    mov     rdi, 0
    mov     rsi, char
    mov     rdx, 2
    syscall

    ; print
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, char
    mov     rdx, 2
    syscall

    mov     rax, 60
    mov     rdi, 0
    syscall

