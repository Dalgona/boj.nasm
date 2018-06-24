    ; 1152 -- The Number of Words

    section .data
format  db  "%d", 10, 0

    section .bss
buf resb    1048576

    section .text
    extern  fgets
    extern  printf
    extern  stdin

    global  main
main:
    push    ebp
    mov     ebp, esp
    sub     esp, 16
    and     esp, -16

    push    DWORD [stdin]
    push    1000001
    push    buf
    call    fgets
    add     esp, 12

    push    esi
    push    edi
    lea     esi, [buf]
    xor     edi, edi    ; # of words

    xor     ah, ah      ; flag (0 = space, 1 = word)
    xor     ecx, ecx    ; position
.loop:
    mov     al, BYTE [esi + ecx * 1]
    cmp     al, 10
    jng     .loop_end

    cmp     ah, 1
    sete    dh
    cmp     al, 32
    sete    dl
    add     dl, dh

    cmp     dl, 2
    jne     .else
    mov     ah, 0
    jmp     .endif

.else:
    cmp     dl, 0
    jne     .endif
    inc     edi
    mov     ah, 1

.endif:
    inc     ecx
    jmp     .loop

.loop_end:
    push    edi
    push    format
    call    printf
    add     esp, 8

    pop     edi
    pop     esi

    leave
    ret
