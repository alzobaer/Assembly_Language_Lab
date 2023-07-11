; program that will read a number N(1to3) as input and calculate the summation
; macro to print single character
printChar macro p  
    mov dl, p
    add dl, 48
    mov ah, 2
    int 21h
endm  
; macro to print string
printString macro p 
    mov dx, p
    mov ah, 9
    int 21h
endm

.model small                 ; set the memory model to "small"
.stack 100h                  ; allocate 100h (256 bytes) of stack space
.data                        ; allocate 100h (256 bytes) of stack space
    inprompt db 'Enter a number from 1 to 9: $'
    outprmpt db 'Summation is : $' 
    Rem db ?
    Quo db ?
.code 
    main proc
        mov ax, @data
        mov ds, ax 
        
        mov dx, offset inprompt
        printString dx
         
        mov ah, 1
        int 21h 
        sub al, 48
        mov bl, al
        
        call enterkey   
        
        mov dx, offset outprmpt
        printString dx
        
        ; calculate summation 
        
        mov cx, 0
        mov ax, 0
        sum: 
            add ax, cx 
            add cl, 1
            cmp cl, bl 
            jle sum 
        
         
        mov bl, 10
        div bl         ; AX/BX = AX:DX or AX/BL=AH:AL
        
        mov Quo, al
        mov Rem, ah
        
        printChar Quo  
        printChar Rem         
        
        
        
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