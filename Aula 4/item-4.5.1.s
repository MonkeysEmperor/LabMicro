	.text
        .globl    main
main:
    	LDR	r2, =arr
    	ADD	r4, r2, #5
    	LDR	r3, [r4] 
	ADD	r0, r1, r3
	B	out
arr:
    .word   0x0, 0x1, 0x2, 0x3, 0x0, 0x1, 0x2, 0x3, 0x0, 0x1, 0x2, 0x3, 0x0, 0x1, 0x2, 0x3, 0x0, 0x1, 0x2, 0x3, 0x0, 0x1, 0x2, 0x3
out:
