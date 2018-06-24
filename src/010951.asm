    ; 10951 -- A + B (4)

    section .data
in_fmt  db  "%d%d", 0
out_fmt db  "%d", 10, 0

    section .text
    global  main
    extern  scanf
    extern  printf
main:
    push    ebp
    mov     ebp, esp
    sub     esp, 16
    and     esp, -16

    lea     eax, [ebp-8]    ; b
    push    eax
    lea     eax, [ebp-4]    ; a
    push    eax
    push    in_fmt

.loop:
    call    scanf
    cmp     eax, 2
    jne     .end_loop
    mov     eax, dword [ebp-4]
    add     eax, dword [ebp-8]
    push    eax
    push    out_fmt
    call    printf
    add     esp, 8
    jmp     .loop

.end_loop:
    add     esp, 12
    xor     eax, eax
    leave
    ret
