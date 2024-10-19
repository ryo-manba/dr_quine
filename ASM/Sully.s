extern dprintf
extern sprintf
extern printf
extern system

section .text
  global main

main:
  push rbp
  mov rbp, rsp
  sub rsp, 32

  mov r15, 5

%ifdef CHILD
  dec r15
%endif

  cmp r15, 0
  jl done

  ; open file
  lea rdi, [rel filename]
  lea rsi, [rel filename_format]
  mov rdx, r15
  xor rax, rax
  call sprintf wrt ..plt

  lea rdi, [rel filename]
  mov rsi, 1101o ; O_CREAT | O_WRONLY | O_TRUNC
  mov rdx, 0644o
  mov rax, 2 ; sys_open
  syscall

  cmp rax, 0
  jl error
  mov r14, rax

  ; write file
  mov rdi, r14
  lea rsi, [rel format]
  mov rdx, 10
  mov rcx, 34
  lea r8, [rel format]
  mov r9, r15
  xor rax, rax
  call dprintf wrt ..plt

  ; close file
  mov rdi, r14
  mov rax, 3 ; sys_close
  syscall

  ; run compile
  lea rdi, [rel compile_cmd]
  lea rsi, [rel compile_cmd_format]
  mov rdx, r15
  xor rax, rax
  call sprintf wrt ..plt

  lea rdi, [rel compile_cmd]
  call system wrt ..plt

  ; execute file
  lea rdi, [rel exec_cmd]
  lea rsi, [rel exec_cmd_format]
  mov rdx, r15
  xor rax, rax
  call sprintf wrt ..plt

  lea rdi, [rel exec_cmd]
  call system wrt ..plt

  jmp done

error:
  mov rax, 1
  leave
  ret

done:
  xor rax, rax
  leave
  ret

section .data
  filename_format: db "Sully_%d.s", 0
  compile_cmd_format: db "nasm -f elf64 -d CHILD Sully_%1$d.s -o Sully_%1$d.o && gcc -Wall -Wextra -Werror Sully_%1$d.o -o Sully_%1$d", 0
  exec_cmd_format: db "./Sully_%d", 0
  format: db "extern dprintf%1$cextern sprintf%1$cextern printf%1$cextern system%1$c%1$csection .text%1$c  global main%1$c%1$cmain:%1$c  push rbp%1$c  mov rbp, rsp%1$c  sub rsp, 32%1$c%1$c  mov r15, %4$d%1$c%1$c%%ifdef CHILD%1$c  dec r15%1$c%%endif%1$c%1$c  cmp r15, 0%1$c  jl done%1$c%1$c  ; open file%1$c  lea rdi, [rel filename]%1$c  lea rsi, [rel filename_format]%1$c  mov rdx, r15%1$c  xor rax, rax%1$c  call sprintf wrt ..plt%1$c%1$c  lea rdi, [rel filename]%1$c  mov rsi, 1101o ; O_CREAT | O_WRONLY | O_TRUNC%1$c  mov rdx, 0644o%1$c  mov rax, 2 ; sys_open%1$c  syscall%1$c%1$c  cmp rax, 0%1$c  jl error%1$c  mov r14, rax%1$c%1$c  ; write file%1$c  mov rdi, r14%1$c  lea rsi, [rel format]%1$c  mov rdx, 10%1$c  mov rcx, 34%1$c  lea r8, [rel format]%1$c  mov r9, r15%1$c  xor rax, rax%1$c  call dprintf wrt ..plt%1$c%1$c  ; close file%1$c  mov rdi, r14%1$c  mov rax, 3 ; sys_close%1$c  syscall%1$c%1$c  ; run compile%1$c  lea rdi, [rel compile_cmd]%1$c  lea rsi, [rel compile_cmd_format]%1$c  mov rdx, r15%1$c  xor rax, rax%1$c  call sprintf wrt ..plt%1$c%1$c  lea rdi, [rel compile_cmd]%1$c  call system wrt ..plt%1$c%1$c  ; execute file%1$c  lea rdi, [rel exec_cmd]%1$c  lea rsi, [rel exec_cmd_format]%1$c  mov rdx, r15%1$c  xor rax, rax%1$c  call sprintf wrt ..plt%1$c%1$c  lea rdi, [rel exec_cmd]%1$c  call system wrt ..plt%1$c%1$c  jmp done%1$c%1$cerror:%1$c  mov rax, 1%1$c  leave%1$c  ret%1$c%1$cdone:%1$c  xor rax, rax%1$c  leave%1$c  ret%1$c%1$csection .data%1$c  filename_format: db %2$cSully_%%d.s%2$c, 0%1$c  compile_cmd_format: db %2$cnasm -f elf64 -d CHILD Sully_%%1$d.s -o Sully_%%1$d.o && gcc -Wall -Wextra -Werror Sully_%%1$d.o -o Sully_%%1$d%2$c, 0%1$c  exec_cmd_format: db %2$c./Sully_%%d%2$c, 0%1$c  format: db %2$c%3$s%2$c, 0%1$c  filename: db 20 dup(0)%1$c  compile_cmd: db 100 dup(0)%1$c  exec_cmd: db 100 dup(0)%1$c%1$csection .note.GNU-stack%1$c", 0
  filename: db 20 dup(0)
  compile_cmd: db 100 dup(0)
  exec_cmd: db 100 dup(0)

section .note.GNU-stack
