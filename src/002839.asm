    ; 2839 -- Sugar Delivery

    section .data
in_fmt  db  "%d", 0
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
    push    in_fmt
    call    scanf
    add     esp, 8

    mov     eax, dword [ebp-4]
    xor     edx, edx
    mov     ecx, 5
    idiv    ecx

    mov     dword [ebp-16], ebx
    mov     ecx, eax
.loop:
    cmp     ecx, 0
    jl      .end_loop
    imul    eax, ecx, -5
    add     eax, dword [ebp-4]
    xor     edx, edx
    mov     ebx, 3
    idiv    ebx
    cmp     edx, 0
    jz      .found
    dec     ecx
    jmp     .loop

.found:
    add     eax, ecx
    push    eax
    push    out_fmt
    call    printf
    add     esp, 8
    jmp     .prog_exit

.end_loop:
    push    -1
    push    out_fmt
    call    printf
    add     esp, 8

.prog_exit:
    mov     ebx, dword [ebp-16]
    xor     eax, eax
    leave
    ret
