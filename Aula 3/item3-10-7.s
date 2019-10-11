	.text
	.globl main
main:		ldr    r1, =1023
		ldr    r2, =10
		mov    r3, #0
		mov    r5, r1
		mov    r0, #1
		and    r8, r1, #0x80000000
		cmp    r1,#0
		rsbmi  r1,r1,#0
		and    r9, r2, #0x80000000
		cmp    r2,#0
		rsbmi  r2,r2,#0
loop1:		cmp    r5, r2                
	   	bmi    fim
		mov    r4, r2
		mov    r7, #0
loop2:		mov    r6, r4, lsl#1
		cmp    r5, r6
		bmi    out
	   	mov    r4, r4, lsl #1
		add    r7, r7, #1
		b      loop2
out:		add    r3, r3, r0, lsl r7
		sub    r5, r5, r4
		b      loop1
fim:		eors    r8,r8,r9
		mvnmi  r3,r3
		addmi  r3,r3,#1
		swi    0x123456   
