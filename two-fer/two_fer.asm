default rel

section .text
global two_fer

two_fer:
        push rdi                ; Save NAME on the stack
        mov rdi, rsi            ; Load target buffer for string_append
        lea rsi, [Beginning]    ; Load string to append
        call string_append

        pop rsi                 ; Get NAME from stack
        cmp rsi, 0              ; Is NAME NULL
        jne finish              ; GoTo finish: if NAME is not NULL

        lea rsi, [you]          ; Get default name you: if NAME is NULL

finish:
        dec rdi                 ; Realign rdi to blast null terminator
        call string_append      ; Write NAME or "you"
        lea rsi, [Ending]
        dec rdi                 ; Realign rdi to blast null terminator
        call string_append      ; Write the end.
        ret

;;; Helper
;;; Assume rdi is set up as the target buffer.
;;; Assume rsi is the string to append.
;;; This subroutine expects null terminated c strings.
string_append:
        mov dl, byte [rsi]      ; Get byte from rsi
        mov byte [rdi], dl      ; Write byte into buffer
        ;; Inc both pointers
        inc rdi
        inc rsi

        cmp dl, 0               ; Check if we just wrote the null terminator
        jnz string_append       ; Loop
        ret

        section .rodata
you:
        db "you", 0
Beginning:
        db "One for ", 0
Ending:
        db ", one for me.", 0
