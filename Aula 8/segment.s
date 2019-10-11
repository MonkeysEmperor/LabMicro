	.file	"segment.c"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	mov	r2, #66846720
	add	r2, r2, #217088
	mov	r3, #66846720
	add	r3, r3, #217088
	ldr	r3, [r3, #0]
	orr	r3, r3, #130048
	str	r3, [r2, #0]
	mov	r2, #66846720
	add	r2, r2, #217088
	add	r2, r2, #8
	mov	r3, #66846720
	add	r3, r3, #217088
	add	r3, r3, #8
	ldr	r3, [r3, #0]
	orr	r3, r3, #130048
	str	r3, [r2, #0]
	mov	r3, #3
	str	r3, [sp, #0]
	mov	r0, #6
	mov	r1, #0
	mov	r2, #1
	mov	r3, #2
	bl	imprime
	mov	r3, #0
	mov	r0, r3
	ldmfd	sp, {r3, fp, sp, pc}
	.size	main, .-main
	.ident	"GCC: (GNU) 3.4.3"
