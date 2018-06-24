    ; 1193 -- Find a Fraction

    section .data
fmt_in  db  "%d", 0
fmt_out db  "%d/%d", 10, 0

    section .text
    extern  scanf
    extern  printf

    global  main
main:
    push    ebp
    mov     ebp, esp
    sub     esp, 16
    and     esp, -16

    lea     eax, [ebp-4]
    push    eax
    push    fmt_in
    call    scanf
    add     esp, 8

    xor     eax, eax
    xor     ecx, ecx
    inc     ecx
.loop:
    mov     dword [ebp-8], eax
    mov     eax, ecx
    inc     eax
    imul    ecx
    shr     eax, 1
    cmp     dword [ebp-4], eax
    jng     .end_loop
    inc     ecx
    jmp     .loop

.end_loop:
    mov     eax, dword [ebp-4]
    sub     eax, dword [ebp-8]
    mov     edx, ecx
    sub     edx, eax
    inc     edx

    test    cl, 1
    cmovz   ecx, edx
    cmovz   edx, eax
    cmovz   eax, ecx

    push    eax
    push    edx
    push    fmt_out
    call    printf
    add     esp, 12

    xor     eax, eax
    leave
    ret
