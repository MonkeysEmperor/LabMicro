	.text
	.globl    main
main:	MOV        r7, #1
	MOV        r6, #1
	MOV        r2, #0		
	LDR        r1, =0b10110110
    	LDR        r8, =0b10110110
	MOV        r9, #8
        MOV        r5, #0
        RSB        r4, r9, #32     
        MOV        r7, r7, LSL r9
        SUB        r7, r7, #1
loop:   AND        r0, r1, r7
	CMP        r0, r8
	ADDEQ      r2, r2, r6, LSL r5
	MOV        r1, r1, LSR #1
	ADD        r5, r5, #1    
	CMP        r5, r4
	BGE        out
	B        loop
out:

