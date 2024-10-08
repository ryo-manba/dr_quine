section .text
  default rel
  extern printf
  global main

main:
  push rbp
  call print
  pop rbp
  mov rax, 0
  ret

; sub function
print:
  mov	rdi, self
  mov	rsi, 10 ; newline
  mov rdx, 34 ; double quote
  mov rcx, self
  mov	rax, 0
  call printf wrt ..plt
  ret

section .data
  self: db "section .text%1$c  default rel%1$c  extern printf%1$c  global main%1$c%1$cmain:%1$c  push rbp%1$c  call print%1$c  pop rbp%1$c  mov rax, 0%1$c  ret%1$c%1$c; sub function%1$cprint:%1$c  mov	rdi, self%1$c  mov	rsi, 10 ; newline%1$c  mov rdx, 34 ; double quote%1$c  mov rcx, self%1$c  mov	rax, 0%1$c  call printf wrt ..plt%1$c  ret%1$c%1$csection .data%1$c  self: db %2$c%3$s%2$c%1$c"
