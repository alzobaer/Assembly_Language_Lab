; program to determine whether a given number is prime or not
printmsg macro p1
    mov dl, p1
    mov ah, 9
    int 21h    
endm   

.model small
.stack 100h
.data 
prompt db 'Enter a number from 0 to 9: $'
is_prime db 'The given number is prime.$'
is_not_prime db 'The given number is not prime.$'
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov dl, offset prompt
    mov ah, 9
    int 21h
    
    ;take input
    mov ah, 1
    int 21h 
    sub al, 48  
       
    ; check for 0 and 1
    cmp al, 0
    je notprime
    cmp al, 1
    je notprime
    
    mov cx, 2
test_next_divisor:
    mov dx, 0
    div cx
    cmp dx, 0
    je notprime
    
    inc cx
    cmp cx, ax
    jle test_next_divisor
    
    ; number is prime  
    call enterkey
    mov dl, offset is_prime 
    printmsg dl
    jmp exit_prog
    
notprime:    
    call enterkey
    ; number is not prime
    mov dl, offset is_not_prime 
    printmsg dl

exit_prog:
    mov ah, 4ch
    int 21h
    
main endp  
enterkey proc
    mov dl, 10
    mov ah, 2
    int 21h
    mov dl, 13
    mov ah, 2
    int 21h    
ret
enterkey endp
end main
