
print_string:
  mov ah, 0x0e ; int 10/ah = 0eh -> scrolling teletype BIOS routine
  cmp al, 0
  jne print_char
  mov al, 1
  ret
print_char:
  mov al, [bx]
  int 0x10
  add bx, 1
  jmp print_string
