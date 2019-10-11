volatile unsigned int * const TIMER0X = (unsigned int *)0x101E200c;
volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000;
 
void print_uart0(const char *s) {
    while(*s != '\0') { /* Loop until end of string */
        *UART0DR = (unsigned int)(*s); /* Transmit char */
        s++; /* Next char */
    }
}
 
void hello_world() {
    print_uart0("Hello world!\n");
}

void handler_timer_c (){
    *TIMER0X = 0;
    print_uart0("#");
    return;
}

void print_invalido() {
	print_uart0("invalido");
} 

void print_space() {
	print_uart0(" ");
}

void task_a() {
    while(1){
        print_uart0("1");
    }
}

void task_b() {
    while(1){
        print_uart0("2");
    }
}


