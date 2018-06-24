    ; 9012 -- Parentheses

    section .data
fmt_in  db  "%d", 0
fmt_ins db  "%s", 0
str_yes db  "YES", 0
str_no  db  "NO", 0

    section .bss
buf     resb    64

    section .text
    extern  scanf
    extern  puts
    extern  snprintf

    global  main
main:
    push    ebp
    mov     ebp, esp
    sub     esp, 16
    and     esp, -16

    mov     dword [ebp-16], str_no
    mov     dword [ebp-12], str_yes

    lea     eax, [ebp-4]
    push    eax
    push    fmt_in
    call    scanf
    add     esp, 8

.loop:
    cmp     dword [ebp-4], 0
    jng     .end_loop

    call    check_vps
    lea     edx, [ebp-16]
    push    dword [edx+eax*4]
    call    puts
    add     esp, 4

    dec     dword [ebp-4]
    jmp     .loop

.end_loop:
    xor     eax, eax
    leave
    ret

    global  check_vps
check_vps:
    push    ebp
    mov     ebp, esp
    sub     esp, 16
    and     esp, -16

    push    buf
    push    fmt_ins
    call    scanf
    add     esp, 8
    xor     eax, eax
    mov     dword [ebp-4], eax
    xor     ecx, ecx

.loop:
    mov     dl, byte [buf+ecx*1]
    cmp     dl, 0
    je      .end_loop

    cmp     dl, 40  ; '('
    jne     .closing_paren
    inc     eax
    inc     ecx
    jmp     .loop

.closing_paren:     ; ')'
    test    eax, eax
    jz      .no_match
    dec     eax
    inc     ecx
    jmp     .loop

.no_match:
    xor     eax, eax
    leave
    ret

.end_loop:
    test    eax, eax
    jnz     .no_match
    mov     eax, 1
    leave
    ret
