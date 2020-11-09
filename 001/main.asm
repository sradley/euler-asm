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

%macro divis 1                      ;divis n
    mov     eax, [i]
    mov     edx, 0
    mov     ebx, %1
    div     ebx
    cmp     edx, 0                  ;eax = i % n == 0
%endmacro

section .data
fmt     db      "%d", 0xA, 0        ;format string for printing numbers
i       dd      0                   ;counter for iteration
total   dd      0                   ;sum of numbers divisble by 3 and 5

section .text
    extern  printf
    global  _start

sum:
    mov     eax, [i]
    add     [total], eax            ;total += i
    jmp     end

_start:
    divis   3
    jz      sum                     ; if i % 3 == 0, add i to total
    divis   5
    jz      sum                     ; if i % 5 == 0, add i to total
end:
    inc     dword [i]               ;++i
    cmp     dword [i], 1000
    jl      _start                  ;if i < 1000, continue iteration
    write   [total]                 ;print sum of numbers divisible by 3 and 5
    exit    0
    ret
