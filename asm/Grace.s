extern dprintf

section .text
  global main

main:
  lea rdi, [rel filename]
  mov rsi, 0101o  ; O_CREAT | O_WRONLY
  mov rax, 2      ; sys_open
  syscall

  cmp rax, 0
  jl error

  push rax  ; save file descriptor (for close)

  mov rdi, rax
  lea rsi, [rel format]
  mov rdx, 10
  mov rcx, 34
  lea r8, [rel format]
  call dprintf wrt ..plt

  pop rdi    ; restore file descriptor
  mov rax, 3 ; sys_close
  syscall

  xor rax, rax
  ret

error:
  mov rax, 1
  ret

section .data
  format: db "extern dprintf%1$c%1$csection .text%1$c  global main%1$c%1$cmain:%1$c  lea rdi, [rel filename]%1$c  mov rsi, 0101o  ; O_CREAT | O_WRONLY%1$c  mov rax, 2      ; sys_open%1$c  syscall%1$c%1$c  cmp rax, 0%1$c  jl error%1$c%1$c  push rax  ; save file descriptor (for close)%1$c%1$c  mov rdi, rax%1$c  lea rsi, [rel format]%1$c  mov rdx, 10%1$c  mov rcx, 34%1$c  lea r8, [rel format]%1$c  call dprintf wrt ..plt%1$c%1$c  pop rdi    ; restore file descriptor%1$c  mov rax, 3 ; sys_close%1$c  syscall%1$c%1$c  xor rax, rax%1$c  ret%1$c%1$cerror:%1$c  mov rax, 1%1$c  ret%1$c%1$csection .data%1$c  format: db %2$c%3$s%2$c, 0%1$c  filename: db %2$cGrace_kid.s%2$c, 0%1$c", 0
  filename: db "Grace_kid.s", 0
