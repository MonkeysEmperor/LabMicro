	.text
	.globl    main
main:   MOV        r9, #1
	MOV	   r2, #0
        MOV        r5, #0
	LDR        r1, =0b0010110110
loop:   CMP        r5, #28            	@ Compara se já verificou os 32 bits
	BGT        out            	@ Saída do loop
	AND        r0, r1, #0xF        	@ Pega os bits de teste 
	CMP        r0, #0b1011        	@ Verifica condição da FSM 
	ADDEQ      r2, r2, r9, LSL r5   @ r2 = r2 + (1 >> r5)
	MOV        r1, r1, LSR #1       @ Movimenta registrador de entrada
	ADD        r5, r5, #1        	@ Incrementa índice 
	B          loop            	@ Fecha loop
out:

