	.file	"test.c"
	.text
	.align	2
	.global	c_entry
	.type	c_entry, %function
c_entry:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	mov	r3, #0
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
	.size	c_entry, .-c_entry
	.ident	"GCC: (GNU) 3.4.3"
