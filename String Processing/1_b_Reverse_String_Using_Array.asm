.model small
.stack 100h
.data
    inp_msg db 'Enter a String: $'
    op_msg db 'Reversed String: $'
    array db 100 dup(?)   
    rev_array db 100 dup(?)
.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; print input msg
    mov dx, offset inp_msg
    mov ah, 9
    int 21h
 
    ; take input from user
    xor cx, cx
    mov si, offset array  
    
input_loop:
    mov ah, 1
    int 21h
    cmp al, 13
    je end_input_loop
    mov [si], al
    inc si
    inc cx
    jmp input_loop  
    
end_input_loop: 

    push cx
    
    ; print new line
    mov dl, 10
    mov ah, 2
    int 21h
    mov ah, 13
    int 21h
        
    ; make reverse string 
    mov si, offset array
    add si, cx              
    sub si, 1
    mov di, offset rev_array    
    
reverse_loop: 
    mov al, [si] 
    mov [di], al
    dec si
    inc di
    loop reverse_loop
    
    ;print array
    mov dx, offset op_msg
    mov ah, 9
    int 21h  
    
    pop cx ; retrieve cx from the stack
    mov si, offset rev_array     
    
print_loop:
    mov dl, [si]
    mov ah, 2
    int 21h 
    inc si
    loop print_loop
        
    ; exit
    mov ah, 4ch
    int 21h
main endp
end main
