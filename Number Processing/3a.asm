; program to find out the largest number from an array

printString macro p1
    mov ah, 9
    int 21h
endm

.model small
.stack 100h
.data
array DB 100 dup('$')   ; create an array of 100 bytes, initialized to 0     
inpmsg db 'Enter the array element: $'
opmsg db 'The largest number is: $'
res db ?                ; result byte to store the largest number
.code
main proc
    mov ax, @data       ; initialize data segment
    mov ds, ax

    mov dx, offset inpmsg
    printString dx      ; use DX instead of DL to store the offset address

    mov cx, 0           ; set the loop counter to 5, the size of the array
    mov bl, 0           ; initialize the largest number to zero

    lea si, array       ; load the address of the array into SI
user_input:
    mov ah, 1
    int 21h
    mov [si], al
    inc cx 
    inc si   
    cmp al, 13
    jne user_input

    call enterkey       ; calling enterkey procedure to print new line
    
    mov dx, offset opmsg
    printString dx 

    lea si, array
up:
    mov al, [si]        ; move the byte pointed to by SI into AL
    cmp al, bl          ; compare the value in AL with the current largest number
    jle nxt             ; if it's less or equal, jump to the next iteration

    mov bl, al          ; otherwise, store the new largest number in BL

nxt:
    inc si              ; increment the pointer to the array
    dec cx              ; decrement the loop counter
    jnz up              ; if the loop counter is not zero, jump to the next iteration

    mov res, bl         ; store the largest number in the result variable
    mov dl, res         ; move the result byte into DL for printing
    mov ah, 2           ; print the result
    int 21h

exit:
    mov ah, 4ch         ; exit the program
    int 21h

main endp

enterkey proc
    mov dx, 13          ; move ASCII value of CR into DX
    mov ah, 2
    int 21h
    mov dx, 10          ; move ASCII value of LF into DX
    mov ah, 2
    int 21h
    ret
enterkey endp

end main
