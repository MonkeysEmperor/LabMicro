	.text
	.globl main
main:
	MOV	r0, #20			
	MOV	r1, r0, lsl #5 @ ao deslocar o valor de r0 em 5 bits, efetivamente multiplica-se o valor por 32 
	SWI	0x123456