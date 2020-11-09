%macro exit 1
    mov     eax, 1
    mov     ebx, %1
    int     0x80
%endmacro

%macro write 1                      ;write n
    mov     eax, %1
    push    eax
    push    fmt
    call    printf                  ;printf("%d\n", n)
    add     esp, 4
%endmacro

section .data
fmt     db      "%d", 0xA, 0        ;format string for printing numbers
curr    dd      1                   ;current fibonacci number
prev    dd      1                   ;previous fibonacci number
total   dd      0                   ;sum of even fibonacci numbers

section .text
    extern  printf
    global  _start

_start:
    mov     eax, [curr]
    mov     edx, 0
    mov     ebx, 2
    div     ebx
    cmp     edx, 0                  ;eax = curr % 2 == 0 
    jnz     end                     ;if curr is not even, don't add to total
    mov     eax, [curr]
    add     [total], eax            ;total += curr
end:
    mov     eax, [prev]
    mov     ebx, [curr]             ;tmp = curr
    add     [curr], eax             ;curr = curr + prev
    mov     [prev], ebx             ;prev = tmp
    cmp     dword [curr], 4000000
    jl      _start                  ;if curr < 4,000,000, continue iteration
    write   [total]                 ;print sum of even fibonacci numbers  
    exit    0
