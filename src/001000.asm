    ; 1000 -- A + B

    section .data
in_fmt  db "%d%d", 0
out_fmt db "%d", 10, 0

    section .text
    global  main
    extern  printf
    extern  scanf
main:
    push    ebp
    mov     ebp, esp
    sub     esp, 16
    and     esp, -16

    lea     eax, [ebp-8]
    push    eax
    lea     eax, [ebp-4]
    push    eax
    push    in_fmt
    call    scanf
    add     esp, 12

    mov     eax, dword [ebp-8]
    add     eax, dword [ebp-4]

    push    eax
    push    out_fmt
    call    printf
    add     esp, 8

    xor     eax, eax
    leave
    ret
