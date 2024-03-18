extern print
extern reqb

section .data
    msg     db "Choose (s/r/q)", 0ah, "- s: Shutdown", 0ah, "- r: Reboot", 0ah, "- q: Quit", 0ah, "> ", 0
    .len:   equ $ - msg

    err     db "Please enter a valid input", 0ah, "> ", 0
    .len:   equ $ - err

	res     db	"Response: ", 0
	.len:		    equ	$ - res

    opt1    db  "s", 1
    opt2    db  "r", 1
    opt3    db  "q", 1
    

section .bss
	char:		resb	1

section .text
        global _start 

_start:
    mov     r8, msg
    mov     r9, msg.len
    call    print
    jmp     REQUEST

    BAD_INPUT:
        mov     r8, err
        mov     r9, err.len
        call    print

    REQUEST:
        mov     r8, char
        call    reqb

    mov     r8, char
    

    cmp     r8, opt1
    je      PASS
    
    mov     r9, opt2
    cmp     r8, r9
    je      PASS
    
    mov     r9, opt3
    cmp     r8, r9
    je      PASS

    jmp     BAD_INPUT

    PASS:
        mov     r8, res
        mov     r9, res.len
        call    print

        mov     r8, char
        mov     r9, 2
        call    print

        mov     rax, 60
        mov     rdi, 0
    syscall