	.text
	.globl	main
main:	CMP    r3, #40 
loop:   BGT    out 
	LDR    r5, [r2, r3]
	ADD    r5, r5, r4 
	STR    r5, [r1, r3]
	ADD    r3, r3, #4
    	B    loop
out:

