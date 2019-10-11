	.text
	.globl main
main:
	CMP	0, r0			
	RSBMI	R0, R0, #0	
	SWI	0x123456		
