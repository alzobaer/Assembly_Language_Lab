; counting number of vowels, consonats, digits and spaces as output
; declaring macro for print string message
output macro p1
    mov ah, 9
    int 21h    
endm

.model small
.stack 100h 
.data
    msg1 db 'Enter a string: $' 
    string db 100 dup(?)
    msg2 db 'Number of Vowles: $'
    msg3 db 'Number of consonants: $'
    msg4 db 'Number of digits: $'
    msg5 db 'Number of spaces: $' 
    
    vowstr db 'aeiou$'
    constr db 'bcdfghjklmnpqrstvwxyz$'
    digstr db '0123456789$'
    spastr db ' $'
    
    vowel db ?
    consonant db ?
    digit db ?
    space db ?
    
.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax 
    
    
    mov vowel, 48
     
    mov consonant, 48
    
    mov digit, 48
   
    mov space, 48
    
    ; prompt for msg1
    mov dl, offset msg1
    output dl
    
    ; taking input from user
    mov si, offset string
    xor cx, cx
    input:
        mov ah, 1
        int 21h 
        mov [si], al
        inc cx 
        inc si
        cmp al, 13
        jne input 
        
    call enterkey
    mov si, offset string 
    cld    
    
    check:      
        lodsb    ;mov al, [si] 
        cmp al, 13
        je print     
         
        mov di, offset vowstr
        mov cx, 5
        repne scasb
        je vowcount 
        
        mov di, offset constr
        mov cx, 21
        repne scasb
        je concount 
        
        mov di, offset digstr
        mov cx, 10
        repne scasb
        je digcount 
        
        mov di, offset spastr 
        mov cx, 1
        repne scasb
        je spacount
    
        jmp print
    
    jmp print      
        
    vowcount:
        inc vowel 
        jmp check
        
    concount:
        inc consonant 
        jmp check
    digcount:
        inc digit
        jmp check
        
    spacount:
        inc space
        jmp check  
    
    print:    
        
        print_vow: 
            mov dl, offset msg2
            output dl
            mov dl, vowel
            mov ah, 2
            int 21h 
             
        call enterkey 
               
        print_const: 
            mov dl, offset msg3
            output dl
            mov dl, consonant
            mov ah, 2
            int 21h   
            
        call enterkey  
          
        print_dig: 
            mov dl, offset msg4
            output dl
            mov dl, digit
            mov ah, 2
            int 21h   
            
        call enterkey    
        
        print_space: 
            mov dl, offset msg5
            output dl
            mov dl, space
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
        int 21h       
                
    ret 
    enterkey endp
end main