; program that will read a number N(1to3) as input and calculate the factorial of N!
; macro for input
iprint macro p1
    mov dx, p1
    mov ah, 9
    int 21h
endm  

.model small
.stack 100h
.data
    msg1 db 'Enter a number 0 to 4 : $'
    msg2 db 'Fatorial of the given number is : $'
.code
main proc 
    mov ax, @data
    mov ds, ax
    
    mov dx, offset msg1
    iprint dx    
    
    ; take input
    mov ah, 1
    int 21h 
    
    sub al, 48
    mov bl, al 
    
    call enterkey 
    
    mov dx, offset msg2
    iprint dx  
    
    ;factorial calculate
    mov cl, 1
    mov al, 1
    L1: 
        mul cl
        aam        ; ASCII Adjust After Multiplication: AX = AH:AL
        add cl, 1
        cmp cl, bl 
        jle L1
                  
    mov ch, ah
    mov cl, al  
    
    add ch, 48
    add cl, 48
                      
    ;print ah and al    
    mov dl, ch
    mov ah, 2 
    int 21h
    
    mov dl, cl
    mov ah, 2
    int 21h   
    
    exit:
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
                 