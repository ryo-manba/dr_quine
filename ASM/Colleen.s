section .text
  extern printf
  global main

main:
  push rbp
  mov rbp, rsp
  call print
  xor rax, rax
  mov rsp, rbp
  pop rbp
  ret

; sub function
print:
  push rbp
  mov rbp, rsp
  lea rdi, [rel self]
  mov	rsi, 10 ; newline
  mov rdx, 34 ; double quote
  mov rcx, rdi
  mov	rax, 0
  call printf wrt ..plt
  leave
  ret

section .data
  self: db "section .text%1$c  extern printf%1$c  global main%1$c%1$cmain:%1$c  push rbp%1$c  mov rbp, rsp%1$c  call print%1$c  xor rax, rax%1$c  mov rsp, rbp%1$c  pop rbp%1$c  ret%1$c%1$c; sub function%1$cprint:%1$c  push rbp%1$c  mov rbp, rsp%1$c  lea rdi, [rel self]%1$c  mov	rsi, 10 ; newline%1$c  mov rdx, 34 ; double quote%1$c  mov rcx, rdi%1$c  mov	rax, 0%1$c  call printf wrt ..plt%1$c  leave%1$c  ret%1$c%1$csection .data%1$c  self: db %2$c%3$s%2$c, 0%1$c%1$csection .note.GNU-stack%1$c", 0

section .note.GNU-stack
