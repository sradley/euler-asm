%macro exit 1
    mov     eax, 1
    mov     ebx, %1
    int     0x80
%endmacro

%macro write 1
    mov     eax, %1
    push    eax
    push    fmt
    call    printf
    add     esp, 4
%endmacro

section .data
fmt     db      "%d", 0xA, 0
curr    dd      1
prev    dd      1
total   dd      0

section .text
    extern  printf
    global  _start

_start:
    mov     eax, [curr]
    mov     edx, 0
    mov     ebx, 2
    div     ebx
    cmp     edx, 0
    jnz     end
    mov     eax, [curr]
    add     [total], eax
end:
    mov     eax, [prev]
    mov     ebx, [curr]
    add     [curr], eax
    mov     [prev], ebx
    cmp     dword [curr], 4000000
    jl      _start
    write   [total]
    exit    0
