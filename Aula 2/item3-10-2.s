	.text
	.globl main
main:
	LDR	r0, =0xFFFFFFFF			
	LDR	r1, =0x80000000 
	BL	firstfunc		
	MOV	r0, #0x18		
	LDR	r1, =0x20026		
	SWI	0x123456		
firstfunc:
	UMULLS	r4, r3, r0, r1	@ utilizamos primeiro a instrução de multiplicação UNSIGNED e depois a versão SIGNED da intrução	
	MOV	pc, lr		
