.MODEL SMALL
.STACK 100H
.DATA
    inpmsg DB 'Enter a string: $'
    opmsg DB 'Sorted string: $'
    string DB 100 dup(?)
    N DW ?
.CODE
    MAIN PROC 
        MOV AX, @DATA
        MOV DS, AX          
        
        ;PRINT INPUT MESSAGE
        MOV DL, OFFSET inpmsg
        MOV AH, 09H
        INT 21H  
        
        ;TAKE USER INPUT 
        
        MOV SI, 0
        INPUT:
            MOV AH, 1
            INT 21H
            CMP AL, 13
            JZ END
            MOV string[SI], AL
            INC SI
            JMP INPUT
            
        END:  
        
        MOV N, SI
        SUB N, 1         
        MOV CX, N
        
        ;PRINT NEWLINE
        CALL ENTERKEY
        
        ;PRINT OUTPUT MESSAGE
        MOV DL, OFFSET opmsg
        MOV AH, 09H
        INT 21H
        
        ; PROCESS STRING FOR SORTING
        
        OUTER:   
            MOV SI, 0
            MOV BX, CX
            
            INNER:
                MOV AL, string[SI]
                MOV DL, string[SI+1]
                CMP AL, DL
                JC NOSWAP           ;USE JC/JL => ASCENDING, JNC/JG => dESCENDING
                MOV string[SI], DL
                MOV string[SI+1], AL
        
            NOSWAP:  
                INC SI
                DEC BX
                JNZ INNER       
        
        LOOP OUTER              
        
        ;PRINT SORTED STRING  
        ADD N, 1
        MOV CX, N 
        MOV SI, 0
        OUTPUT:
            MOV DL, string[SI]
            MOV AH, 2
            INT 21H
            INC SI
        
        LOOP OUTPUT
        
        EXIT:
        MOV AH, 4CH
        INT 21H
        
    MAIN ENDP  
    
    ENTERKEY PROC 
        MOV DL, 10
        MOV AH, 2
        INT 21H
        MOV DL, 13
        INT 21H        
        RET
    
    END MAIN