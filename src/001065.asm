    ; 1065

    section .data
in_fmt  db  "%d", 0
out_fmt db  "%d", 10, 0

    section .bss
numstr  resb    8
count   resd    1

    section .text
    global  main
    extern  scanf
    extern  printf
    extern  snprintf
main:
    push    ebp
    mov     ebp, esp
    sub     esp, 16
    and     esp, -16

    lea     eax, [ebp-4]
    push    eax
    push    in_fmt
    call    scanf

    emms
    xor     ecx, ecx
    mov     cl, 1
.loop:
    cmp     ecx, dword [ebp-4]
    jg      .end_loop
    cmp     ecx, 100
    jl      .inc_count

    push    ecx
    call    check_num
    pop     ecx
    test    al, al
    jnz     .inc_count

    inc     ecx
    jmp     .loop
.inc_count:
    inc     dword [count]
    inc     ecx
    jmp     .loop

.end_loop:
    emms
    push    dword [count]
    push    out_fmt
    call    printf
    add     esp, 8

    xor     eax, eax
    leave
    ret

    global  check_num
check_num:
    push    dword [esp+4]
    push    in_fmt
    push    8
    push    numstr
    call    snprintf
    add     esp, 16
    dec     eax

    movq    mm0, qword [numstr]
    movq    mm1, mm0
    psrlq   mm1, 8
    psubb   mm1, mm0
    movq    qword [numstr], mm1

    xor     ecx, ecx
.loop:
    cmp     cl, al
    jnl     .end_loop
    mov     dl, byte [numstr+ecx*1]
    cmp     dl, byte [numstr]
    jne     .no_match
    inc     ecx
    jmp     .loop

.no_match:
    xor     eax, eax
    ret

.end_loop:
    mov     eax, 1
    ret
