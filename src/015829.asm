    ; 15829 -- Hashing

    section .rodata
fmt_in_len  db      "%d", 0, 0
fmt_in_str  db      "%s", 0, 0
fmt_out     db      "%d", 10, 0

    section .bss
buf         resb    64
exp_arr     resd    64

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
    push    edi

    mov     ebx, 1234567891
    mov     esi, buf

    lea     eax, [ebp - 4]
    push    eax
    push    fmt_in_len
    call    scanf
    add     esp, 8

    push    buf
    push    fmt_in_str
    call    scanf
    add     esp, 8

    push    ebx
    push    DWORD [ebp - 4]
    push    31
    call    pow_mod
    add     esp, 12

    xor     eax, eax
    mov     DWORD [ebp - 8], eax
    mov     edi, exp_arr
    xor     ecx, ecx
.sum_loop:
    cmp     cl, BYTE [ebp - 4]
    jnl     .end_sum_loop

    xor     eax, eax
    mov     al, BYTE [esi + 1 * ecx]
    sub     al, 0x60
    imul    DWORD [edi + 4 * ecx]
    idiv    ebx
    add     edx, DWORD [ebp - 8]
    mov     eax, edx
    xor     edx, edx
    setc    dl
    idiv    ebx
    mov     DWORD [ebp - 8], edx
    inc     ecx
    jmp     .sum_loop

.end_sum_loop:
    push    edx
    push    fmt_out
    call    printf
    add     esp, 8

    xor     eax, eax
    pop     edi
    pop     esi
    pop     ebx
    leave
    ret

pow_mod:
    push    ebp
    mov     ebp, esp
    push    ebx
    push    esi
    push    edi

    mov     esi, DWORD [ebp + 16]
    mov     edi, exp_arr
    mov     eax, DWORD [ebp + 8]
    cdq
    idiv    esi
    mov     ebx, edx

    xor     ecx, ecx
    xor     eax, eax
    inc     eax
.mul_loop:
    cmp     ecx, DWORD [ebp + 12]
    jnl     .end_mul_loop

    mov     DWORD [edi + 4 * ecx], eax
    imul    ebx
    idiv    esi
    mov     eax, edx
    inc     ecx
    jmp     .mul_loop

.end_mul_loop:
    pop     edi
    pop     esi
    pop     ebx
    leave
    ret
