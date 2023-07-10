;program to case conversion of letters

.model small
.stack 100h
.data 
    inpmsg db 'Enter a string: $'
    opmsg db 'Output: $'
    array db 100 dup(?)
.code
main proc
    mov ax, @data
    mov ds, ax
    
    ;print input message
    mov dx, offset inpmsg  ; move offset of input message to dx register
    mov ah, 9              ; set ah register to 9 to print string
    int 21h                ; print string
    
    ; take input from user 
    mov si, offset array   ; set si register to point to array
    xor cx, cx             ; clear cx register
    input:
        mov ah, 1          ; set ah register to 1 to read character input
        int 21h            ; read character input
        mov [si], al       ; move the input character to array
        inc cx             ; increment the character count
        inc si             ; move to the next array element
        cmp al, 13         ; check if the input character is the enter key
        jne input          ; if not, continue taking input
        
    ; print new line
    mov dl, 10             ; move ascii value of newline to dl register
    mov ah, 2              ; set ah register to 2 to print character
    int 21h                ; print newline character
    mov dl, 13             ; move ascii value of carriage return to dl register
    mov ah, 2              ; set ah register to 2 to print character
    int 21h                ; print carriage return character
    
    ; print output message   
    mov dx, offset opmsg   ; move offset of output message to dx register
    mov ah, 9              ; set ah register to 9 to print string
    int 21h                ; print string
    
    ; process to print output 
    sub cx, 1              ; subtract 1 from character count to account for enter key
    mov si, offset array   ; set si register to point to array
    outer:
        mov bl, [si]       ; move the current array element to bl register
        cmp bl, 'A'        ; compare bl register to ascii value of 'A'
        jge inner          ; jump to inner label if greater or equal
        jmp print          ; otherwise, jump to print label
        
    inner:
        cmp bl, 'Z'        ; compare bl register to ascii value of 'Z'
        jle tolower        ; jump to tolower label if less or equal
        cmp bl, 'a'        ; compare bl register to ascii value of 'a'
        jl print           ; jump to print label if less
        cmp bl, 'z'        ; compare bl register to ascii value of 'z'
        jle toupper        ; jump to toupper label if less or equal
        jmp print          ; otherwise, jump to print label
        
    tolower:
        add bl, 32         ; add 32 to convert uppercase letter to lowercase
        jmp print          ; jump to print label
        
    toupper:
        sub bl, 32         ; subtract 32 to convert lowercase letter to uppercase
        
    print:
        mov dl, bl          ; move the converted character to dl register
        mov ah, 2           ; set ah register to 2 to print character
        int 21h             ; print character
        inc si             
        loop outer        
    
    exit:
    mov ah, 4ch
    int 21h 
    
main endp
end main