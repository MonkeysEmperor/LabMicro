    .text
    .globl    main
main:		LDR        r0, size    @ int size = 4;
		LDR        r1, =arr        @ int [] arr = [4, 15, 13, 1];
		SUB        r9, r0, #4    @ aux
		LDR        r2, =0x0    @ i = 0
loop:		CMP        r2, r0        @ for(i = 0; i < size; i++)
		BGE        fora
        	MOV        r3, r2        @ j = i
loop2:          CMP        r3, r9        @ for(j = i; j < size-1; j++)
		BGE        out
    		ADD        r7, r1, r3
		LDMIA      r7!, {r4, r5}
		CMP        r4, r5
		MOVLE	   r6, r4
		MOVLE	   r4, r5
		MOVLE	   r5, r6
		STMDB      r7, {r4, r5}
		ADD	   r3, r3, #4
		B          loop2    
out:		ADD        r2, r2, #4
        	B          loop



arr:    
	.word    0x04, 0x0f, 0x0d, 0x01    

size:    
	.word    16

fora:
