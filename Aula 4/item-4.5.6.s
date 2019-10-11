    .text
        .globl    main
main:
	MOV	r1, #9
	SUB	r1, r1, #2
	MOV	r0, #1
	MOV	r2, #0
loop:   CMP	r1, #0
	BLE	out
	ADD	r2, r0, r2
	ADD	r0, r0, r2
	SUB	r1, r1, #2
	B	loop
out:	CMP	r1, #-1
	MOVEQ	r0, r2	

