    ; 5622 -- Dial

    section .data
fmt_input   db  "%s", 0
fmt_output  db  "%d", 10, 0
dial:
    times 3 dd  3
    times 3 dd  4
    times 3 dd  5
    times 3 dd  6
    times 3 dd  7
    times 4 dd  8
    times 3 dd  9
    times 4 dd  10

    section .bss
buf resb    16

    section .text
    extern  scanf
    extern  printf

    global  main
main:
    push    ebp
    mov     ebp, esp

    push    ebx
    push    esi

    push    buf
    push    fmt_input
    call    scanf
    add     esp, 8

    xor     eax, eax
    xor     ecx, ecx
    xor     edx, edx
    lea     ebx, [dial]
    lea     esi, [buf]
.loop:
    mov     dl, BYTE [esi + ecx * 1]
    test    dl, dl
    jz      .end_loop
    sub     dl, 65      ; 'A'

    add     eax, DWORD [ebx + edx * 4]

    inc     ecx
    jmp     .loop

.end_loop:
    push    eax
    push    fmt_output
    call    printf
    add     esp, 8

    pop     esi
    pop     ebx

    leave
    ret
