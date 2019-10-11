	.text
	.globl main
main:
	LDR	r0, =0xFFFF0000 @ alteramos a instrução de MOV para LDR, já que era necessário carregar valores de 32 bits.			
	LDR	r1, =0x87654321 @ para cada conta do enunciado alteramos os valores nessas duas linhas.
	BL	firstfunc		
	MOV	r0, #0x18		
	LDR	r1, =0x20026		
	SWI	0x123456		
firstfunc:
	ADDS	r0, r0, r1	@ utilizamos ADDS para que as flags do cpsr sejam atualizadas	
	MOV	pc, lr		