ENTRY(_start)
SECTIONS
{
	. = 0x0;
	.text : { * (.text); }
 	stack_top = 0x1000;
 	irq_stack_top = 0x2000;
}
