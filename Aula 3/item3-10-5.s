	.text
	.globl main
main:	MOV 		R0, #0xFFFFFFFE	
	MOV		R1, #0x5	
	AND		R2, R0, #0x80000000	
	CMP 		R0,#0		
	RSBMI		R0, R0, #0	
	AND		R3, R1, #0x80000000	
	CMP 		R1,#0
	RSBMI		R1, R1, #0
	UMULL		R5,R4,R0,R1	
	EOR		R2,R2,R3	
	CMN		R2, #0
	MVNMI		R4, R4		
	MVNMI		R5, R5		
	ADDMI		R5, R5, #1
	SWI		0x123456


