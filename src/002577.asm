    ; 2577 -- The number of digits

    section .data
fmt_in      db      "%d%d%d", 0, 0
fmt_out     db      "%d", 10, 0

    section .bss
count       resd    10

    section .text
    extern  scanf
    extern  printf
    global  main
main:
    push    ebp
    mov     ebp, esp
    sub     esp, 16
    and     esp, -16
    push    ebx
    push    esi
    mov     esi, count

    lea     eax, [ebp - 4]
    push    eax
    sub     eax, 4
    push    eax
    sub     eax, 4
    push    eax
    push    fmt_in
    call    scanf
    add     esp, 16

    mov     eax, DWORD [ebp - 4]
    imul    DWORD [ebp - 8]
    imul    DWORD [ebp - 12]

    xor     ecx, ecx
    mov     cl, 10
.div_loop:
    test    eax, eax
    jz      .end_div_loop

    cdq
    idiv    ecx
    inc     DWORD [esi + 4 * edx]
    jmp     .div_loop

.end_div_loop:
    push    0
    push    fmt_out
    xor     ebx, ebx
.print_loop:
    cmp     bl, 10
    jnl     .end_print_loop

    mov     eax, DWORD [esi + 4 * ebx]
    mov     DWORD [esp + 4], eax
    call    printf
    inc     ebx
    jmp     .print_loop

.end_print_loop:
    add     esp, 8

    xor     eax, eax
    pop     esi
    pop     ebx
    leave
    ret
