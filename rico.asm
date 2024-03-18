section .data
    putipruva   db "hola", 0ah, 0ah, 0
    len:        equ $ - putipruva


section .text
        global _start 
_start:

    ; los syscalls se pueden llamar poniendo su número en RAX, luego pasándole cualquier parámetro
    ; opcional y poniendo el keyword syscall para llamarlo
    ;
    ; https://x64.syscall.sh/
    ;
    mov     rax, 1          ; llama al syscall 1 (write)
    mov     rdi, 1          ; primer parámetro de write
    mov     rsi, putipruva  ; segundo parámetro (el puntero del texto)
    mov     rdx, len        ; tercer parámetro (longitud del texto)
    syscall             ; llama al syscall
  
    ;mov rax, 1
    ;mov rbx, 0
    ;int 80h

    mov     rax, 60 ; llama al syscall 60
    mov     rdi, 0  ; Uno de sus parámetros es el código de salida
    syscall     ; llama al syscall

