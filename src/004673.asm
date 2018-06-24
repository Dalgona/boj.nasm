    ; 4673 -- Self Numbers

    section .data
fmt db      "%d", 10, 0

    section .bss
flags:
    resb    10001

    section .text
    extern  printf
    global  main
main:
    push    ebp
    mov     ebp, esp
    push    ebx
    push    esi

    push    0
    push    fmt
    mov     ebx, flags
    xor     esi, esi
    inc     esi
.outer_loop:
    cmp     esi, 10000
    jg      .end_outer_loop

    cmp     BYTE [ebx + 1 * esi], 0
    jne     .continue_outer_loop

    mov     DWORD [esp + 4], esi
    call    printf

    mov     eax, esi
.inner_loop:
    call    d
    cmp     eax, 10000
    jg      .continue_outer_loop

    mov     BYTE [ebx + 1 * eax], 1
    jmp     .inner_loop

.continue_outer_loop:
    inc     esi
    jmp     .outer_loop

.end_outer_loop:
    add     esp, 8
    xor     eax, eax

    pop     esi
    pop     ebx
    leave
    ret

d:
    push    ebx
    xor     ebx, ebx
    mov     bl, 10
    mov     ecx, eax

.loop:
    test    eax, eax
    jz      .end_loop
    cdq
    idiv    ebx
    add     ecx, edx
    jmp     .loop

.end_loop:
    mov     eax, ecx
    pop     ebx
    ret
