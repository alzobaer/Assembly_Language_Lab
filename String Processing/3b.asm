; program to sort an array in ascending order

; define macro for printing a string
printString macro p1
    mov ah, 9                        ; set print function to display string
    mov dx, p1                       ; load the address of the string to be printed
    int 21h                          ; display the string
endm       

.model small                         ; specify the memory model
.stack 100h                          ; set the size of the stack

.data                                ; define the data segment
    str db 'Enter Values: $'         ; message for user to enter values
    str1 db 'Bubble Sorted: $'       ; message for outputting the sorted array
    array db 100 dup(?)            ; initialize an array with 100 elements

.code                                ; define the code segment
main proc                            ; start of main program
    mov ax, @data                    ; set the data segment register
    mov ds, ax                       ; to point to the data segment
    
    mov dx, offset str               ; display message for user to enter values
    printString dx     
     
    mov bx, offset array             ; start storing user input in array
    mov cx, -1                       ; initialize counter variable
    
inputs:                              ; loop for user input
    mov ah, 1                        ; set input function to get a character from keyboard
    int 21h                          ; wait for user to enter a character
    mov [bx],al                      ; store the character in the array
    sub [bx], 48                     ; convert ASCII to character
    inc bx                           ; move to the next element in the array
    inc cx                           ; increment the counter
    cmp al, 13                       ; check if the user has entered all values (enter key)
    jne inputs                       ; if not, go back to the beginning of the loop
    
    push cx                          ; save the counter for later use
    
nextscan:                            ; outer loop for sorting the array
    mov bx, cx                       ; set the counter to the size of the array
    mov si, 0                        ; initialize the inner loop counter
    
nextcomp:                            ; inner loop for comparing elements
    mov al, array[si]                ; load the current element
    mov dl, array[si+1]              ; load the next element
    cmp al, dl                       ; compare the elements
    jc noswap                        ; if the current element is less than the next, no swap needed
    
    mov array[si], dl                ; swap the elements
    mov array[si+1], al
    
noswap:                              ; if no swap, increment the inner loop counter
    inc si
    dec bx
    jnz nextcomp                     ; loop until all elements have been compared
    
    loop nextscan                    ; repeat the outer loop until no swaps have been made
    
    ; print new line
    call enterkey  
    
    lea dx, str1                     ; display message for the sorted array
    printString dx
    
    pop cx                           ; restore the counter                        ; because enter key is also a character
    lea si, array                    ; offset of the first element in the array
    
print_loop:                          ; loop for printing the sorted array
    mov dl, [si]                     ; get the current element
    add dl, 48                       ; convert to ASCII
    mov ah, 2                        ; set the print function
    int 21h                          ; print the character
    
    inc si                           ; move to the next element
    loop print_loop                  ; loop until all elements have been printed 
    
    exit:
    mov ah, 4ch
    int 21h 
main endp
enterkey proc                        ; define procedure for an enter key
    mov dl, 10
    mov ah, 2
    int 21h
    mov dl, 13
    mov ah, 2
    int 21h    
    
ret 
enterkey endp
end main
