    section .data
fmt db      "%d", 0, 0
    dd      0

triangle:
    db      42, 32, 32, 32, 32, 32, 32, 32
    db      42, 32, 42, 32, 32, 32, 32, 32
    db      42, 42, 42, 42, 42, 32, 32, 32

    section .text
    extern  scanf
    extern  putchar
    global  main
main:
    push    ebp
    mov     ebp, esp
    sub     esp, 16
    and     esp, -16

    lea     eax, [ebp - 4]
    push    eax,
    push    fmt
    call    scanf
    add     esp, 8

    push    esi
    push    edi
    push    ebx
    push    10

    xor     esi, esi
.outer_loop:
    cmp     esi, DWORD [ebp - 4]
    jnl     .end_outer_loop

    mov     eax, DWORD [ebp - 4]
    mov     ecx, esi
    call    print_margin

    mov     ebx, esi
    shl     ebx, 1
    inc     ebx
    xor     edi, edi
.inner_loop:
    cmp     edi, ebx
    jnl     .end_inner_loop

    push    edi
    push    esi
    push    DWORD [ebp - 4]
    call    guess_char
    push    eax
    call    putchar
    add     esp, 16

    inc     edi
    jmp     .inner_loop

.end_inner_loop:
    mov     eax, DWORD [ebp - 4]
    mov     ecx, esi
    call    print_margin

    call    putchar
    inc     esi
    jmp     .outer_loop

.end_outer_loop:
    add     esp, 4
    pop     ebx
    pop     edi
    pop     esi

    xor     eax, eax
    leave
    ret

print_margin:
    push    ebx
    push    32
    mov     ebx, eax
    sub     ebx, ecx

.loop:
    cmp     ebx, 1
    jng     .end_loop
    call    putchar
    dec     ebx
    jmp     .loop

.end_loop:
    add     esp, 4
    pop     ebx
    ret

guess_char:
    push    ebp
    mov     ebp, esp

    cmp     DWORD [ebp + 8], 3
    jg      .do_recursion

    mov     ecx, DWORD [ebp + 12]
    mov     edx, DWORD [ebp + 16]
    lea     eax, [edx + 8 * ecx + triangle]
    mov     al, BYTE [eax]

    leave
    ret

.do_recursion:
    push    ebx
    mov     ebx, DWORD [ebp + 8]
    mov     eax, ebx
    shr     ebx, 1
    cmp     DWORD [ebp + 12], ebx
    setge   cl
    cmp     DWORD [ebp + 16], eax
    setl    dl
    mov     al, cl
    or      al, dl
    jz      .blank

    push    DWORD [ebp + 16]
    push    DWORD [ebp + 12]
    push    ebx
    xor     eax, eax
    test    cl, cl
    cmovnz  eax, ebx
    xor     ecx, ecx
    test    dl, dl
    cmovz   ecx, DWORD [ebp + 8]
    sub     DWORD [esp + 4], eax
    sub     DWORD [esp + 8], ecx
    call    guess_char
    add     esp, 12

    pop     ebx
    leave
    ret

.blank:
    mov     eax, 32
    pop     ebx
    leave
    ret
