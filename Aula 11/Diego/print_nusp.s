	.file	"print_nusp.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"9395112\000"
	.text
	.align	2
	.global	print_nusp
	.type	print_nusp, %function
print_nusp:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r0, .L2
	bl	print_uart0
	.word 0xffffffff
	ldmfd	sp, {fp, sp, pc}
.L3:
	.align	2
.L2:
	.word	.LC0
	.size	print_nusp, .-print_nusp
	.ident	"GCC: (GNU) 3.4.3"
