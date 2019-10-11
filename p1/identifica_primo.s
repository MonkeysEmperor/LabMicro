@r1 -> numero a ser identificado
@r2 -> resultado (primo ou não)

.text
.global main

main:   	mov 	r1, #26
			mov 	r3, #2 			@divisor e contador
			mov 	r2, #1			@resultado assume primo
        	mov 	r4, r1, asr #1	@divide numero por dois e guarda em r4
			adr 	r12, temp
for1:   	cmp 	r3, r4			@contador <= n/2
        	bgt 	outmain			
			stmfa 	r12!, {r0-r4}
			mov 	r2, r3
			bl 		divide
			cmp 	r5, #0
			moveq 	r2, #0
			beq 	outmain
			ldmfa	r12!, {r0-r4}
			add 	r3, r3, #1
			b		for1
outmain:	swi 0x0


@-------------------------------
@ divide
@------------
@ r1 -> dividendo
@ r2 -> divisor
@ r3 -> resultado
@ r5 -> resto
@-------------------------------
divide:	mov    	r3, #0
		mov    	r5, r1
		mov    	r0, #1
		and    	r8, r1, #0x80000000
		cmp    	r1,#0
		rsbmi  	r1,r1,#0
		and    	r9, r2, #0x80000000
		cmp    	r2,#0
		rsbmi  	r2,r2,#0
loop1:	cmp    	r5, r2                
	   	bmi    	fim
		mov    	r4, r2
		mov    	r7, #0
loop2:	mov    	r6, r4, lsl#1
		cmp    	r5, r6
		bmi    	out
	   	mov    	r4, r4, lsl #1
		add    	r7, r7, #1
		b      	loop2
out:	add    	r3, r3, r0, lsl r7
		sub    	r5, r5, r4
		b      	loop1
fim:	eors   	r8,r8,r9
		mvnmi  	r3,r3
		addmi  	r3,r3,#1
		bx		lr
             
temp:
	.word 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
