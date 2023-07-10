.model small
.stack 100h
.data
    inpmsg db 'Enter a string: $'    ; Input message
    opmsg db 'Reversed string: $'    ; Output message
    array db 100 dup(?)              ; Input string buffer
    rev_array db 100 dup(?)          ; Reversed string buffer

.code
main proc
    mov ax, @data                   ; Initialize data segment
    mov ds, ax
    
    ; Print input message
    mov dx, offset inpmsg
    mov ah, 9
    int 21h
    
    ; Take input from user
    mov si, offset array             ; SI points to the input buffer
    xor cx, cx                       ; Initialize counter CX to 0
    input: 
        mov ah, 1                    ; DOS read character function
        int 21h                      ; Read a character from input
        inc cx                       ; Increment counter CX
        inc si                       ; Move to the next position in the buffer
        mov [si], al                 ; Store the character in the buffer
        cmp al, 13                   ; Check if Enter key was pressed
        jne input                    ; If not, continue input
    
    push cx                          ; Push the counter value onto the stack
    pop bx                           ; Pop the counter value into BX register
        
    ; Print newline
    mov dl, 10                       ; ASCII code for newline character
    mov ah, 2
    int 21h
    mov dl, 13                       ; ASCII code for carriage return character
    mov ah, 2
    int 21h
    
    ; Print output message 
    mov dx, offset opmsg
    mov ah, 9
    int 21h 
    
    ; Push the value of array into the stack 
    mov si, offset array 
    pushing:
        mov ax, [si]                 ; Load the value at [si] into AX register
        push ax                      ; Push the value in AX onto the stack
        inc si                       ; Move to the next position in the buffer
        loop pushing                 ; Repeat until all characters are pushed
        
    ; Reverse the string
    mov si, offset rev_array         ; SI points to the reversed string buffer
    mov cx, bx                       ; Set CX to the counter value
    reverse:
        pop ax                        ; Pop the value from the stack into AX
        mov [si], ax                  ; Store the character in the reversed string buffer
        inc si                        ; Move to the next position in the buffer
        loop reverse                  ; Repeat until all characters are reversed
    
    ; Print the reversed string
    mov si, offset rev_array         ; SI points to the reversed string buffer
    mov cx, bx                       ; Set CX to the counter value
    print:
        mov dl, [si]                  ; Load the character to be printed
        mov ah, 2                     ; DOS display character function
        int 21h                       ; Print the character
        inc si                        ; Move to the next position in the buffer
        loop print                     ; Repeat until all characters are printed
    
    ; Exit
    mov ah, 4Ch                      ; DOS exit program function
    int 21h
    
main endp
end main
