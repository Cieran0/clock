bits 64
global    _start

section   .text

get_hour:
        mov     rax,qword[timevalue] ; qword[timevalue]  % 86400
        ;add     rax, 3600 FIXME: Daylight saving needs to be checked
        mov     rcx, 86400
        xor     rdx,rdx
        div     rcx
        mov     rax,rdx ; / 3600
        mov     rcx, 3600
        xor     rdx,rdx
        div     rcx
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

place:
        mov     rax, qword[r11]
        mov     r9,row_1
        mov     qword[r9+r10], rax
        mov     rax, qword[r11+8]
        mov     r9,row_2
        mov     qword[r9+r10], rax
        mov     rax, qword[r11+16]
        mov     r9,row_3
        mov     qword[r9+r10], rax
        mov     rax, qword[r11+24]
        mov     r9,row_4
        mov     qword[r9+r10], rax
        mov     rax, qword[r11+32]
        mov     r9,row_5
        mov     qword[r9+r10], rax
        ret

add_num:
                mov     r11,num_0
        cmp_1:
                cmp     al, 1
                jne     cmp_2
                mov     r11,num_1
        cmp_2:
                cmp     al, 2
                jne     cmp_3
                mov     r11,num_2
        cmp_3:
                cmp     al, 3
                jne     cmp_4
                mov     r11,num_3
        cmp_4:
                cmp     al, 4
                jne     cmp_5
                mov     r11,num_4
        cmp_5:
                cmp     al, 5
                jne     cmp_6
                mov     r11,num_5
        cmp_6:
                cmp     al, 6
                jne     cmp_7
                mov     r11,num_6
        cmp_7:
                cmp     al, 7
                jne     cmp_8
                mov     r11,num_7
        cmp_8:
                cmp     al, 8
                jne     cmp_9
                mov     r11,num_8
        cmp_9:
                cmp     al, 9
                jne     cmp_10
                mov     r11,num_9
        cmp_10:
                call place
                ret

add_hour:
        xor     rax,rax
        mov     al, byte[hour]
        mov     rcx,10
        mov     rdx,0
        div     rcx
        call    add_num
        mov     al,dl
        mov     r10,8
        call    add_num
        ret

add_min:
        xor     rax,rax
        mov     al, byte[min]
        mov     rcx,10
        mov     rdx,0
        div     rcx
        mov     r10,24
        call    add_num
        mov     al,dl
        mov     r10,32
        call    add_num
        ret

print:
        mov     rax,1
        mov     rdi,1
        mov     rsi,row_1
        mov     rdx,41
        syscall
        mov     rsi,row_2
        mov     rax,1
        syscall
        mov     rsi,row_3
        mov     rax,1
        syscall
        mov     rsi,row_4
        mov     rax,1
        syscall
        mov     rsi,row_5
        mov     rax,1
        syscall
        ret

_start:
        mov     rax, 96
        mov     rdi, timevalue
        mov     rsi, timezone
        syscall
        call    get_hour
        call    add_hour
        call    get_min
        call    add_min
        call    print
end:
        mov     rax, 60
        xor     rdi, rdi
        syscall

section   .data

row_1:      db        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"   /\   ",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10
row_2:      db        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"   \/   ",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10
row_3:      db        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"        ",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10
row_4:      db        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"   /\   ",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10
row_5:      db        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"   \/   ",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10
hour:       db        0
min:        db        0
timevalue:  db        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
timezone:   db        0,0,0,0,0,0,0,0

num_0:   db" 000000 "," 00  00 "," 00  00 "," 00  00 "," 000000 "
num_1:   db" 1111   ","   11   ","   11   ","   11   "," 111111 "
num_2:   db" 222222 ","      2 "," 222222 "," 2      "," 222222 "
num_3:   db" 333333 ","     33 "," 333333 ","     33 "," 333333 "
num_4:   db" 44  44 "," 44  44 "," 444444 ","     44 ","     44 "
num_5:   db" 555555 "," 55     "," 555555 ","     55 "," 555555 "
num_6:   db" 666666 "," 66     "," 666666 "," 66  66 "," 666666 "
num_7:   db" 777777 ","     77 ","     77 ","     77 ","     77 "
num_8:   db" 888888 "," 88  88 "," 888888 "," 88  88 "," 888888 "
num_9:   db " 999999 "," 99  99 "," 999999 ","     99 "," 999999 "