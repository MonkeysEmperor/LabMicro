    	.text
       	.globl    main
main:		MOV 	r1, #0X3	@ N=4;
			MOV 	r9, #1
			LDR 	r2, =arr
			MUL		r3, r1, r1
			ADD 	r3, r3, #1
			MOV 	r8, r3
			MUL 	r3, r8, r1
			MOV 	r3, r3, lsr#1 @Valor do quadrado mágico
			BL 		linhas
			BL		colunas
			BL 		diagonais
			SWI 	0x0

linhas:		CMP 	r9, #1
			BXNE	lr
			MOV		r4, #0 		@ i=0;
			MOV 	r6, #0 		@ offset;			
forLin:		CMP 	r4, r1
			BGE		outLin
			MOV 	r8, #0 		@valor da soma da linha
			MOV 	r5, #0  	@ j=0;
forSoma:	CMP		r5, r1
			BGE		compara			
			LDRB	r7, [r2, r6]
			ADD		r8, r8, r7
			ADD		r5, r5, #1
			ADD 	r6, r6, #1
			B 		forSoma
compara:	CMP 	r3, r8
			MOVNE 	r9, #0
			BXNE 	lr
			ADD		r4, r4, #1
			B 		forLin
outLin:		BX  	lr

colunas:    mov r4, #0
            cmp r9, #1
            bxne lr
forCols:    cmp r4, r1
            bxge lr
            mov r8, r4
            mov r7, #0
            mov r6, #0
forCol:     cmp r7, r1
            bge endForCol
            ldrb r5, [r2, r8]
            add r7, r7, #1 @atualiza contador
            add r6, r6, r5 @atualiza soma da coluna
            add r8, r8, r1 @atualiza deslocador de endereço
            b forCol
endForCol:  cmp r6, r3
            movne r9, #0
            bxne lr
            add 	r4, r4, #1
            b forCols
diagonais:	MOV r0, #0
			MOV r4, r2
			MOV r5, #0
			MOV r8, #0
loopDigL:	CMP r5, r1
			BGE outDigL
			LDR r8, [r4], r1
			ADD r0, r0, r8
			ADD r4, r4, #1
			ADD r5, r5, #1
			B   loopDigL
            MOVNE r9, #0
            BXNE lr  
outDigL:	MOV r5, #0
			ADD r4, r2, r1
			SUB r4, r4, #1
loopDigR:	CMP r5, r1
			BGE outDig
			LDR r8, [r4], r1
			ADD r4, r2, r1
			SUB r4, r4, #1
			ADD r5, r5, #1
			B   loopDigR
            MOVNE r9, #0
outDig:		BX  lr
arr:
	.byte 0x4, 0x9, 0x2, 0x3, 0x5, 0x7, 0x8, 0x1, 0x6


