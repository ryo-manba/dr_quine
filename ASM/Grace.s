%define FILENAME "Grace_kid.s"
%define SELF "%%define FILENAME %2$cGrace_kid.s%2$c%1$c%%define SELF %2$c%3$s%2$c%1$c%1$c%%macro MAIN 0%1$cextern dprintf%1$csection .text%1$c  global main%1$c%1$cmain:%1$c  push rbp%1$c  mov rbp, rsp%1$c  sub rsp, 8%1$c%1$c  lea rdi, [rel filename]%1$c  mov rsi, 1101o%1$c  mov rdx, 0644o%1$c  mov rax, 2%1$c  syscall%1$c%1$c  cmp rax, 0%1$c  jl error%1$c%1$c  push rax%1$c%1$c  mov rdi, rax%1$c  lea rsi, [rel format]%1$c  mov rdx, 10%1$c  mov rcx, 34%1$c  lea r8, [rel format]%1$c  call dprintf wrt ..plt%1$c%1$c  pop rdi%1$c  mov rax, 3%1$c  syscall%1$c%1$c  xor rax, rax%1$c  leave%1$c  ret%1$c%1$cerror:%1$c  mov rax, 1%1$c  leave%1$c  ret%1$c%1$csection .data%1$c  format: db SELF, 0%1$c  filename: db FILENAME, 0%1$c%1$csection .note.GNU-stack%1$c%%endmacro%1$c%1$c; quine using macros%1$cMAIN%1$c"

%macro MAIN 0
extern dprintf
section .text
  global main

main:
  push rbp
  mov rbp, rsp
  sub rsp, 8

  lea rdi, [rel filename]
  mov rsi, 1101o
  mov rdx, 0644o
  mov rax, 2
  syscall

  cmp rax, 0
  jl error

  push rax

  mov rdi, rax
  lea rsi, [rel format]
  mov rdx, 10
  mov rcx, 34
  lea r8, [rel format]
  call dprintf wrt ..plt

  pop rdi
  mov rax, 3
  syscall

  xor rax, rax
  leave
  ret

error:
  mov rax, 1
  leave
  ret

section .data
  format: db SELF, 0
  filename: db FILENAME, 0

section .note.GNU-stack
%endmacro

; quine using macros
MAIN
