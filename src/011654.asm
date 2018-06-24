    ; 11654 -- ASCII Code

    section .data
out_fmt db  "%d", 10, 0

    section .text
    global  main
    extern  getchar
    extern  printf
main:
    call    getchar
    push    eax
    push    out_fmt
    call    printf
    add     esp, 8
    xor     eax, eax
    ret
