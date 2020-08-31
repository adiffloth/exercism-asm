bits 64
section .text
global leap_year
leap_year:
    push rbp            ; Preverse rpb (belongs to caller)
.div_by_100:
    mov rax, rdi        ; Copy year to dividend
    xor rdx,rdx         ; Set remainder to 0
    mov rbx, 100        ; Set divisor to 100
    div rbx
    cmp rdx, 0
    jne .div_by_4       ; If year is not divisible by 100
.div_by_400:            ; At this point, year is divisible by 100
    mov rax, rdi        ; Copy year to dividend
    xor rdx,rdx         ; Set remainder to 0
    mov rbx, 400        ; Set divisor to 400
    div rbx
    cmp rdx, 0
    jne .is_not_leap    ; If year is not divisible by 400, it's not leap
.is_leap:
    mov rax, TRUE
    jmp .end
.div_by_4:              ; At this point year is not divisible by 100
    mov rax, rdi        ; Copy year to dividend
    xor rdx,rdx         ; Set remainder to 0
    mov rbx, 4          ; Set divisor to 4
    div rbx
    cmp rdx, 0
    je .is_leap
.is_not_leap:
    mov rax, FALSE
.end:
    pop rbp             ; Restore rbp
    ret

section .data
    TRUE    equ 1
    FALSE   equ 0