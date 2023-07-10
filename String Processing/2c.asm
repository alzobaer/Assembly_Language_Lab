; whether substring is present in a string or not

.model small
.stack 100h
.data
    msg1 db 'Enter a main string: $'
    msg2 db 'Enter a substring: $'
    
    mainstr db 100 dup(?)
    substr db 100 dup(?)      
    
    Yes db 'Found$'
    No db 'Not Found$'
.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    ;prompt for main string
    mov dx, offset msg1
    mov ah, 9
    int 21h 
    
    mov si, offset mainstr 
    mov cx, 0
    ;input main string
    inputmain:
        mov ah, 1
        int 21h 
        mov [si], al 
        inc si
        inc cx
        cmp al, 13
        jne inputmain
    
    call enterkey
    
    ;prompt for sub string
    mov dx, offset msg2
    mov ah, 9
    int 21h  
    
    mov si, offset substr 
    ;input main string
    inputsub:
        mov ah, 1
        int 21h 
        inc si
        cmp al, 13
        jne inputsub
        
    call enterkey  
    
    check: 
        mov si, offset msg1
        mov di, offset msg2
        cld
        repe cmpsb
        jl not_found
        jg not_found
    
    found:
        mov dx, offset Yes
        mov ah, 9
        int 21h
        jmp exit
    
    not_found:
        mov dx, offset No
        mov ah, 9
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