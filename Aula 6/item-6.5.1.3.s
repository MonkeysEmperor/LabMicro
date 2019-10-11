    .text
    .globl    main
main:		LDR	r1, =0x123
        	LDR	r2, =0x124
        	LDR	r4, =0x01
        	BL	func1
		B	out

a:    .word 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

func1:		LDR	r0, =a
		STMIA   r0!, {r1, r2, r4, lr}
		BL	func2
		LDMDB	r0!, {r1, lr}
out1:		BX	lr
       
func2:		LDMDB	r0!, {r1-r3, r5}
		MLA	r4, r1, r2, r3
		STMIA	r0!, {r4, r5}
        	BX	lr

out:
