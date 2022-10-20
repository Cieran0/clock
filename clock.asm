bits 64
global    _start

section   .text


get_hour:
        mov     rax,qword[timevalue] ; qword[timevalue]  % 86400
        mov     rcx, 86400
        xor     rdx,rdx
        div     rcx
        mov     rax,rdx ; / 3600
        mov     rcx, 3600
        xor     rdx,rdx
        div     rcx
        add     rax,1 ; + 1
        mov     byte[hour], al
        ret

get_min:
        mov     rax,qword[timevalue] ; qword[timevalue]  % 86400
        mov     rcx, 86400
        xor     rdx,rdx
        div     rcx
        mov     rax,rdx ; % 3600
        mov     rcx, 3600
        xor     rdx,rdx
        div     rcx
        mov     rax,rdx ; /60
        mov     rcx, 60
        xor     rdx,rdx
        div     rcx
        mov     byte[min], al
        ret

print_hour:
        mov     al, byte[hour]
        add     al, 60
        mov     byte[empty],al
        mov     rax,1
        mov     rdi,1
        mov     rsi,empty
        mov     rdx,2
        syscall
        ret

print_min:
        mov     al, byte[min]
        add     al, 40
        mov     byte[empty],al
        mov     rax,1
        mov     rdi,1
        mov     rsi,empty
        mov     rdx,2
        syscall
        ret

_start:
        mov     rax, 96
        mov     rdi, timevalue
        mov     rsi, timezone
        syscall
        call    get_hour
        call    print_hour
        call    get_min
        call    print_min
end:
        mov     rax, 60
        xor     rdi, rdi
        syscall

section   .data

empty:      db        0,10
hour:       db        0
min:        db        0
timevalue:  db        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
timezone:   db        0,0,0,0,0,0,0,0