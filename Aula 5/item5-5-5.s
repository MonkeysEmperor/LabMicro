	.text
	.globl    main
main:   LDR r0, =0x586
        LDR r1, =0x0
loop:   CMP r0, #0
        BEQ out
        AND r2, r0, #1
        ADD r1, r1, r2
        MOV r0, r0, LSR #1
        B loop
out:    AND r1, r1, #1
        SWI 0x123456
