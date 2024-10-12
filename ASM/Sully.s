extern dprintf
extern snprintf
extern system

section .text
  global main

main:
  mov rcx, 5

%ifdef CHILD
  dec rcx
%endif

  cmp rcx, 0
  jl done

  push rcx ; save counter
  push rcx ; save counter
  push rcx ; save counter

  ; create file name
  lea rdi, [rel filename]
  mov rsi, 20
  lea rdx, [rel filename_format]
  call snprintf wrt ..plt

  ; open file
  lea rdi, [rel filename]
  mov rsi, 1101o ; O_CREAT | O_WRONLY | O_TRUNC
  mov rax, 2     ; sys_open
  syscall

  cmp rax, 0
  jl error
  pop r9 ; restore counter for file format
  push rax ; store file descriptor

  ; write file
  mov rdi, rax
  lea rsi, [rel format]
  mov rdx, 10
  mov rcx, 34
  lea r8, [rel format]
  call dprintf wrt ..plt

  ; close file
  pop rdi    ; restore file descriptor
  mov rax, 3 ; sys_close
  syscall

  ; run compile
  lea rdi, [rel compile_cmd]
  mov rsi, 100
  lea rdx, [rel compile_cmd_format]
  pop rcx ; restore counter
  call snprintf wrt ..plt

  lea rdi, [rel compile_cmd]
  call system wrt ..plt

  ; execute file
  lea rdi, [rel exec_cmd]
  mov rsi, 100
  lea rdx, [rel exec_cmd_format]
  pop rcx ; restore counter
  call snprintf wrt ..plt

  lea rdi, [rel exec_cmd]
  call system wrt ..plt

  jmp done

error:
  mov rax, 1
  ret

done:
  xor rax, rax
  ret

section .data
  filename_format: db "Sully_%d.s", 0
  compile_cmd_format: db "nasm -f elf64 -d CHILD Sully_%1$d.s -o Sully_%1$d.o && gcc -Wall -Wextra -Werror Sully_%1$d.o -o Sully_%1$d", 0
  exec_cmd_format: db "./Sully_%d", 0
  format: db "extern dprintf%1$cextern snprintf%1$cextern system%1$c%1$csection .text%1$c  global main%1$c%1$cmain:%1$c  mov rcx, %4$d%1$c%1$c%%ifdef CHILD%1$c  dec rcx%1$c%%endif%1$c%1$c  cmp rcx, 0%1$c  jl done%1$c%1$c  push rcx ; save counter%1$c  push rcx ; save counter%1$c  push rcx ; save counter%1$c%1$c  ; create file name%1$c  lea rdi, [rel filename]%1$c  mov rsi, 20%1$c  lea rdx, [rel filename_format]%1$c  call snprintf wrt ..plt%1$c%1$c  ; open file%1$c  lea rdi, [rel filename]%1$c  mov rsi, 1101o ; O_CREAT | O_WRONLY | O_TRUNC%1$c  mov rax, 2     ; sys_open%1$c  syscall%1$c%1$c  cmp rax, 0%1$c  jl error%1$c  pop r9 ; restore counter for file format%1$c  push rax ; store file descriptor%1$c%1$c  ; write file%1$c  mov rdi, rax%1$c  lea rsi, [rel format]%1$c  mov rdx, 10%1$c  mov rcx, 34%1$c  lea r8, [rel format]%1$c  call dprintf wrt ..plt%1$c%1$c  ; close file%1$c  pop rdi    ; restore file descriptor%1$c  mov rax, 3 ; sys_close%1$c  syscall%1$c%1$c  ; run compile%1$c  lea rdi, [rel compile_cmd]%1$c  mov rsi, 100%1$c  lea rdx, [rel compile_cmd_format]%1$c  pop rcx ; restore counter%1$c  call snprintf wrt ..plt%1$c%1$c  lea rdi, [rel compile_cmd]%1$c  call system wrt ..plt%1$c%1$c  ; execute file%1$c  lea rdi, [rel exec_cmd]%1$c  mov rsi, 100%1$c  lea rdx, [rel exec_cmd_format]%1$c  pop rcx ; restore counter%1$c  call snprintf wrt ..plt%1$c%1$c  lea rdi, [rel exec_cmd]%1$c  call system wrt ..plt%1$c%1$c  jmp done%1$c%1$cerror:%1$c  mov rax, 1%1$c  ret%1$c%1$cdone:%1$c  xor rax, rax%1$c  ret%1$c%1$csection .data%1$c  filename_format: db %2$cSully_%%d.s%2$c, 0%1$c  compile_cmd_format: db %2$cnasm -f elf64 -d CHILD Sully_%%1$d.s -o Sully_%%1$d.o && gcc -Wall -Wextra -Werror Sully_%%1$d.o -o Sully_%%1$d%2$c, 0%1$c  exec_cmd_format: db %2$c./Sully_%%d%2$c, 0%1$c  format: db %2$c%3$s%2$c, 0%1$c  filename: db 20 dup(0)%1$c  compile_cmd: db 100 dup(0)%1$c  exec_cmd: db 100 dup(0)%1$c%1$csection .note.GNU-stack%1$c", 0
  filename: db 20 dup(0)
  compile_cmd: db 100 dup(0)
  exec_cmd: db 100 dup(0)

section .note.GNU-stack
