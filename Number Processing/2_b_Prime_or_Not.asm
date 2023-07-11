; program to determine whether a given number is prime or not  

.model small
.stack 100h
.data 
    prompt db 'Enter a number from 0 to 9: $'
    is_prime db 'The given number is prime.$'
    is_not_prime db 'The given number is not prime.$' 
    N db ?
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
    
    sub al, '0'
    mov N, al  
    mov bl, al      
       
    ; check for 0 and 1
    cmp al, 0
    je notprime
    cmp al, 1
    je notprime 
    cmp al, 2
    je prime
    
    
    ;check if N is divided by 2 or 3
    
    check: 
        dec bl
        mov ah, 0
        mov al, N
        div bl
        cmp ah, 0
        je notprime
        cmp bl, 2
        je prime
        jmp check  
        
    ; number is prime
    prime:    
        call enterkey
        mov dl, offset is_prime 
        mov ah, 9
        int 21h
        jmp exit_prog 
        
    ; number is not prime
    notprime:    
        call enterkey
        ; number is not prime
        mov dl, offset is_not_prime  
        mov ah, 9
        int 21h   

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
