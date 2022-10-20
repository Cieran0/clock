bits 64
global    _start

section   .text

_start:     
        mov       rax, 96
        mov       rdi, timevalue
        mov       rsi, timezone 
        syscall
        mov       r9,qword[timevalue]                 
        mov       qword[hour],r9
        mov       rax, qword[hour]
        xor       rdx,rdx
        mov       rcx,86400
        div       rcx
        mov       rax,rdx
        mov       rdx,0
        mov       rcx,3600
        div       rcx
        add       rax, 1
        mov       qword[hour],rax
        cmp       rax, 18
        jne       notst                
        mov       rax, 1                  ; system call for write
        mov       rdi, 1                  ; file handle 1 is stdout
        mov       rsi, seventeen               ; address of string to output
        mov       rdx, 8                  ; number of bytes
notst:
        syscall                           ; invoke operating system to do the write
        mov       rax, 60                 ; system call for exit
        xor       rdi, rdi                ; exit code 0
        syscall                           ; invoke operating system to exit

section   .data

seventeen:  db        "18",10
hour:       db        0,0,0,0,0,0,0,0
timevalue:  db        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0      ; note the newline at the end
timezone:   db        0,0,0,0,0,0,0,0                      ; note the newline at the end