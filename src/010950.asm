    ; 10950 -- A + B (3)

    section .data
in_1d   db  "%d", 0
in_2d   db  "%d%d", 0
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

    lea     eax, [ebp-4]
    push    eax
    push    in_1d
    call    scanf
    add     esp, 8

.loop:
    cmp     dword [ebp-4], 0
    jng     .end_loop

    lea     eax, [ebp-12]   ; b
    push    eax
    lea     eax, [ebp-8]    ; a
    push    eax
    push    in_2d
    call    scanf
    add     esp, 12

    mov     eax, dword [ebp-8]
    add     eax, dword [ebp-12]
    push    eax
    push    out_fmt
    call    printf
    add     esp, 8

    sub     dword [ebp-4], 1
    jmp     .loop

.end_loop:
    xor     eax, eax
    leave
    ret
