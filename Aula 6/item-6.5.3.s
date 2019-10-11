    .text
    .globl    main

@ r2 => arr
@ r1 => N
@ r3 => K
@ r9 => resultado

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
outDigL:	MOV r5, #0
		ADD r4 r2, r1
		SUB r4, r4, #1
loopDigR:	CMP r5, r1
		BGE outDig
		LDR r8, [r4], r1
		ADD r4 r2, r1
		SUB r4, r4, #1
		ADD r5, r5, #1
		B   loopDigR
outDig:		BX  lr

