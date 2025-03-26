;
; A simple boot sector program that demonstrates the stack.
;

mov bx, 4

cmp bx, 4

jle less_equal_four

cmp bx, 40
jl less_fourty
mov al, 'C'
jmp else

less_equal_four:
  mov al, 'A'
  jmp else
less_fourty:
  mov al, 'B'
else:

mov ah, 0x0e ; int 10/ah = 0eh -> scrolling teletype BIOS routine
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55