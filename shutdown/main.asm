extern print
extern reqb

; Data (text and options)
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
    
; Init input byte
section .bss
	char:		resb	1

; Main
section .text
        global _start 

_start:
    ; Print options message
    mov     r8, msg
    mov     r9, msg.len
    call    print

    ; After printing, jump to REQUEST
    jmp     REQUEST

    ; Bad input
    ; If request is invalid jumps here to start again with the request
    BAD_INPUT:
        mov     r8, err
        mov     r9, err.len
        call    print

    ; Request input
    REQUEST:
        mov     r8, char
        call    reqb

    ; After requesting the action, call sync and syncfs to prevent data loss before calling reboot

    mov     rax, 162     ; sync
    syscall

    mov     rax, 306    ; syncfs
    mov     rdi, 0
    syscall

    ; Move option to register R10B
    mov     r10b, byte [char]
    
    ; Shutdown option
    mov     r11b, byte [opt1]
    cmp     r10b, r11b
    je      SHUTDOWN
    
    ; Reboot option
    mov     r11b, byte [opt2]
    cmp     r10b, r11b
    je      REBOOT
    
    ; Exit option
    mov     r11b, byte [opt3]
    cmp     r10b, r11b
    je      EXIT

    ; If none of the previous option matches jump to BAD_INPUT to start again

    jmp     BAD_INPUT

    ; Reboot syscall to shutdown
    SHUTDOWN:
        mov     rax, 169            ; reboot
        mov     rdi, 0xfee1dead
        mov     rsi, 0x05121996
        mov     rdx, 0x4321fedc     ; LINUX_REBOOT_CMD_POWER_OFF
        syscall

        jmp     EXIT ; I don't know if this is required or the kernel kills this program after the syscall
    
    ; Reboot syscall to reboot
    REBOOT:
        mov     rax, 169            ; reboot
        mov     rdi, 0xfee1dead
        mov     rsi, 0x05121996
        mov     rdx, 0x1234567      ; LINUX_REBOOT_CMD_RESTART
        syscall

        jmp     EXIT

    ; Exit the program with code 0
    EXIT:
        mov     rax, 60
        mov     rdi, 0
        syscall
