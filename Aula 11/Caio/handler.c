volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000;
volatile unsigned int * const TIMEROX = (unsigned int *)0x101E200C;

void print_uart0(const char *s) {
 while(*s != '\0') { /* Loop until end of string */
 *UART0DR = (unsigned int)(*s); /* Transmit char */
 s++; /* Next char */
 }
}

void handler_timer() {
	*TIMEROX = 0;
	//print_uart0("#");
}
 
void print_1() {
	print_uart0("1");
}

void print_2() {
	print_uart0("2");
}
