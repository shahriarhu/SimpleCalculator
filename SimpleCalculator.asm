.MODEL SMALL
.DATA
msg0 db "Enter second number : $"
msg1 db "Enter first number : $"
msg2 db "You have entered: $"
msg3 db "Please enter your choices: $"
msg4 db "1.ADDITION$" 
msg5 db "2.SUBTRACTION $"
msg6 db "3.MULTIPLICATION $"
msg9 db "   PRESS ESC TO HALT $"
msg10 db "SUMMATION OF TWO NUMBER : $"
msg11 db "SUBTRACTION OF TWO NUMBER : $"
msg12 db "QUOTIENT OF TWO NUMBER : $"
msg13 db "- $"
msg20 db "THANK YOU. SEE YOU AGAIN ! $"
number1 dw 0
number3 dw 3
tens db 10 
ten dw 10
digits db "0123456789"
.CODE
MAIN PROC  
    
    
    
    begin:
        call choices
        MOV AH,01H
        INT 21H
        CMP AL,27
        JE end_calculator
        CMP AL,49
        JE A
        CMP AL,50
        JE B
        CMP AL,51
        JE C
                 
    A:
        CALL addition
        JMP begin
    B:
        CALL subtraction
        JMP begin
    C:
        CALL multiplication
        JMP begin
    
    end_calculator:
        CALL linestart
        LEA DX,msg20 
        MOV AH,09H
        INT 21H
        MOV AH,4CH
        INT 21H 
    
MAIN ENDP

    choices PROC
        
        LEA DX,msg3 
        MOV AH,09H
        INT 21H
        CALL endl
        
        LEA DX,msg4 
        MOV AH,09H
        INT 21H
        CALL endl
        
        LEA DX,msg5
        MOV AH,09H
        INT 21H
        CALL endl
        
        LEA DX,msg6
        MOV AH,09H
        INT 21H
        CALL endl
        
        LEA DX,msg9
        MOV AH,09H
        INT 21H
        CALL endl
        ret 
        
    choices ENDP
    
    
    endl PROC
        MOV AH,02H
        MOV DL,0AH
        INT 21H 
        MOV DL,0DH
        INT 21H
        ret
    endl ENDP
    
    
    read1 PROC
      MOV AX,0
      MOV DX,0
      again:
        MOV AH,01H
        INT 21H
        CMP AL,13
        JE end
        SUB AL,48
        MOV BL,AL
        MOV AX,DX
        MUL tens
        ADD AL,BL
        MOV DX,AX
        JMP again
      end:
        MOV AX,DX 
        ret
    read1 ENDP
    
    
    addition PROC
        CALL linestart
        LEA DX,msg1 
        MOV AH,09H
        INT 21H
        CALL read1
        MOV number1,AX
        CALL endl
         
        
        LEA DX,msg0 
        MOV AH,09H
        INT 21H
        CALL read1
        ADD AX, number1
        MOV BX,AX
        CALL endl
        
        LEA DX,msg10 
        MOV AH,09H
        INT 21H
        CALL print
        CALL endl
        CALL endl 
        ret
        
    addition ENDP
    
    subtraction PROC
        CALL linestart
        LEA DX,msg1 
        MOV AH,09H
        INT 21H
        CALL read1
        MOV number1,AX
        CALL endl
         
        
        LEA DX,msg0 
        MOV AH,09H
        INT 21H
        CALL read1
        CMP number1,AX
        JGE P 
        
        SUB AX,number1 
        MOV BX,AX
        CALL endl
        
        LEA DX,msg11 
        MOV AH,09H
        INT 21H
        LEA DX,msg13 
        MOV AH,09H
        INT 21H
        CALL print 
        CALL endl
        CALL endl 
        ret
        
        
        LEA DX,msg11 
        MOV AH,09H
        INT 21H
        CALL print
        
        P:
        
        SUB number1,AX 
        MOV BX,number1
        CALL endl
        
        LEA DX,msg11 
        MOV AH,09H
        INT 21H
        CALL print 
        CALL endl
        CALL endl 
        ret
        
    subtraction ENDP
    
    
    multiplication PROC
        CALL linestart
        LEA DX,msg1 
        MOV AH,09H
        INT 21H
        CALL read1
        MOV number3,AX
        CALL endl
         
        
        LEA DX,msg0 
        MOV AH,09H
        INT 21H
        CALL read1
        
        MUL number3 
        MOV BX,AX
        CALL endl
        
        LEA DX,msg11 
        MOV AH,09H
        INT 21H
        CALL print 
        CALL endl
        CALL endl
        ret
    multiplication ENDP
    
    print PROC
        MOV AX,BX
        MOV DI,0
        L:
            DIV tens
            MOV [digits+DI],AH
            INC DI
            MOV AH,0
            CMP AX,0
            JG L
            
         M: 
            DEC DI
            MOV DL,[digits+DI]
            ADD DL,'0'
            MOV AH,02H
            INT 21H 
            CMP DI,0
            JG M
            
        ret
    print ENDP
    
    
    linestart PROC
        MOV AH,02H
        MOV DL,0DH
        INT 21H
        ret
    linestart ENDP
 
 END MAIN   