; program to find first capital and last capital in alphabetical order

.model small
.stack 100h
.data
    first_Cap db 'Z' ; initialize first capital to the highest ASCII value
    last_Cap db 'A'  ; initialize last capital to the lowest ASCII value
    inp_msg db 'Enter an Array: $'
    op_msg1 db 'First Capital in alphabetical order is: $'
    op_msg2 db 'Last Capital in alphabetical order is: $'
    array db 100 dup(?)
    NoCap db 'There are no Capitals$'
    flag db 0 ; set flag to 0 to indicate no capitals have been found yet
.code
main proc
    mov ax, @data
    mov ds, ax

    ; print input message
    mov dx, offset inp_msg
    mov ah, 9
    int 21h

    ; take input from user
    mov si, offset array
    xor cx, cx

    input:
        mov ah, 1
        int 21h
        mov [si], al
        inc cx
        inc si
        cmp al, 13
        jne input

    ; print new line
    mov dl, 10
    mov ah, 2
    int 21h
    mov dl, 13
    int 21h

    ; search for first and last capital
    mov si, offset array
    Search_Cap:
        mov bl, [si]
        cmp bl, 'A'
        jl next_char
        cmp bl, 'Z'
        jg next_char

        ; Capital exists
        mov flag, 1 ; set flag to 1 to indicate at least one capital has been found
        cmp bl, first_Cap
        jge not_first
        mov first_Cap, bl

    not_first:
        cmp bl, last_Cap
        jle next_char
        mov last_Cap, bl

    next_char:
        inc si
        loop Search_Cap

    ; print Capitals
    cmp flag, 0 ; check if any capital has been found
    je No_Cap

    ; print first Capital
    mov dx, offset op_msg1
    mov ah, 9
    int 21h

    mov dl, first_Cap
    mov ah, 2
    int 21h

    ; print new line
    mov dl, 10
    mov ah, 2
    int 21h
    mov dl, 13
    int 21h

    ; print last Capital
    mov dx, offset op_msg2
    mov ah, 9
    int 21h

    mov dl, last_Cap
    mov ah, 2
    int 21h

    jmp exit

    No_Cap:
        mov dx, offset NoCap
        mov ah, 9
        int 21h

    exit:
    mov ah, 4ch
    int 21h
main endp
end main
