; program that will read a number N(1to3) as input and calculate the factorial of N!
; macro for input
iprint macro p1
    mov dx, p1
    mov ah, 9
    int 21h
endm  
; macro for output
oprint macro p1
    mov dl, p1
    add dl, 48
    mov ah, 2
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
    mov cx, 1
    mov ax, 1
    L1: 
        mul cx
        aam        ; ASCII Adjust After Multiplication: AX = AH:AL
        add cx, 1
        cmp cx, bx 
        jle L1
    mov ch, ah
    mov cl, al
    
    oprint ch
    oprint cl    
    
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
                 