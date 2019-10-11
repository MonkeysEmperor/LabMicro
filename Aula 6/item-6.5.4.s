    .text
    .globl    main
main:	LDR r0, =0x4
        LDR r1, =0x16
        LDR r2, =stack
        LDR r3, size
	MOV r4, r3
        ADD r3, r3, r2 
        STR r1, [r3], r0
	ADD r4, r4, r0 
	STR r4, size

size:
    .word 0x12
stack:
    .word 0x04, 0xff, 0x00, 0x13, 0x0, 0x0    


