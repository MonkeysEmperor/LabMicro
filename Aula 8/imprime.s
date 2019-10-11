	.file	"imprime.c"
	.data
	.align	2
	.type	numeric_display, %object
	.size	numeric_display, 64
numeric_display:
	.word	97280
	.word	6144
	.word	60416
	.word	48128
	.word	104448
	.word	111616
	.word	128000
	.word	7168
	.word	130048
	.word	113664
	.word	121856
	.word	126976
	.word	91136
	.word	63488
	.word	123904
	.word	115712
	.text
	.align	2
	.global	imprime
	.type	imprime, %function
imprime:
	@ args = 4, pretend = 0, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	str	r2, [fp, #-24]
	str	r3, [fp, #-28]
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
	ldr	r3, [fp, #-16]
	cmp	r3, #15
	bhi	.L2
	mov	r2, #66846720
	add	r2, r2, #217088
	add	r2, r2, #8
	mov	r3, #66846720
	add	r3, r3, #217088
	add	r3, r3, #8
	ldr	r3, [r3, #0]
	bic	r3, r3, #130048
	str	r3, [r2, #0]
	mov	r2, #66846720
	add	r2, r2, #217088
	add	r2, r2, #8
	mov	r3, #66846720
	add	r3, r3, #217088
	add	r3, r3, #8
	ldr	ip, .L3
	ldr	r1, [fp, #-16]
	ldr	r0, [r3, #0]
	ldr	r3, [ip, r1, asl #2]
	orr	r3, r0, r3
	str	r3, [r2, #0]
.L2:
	ldr	r3, [fp, #4]
	add	r3, r3, #17
	str	r3, [fp, #-32]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L4:
	.align	2
.L3:
	.word	numeric_display
	.size	imprime, .-imprime
	.ident	"GCC: (GNU) 3.4.3"
