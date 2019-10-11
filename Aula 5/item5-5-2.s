    		.text
        	.globl    main
main:		MOV        r6, #0xA
		MOV        r0, #0x1
factorial:	CMP	   r6, #0	
		BEQ        end		
		MUL        r0, r6, r0
		SUB	   r6, r6, #1
		B	   factorial
end:

