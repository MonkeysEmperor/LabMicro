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
	SMULLS	r4, r3, r0, r1		
	MOV	pc, lr		
