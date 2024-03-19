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

    
    mov     r10b, byte [char]
    
    mov     r11b, byte [opt1]
    
    mov     r11b, byte [opt1]
    cmp     r10b, r11b
    je      SHUTDOWN
    
    mov     r11b, byte [opt2]
    cmp     r10b, r11b
    je      REBOOT
    
    mov     r11b, byte [opt3]
    cmp     r10b, r11b
    je      EXIT

    jmp     BAD_INPUT

    mov     rax, 162     ; sync
    syscall

    mov     rax, 306    ; syncfs
    mov     rdi, 0
    syscall

    SHUTDOWN:
        mov     rax, 169            ; reboot
        mov     rdi, 0xfee1dead
        mov     rsi, 0x05121996
        mov     rdx, 0x4321fedc     ; LINUX_REBOOT_CMD_POWER_OFF
        syscall

        jmp     EXIT
    
    REBOOT:
        mov     rax, 169            ; reboot
        mov     rdi, 0xfee1dead
        mov     rsi, 0x05121996
        mov     rdx, 0x1234567      ; LINUX_REBOOT_CMD_RESTART
        syscall

        jmp     EXIT

    EXIT:
        mov     rax, 60
        mov     rdi, 0
    syscall