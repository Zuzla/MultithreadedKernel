ORG 0x7c00
BITS 16

start:
    mov si, message
    call print
    jmp $

print:
    mov bx, 0
.loop:
    lodsb
    cmp al, 0           ; check if not end
    je .done            ; go end block
    call print_char     ; print 1 character from `message`
    jmp .loop
.done:
    ret

print_char:
    mov ah, 0eh
    int 0x10
    ret

message: db 'Hello World!', 0

times 510-($ - $$) db 0 ;   $ means current address and $$ means the first address of the current section. 
                        ;   You have to understand that the times directive only operates on numbers and the difference of address ( $-$$ ) yields a number (Offset). 
                        ;   So $-$$ gives you the offset from start to address of the currently executed instruction. If subtract that value from 510 you will get the offset 
                        ;   from the address of the currently executed instruction to the 510th byte. So we now know how many bytes are there from the address of the currently 
                        ;   executed instruction to the 510th byte. The times directive will now pad that number of bytes up to 510th byte with zeros.
                        ;   For Ex:
                        ;   Assume your codes current address $ is at 0x000f and the first address of section $$ is 0x0000. Then $-$$ yield to 15, which implies your current 
                        ;   instruction is at the 15th byte. Now 510 - 15 will give you 495 i.e 495 bytes from current instruction will be padded with zeros by times directive.
                        ;   if you dissect the binary for times 510 -( 0x000f - 0x0000 ) db 0 alone, it will exactly have 495 zeros!!
dw 0xAA55