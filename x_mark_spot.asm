;
; A simple boot sector program that demonstrates addressing
;

mov ah, 0x0e ; int 10/ah = 0eh -> Scrolling teletype BIOS routine

; First attempt
mov al, the_secret
int 0x10 ; Does this print an X? No, it tries to load the immediate offset into al as the character to print, but actually we wanted to print the character at the offset rather than the offset itself


; Second Attempt
mov al, [the_secret]
int 0x10 ; Does this print an X? No, the CPU treats the offset as though it was from the start of memory, rather than the start address of our loaded code, which would land it around about in the interrupt vector


; Third attempt
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10 ; Does this print an X? Yes, we add the offset the secret to the address that we beleive BIOS to have loaded our code, 0x7c00, using the CPU add instruction. We can think of add as the higher level language statement bx = bx + 0x7c00. We have now calculated the correct memory address of our ’X’ and can store the contents of that address in al, ready for the BIOS print function, with the instruction mov al, [bx]. 


; Fourth attempt
mov al, [0x7c1e]
int 0x10 ; Does this print an X? Yes, we try to be a bit clever, by pre-calculating the address of the ’X’ after the boot sector is loaded into memory by BIOS. We arrive at the address 0x7c1e based on our earlier examination of the binary code

jmp $ ; Jump forever

the_secret:
  db "X"

; Padding and magic BIOS number

times 510-($-$$) db 0
dw 0xaa55