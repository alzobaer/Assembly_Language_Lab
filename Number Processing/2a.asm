; macro for print character
print macro p1
    mov dl, p1 
    add dl, 48
    mov ah, 2
    int 21h
endm 
; macro for printing string
printStr macro p2
    mov dl, p2
    mov ah, 9
    int 21h    
endm

.model small
.stack 100h
.data 
prompt db 'Ener a number from 0 to 9: $'
msg1 db 'The given number is even.$'
msg2 db 'The given number is odd.$'
Quo dw ?
Rem dw ?
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov dl, offset prompt
    printStr dl
    
    ;take input
    mov ah, 1
    int 21h 
    mov dx, 0
    
    mov bx, 2
    div bx 
    
    mov Quo, ax
    mov Rem, dx 
    
    cmp Rem, 0
    je even
    
    call enterkey  
    
    mov dl, offset msg2
    printStr dl
    jmp exit
    
    even: 
        call enterkey
        mov dl, offset msg1 
        printStr dl
    
    
    exit: 
    mov ah, 4ch
    int 21h
main endp

enterkey proc  ; procedure for new line
    mov dl, 10
    mov ah, 2
    int 21h
    mov dl, 13
    mov ah, 2
    int 21h  
ret
enterkey endp 

end main
