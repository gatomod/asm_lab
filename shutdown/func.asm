; Request 1 char to user
global reqb
reqb:
    mov     rax, 0      ; Call read
    mov     rdi, 0      ; fc
    mov     rsi, r8   ; buffer pointer
    mov     rdx, 2      ; read 2 chars (trailing enter)
    syscall

    ret

; print

global print
print:
    mov     rax, 1      ; Call write
    mov     rdi, 1      ; fc
    mov     rsi, r8     ; data buffer
    mov     rdx, r9     ; data length
    syscall

    ret
