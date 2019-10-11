.global _start
.text

_start:
    b _Reset                            @posição 0x00 - Reset
    ldr pc, _undefined_instruction      @posição 0x04 - Intrução não-definida
    ldr pc, _software_interrupt         @posição 0x08 - Interrupção de Software
    ldr pc, _prefetch_abort             @posição 0x0C - Prefetch Abort
    ldr pc, _data_abort                 @posição 0x10 - Data Abort
    ldr pc, _not_used                   @posição 0x14 - Não utilizado
    ldr pc, _irq                        @posição 0x18 - Interrupção (IRQ)
    ldr pc, _fiq                        @posição 0x1C - Interrupção (FIQ)

_undefined_instruction: .word undefined_instruction
_software_interrupt: .word software_interrupt
_prefetch_abort: .word prefetch_abort
_data_abort: .word data_abort
_not_used: .word not_used
_irq: .word irq
_fiq: .word fiq

INTPND:   .word 0x10140000 @Interrupt status register
INTSEL:   .word 0x1014000C @interrupt select register( 0 = irq, 1 = fiq)
INTEN:    .word 0x10140010 @interrupt enable register
TIMER0L:  .word 0x101E2000 @Timer 0 load register
TIMER0V:  .word 0x101E2004 @Timer 0 value registers
TIMER0C:  .word 0x101E2008 @timer 0 control register
TIMER0X:  .word 0x101E200c @timer 0 interrupt clear register

_Reset:
    MRS r0, cpsr    			@ salvando o modo corrente em R0
    MSR cpsr_ctl, #0b11010010 		@ alterando o modo para irq - o SP eh automaticamente chaveado ao chavear o modo
    LDR sp, =irq_stack_top 		@ a pilha de irq eh setada 
    MSR cpsr, r0 			@ volta para o modo anterior
    LDR sp, =stack_top
    bl  main
    b   .

undefined_instruction:
    b   .

software_interrupt:
    b   do_software_interrupt @vai para o handler de interrupções de software

prefetch_abort:
    b   .

data_abort:
    b   .

not_used:
    b   .

irq:
    b   do_irq_interrupt      @vai para o handler de interrupções IRQ

fiq:
    b   .

do_software_interrupt:        @Rotina de Interrupção de software
    add r1, r2, r3            @r1 = r2 + r3
    mov pc, r14               @volta p/ o endereço armazenado em r14

do_irq_interrupt:             @Rotina de interrupções IRQ
    SUB LR, LR, #4	      @PC = LR - 4
    STMFD sp!, {lr, r0-r12}   @Empilha os registradores

    MRS r0, SPSR
    STMFD sp!, {r0}   @Empilha os registradores

    @ Desabilitando interrupções
    MRS R0, CPSR
    ORR R0, R0, #0xC0
    MSR cpsr_c, R0

    LDR r0, INTPND            @Carrega o registrador de status de interrupção
    LDR r0, [r0]

    TST r0, #0x0010           @verifica se é uma interupção de timer
    BLNE handler_timer        @vai para o rotina de tratamento da interupção de timer
    BLNE troca_processo

    @ Abilitando interrupções
    MRS R0, CPSR
    BIC R0, R0, #0xC0
    MSR cpsr_c, R0

    LDMFD   sp!, {r0-r12,PC}^ @retorna

troca_processo:
	bl salva_registradores

	@trocando flag do processo
	ADR r3, procN
	LDR r2, [r3]
	EOR r2, r2, #0x1
	STR r2, [r3]

	bl recupera_registradores

	
recupera_registradores:
	ADR r2, procN
	LDR r2, [r2]
	CMP r2, #0
	ADREQ lr, linhaA
	ADRNE lr, linhaB

	ADD lr, lr, #16*4
	LDMFA lr!, {r0-r2}

	MRS r4, cpsr 		@salva modo atual
	@MOV r6, lr
	LDR r5, =0b10010011 	@modo supervisor
	MSR cpsr_c, r5		@troca para modo supervisor
	MSR spsr_c, r2		@coloca o r2 no spsr
	MOV sp, r1		@coloca o r1 no sp
	MOV lr, r0		@coloca o r0 no lr
	MSR cpsr_c, r4 		@volta modo

	LDMFA lr!, {r0-r12, PC}^

@handler_timer:
@    STMFD sp!, {r0-r3, lr}
@    LDR r0, TIMER0X
@    MOV r1, #0x0
@    STR r1, [r0]              @Escreve no registrador TIMER0X para limpar o pedido de interrupção

    @Inserir código que sera executado na interrupção de timer aqui (chaveamento de processos, ou alternar LED por exemplo)
@    LDMFD   sp!, {r0-r3,lr}   @retorna
@    mov pc, r14

salva_registradores:
	@ Salva como um vetor [r0-r12|pc|lr|sp|cpsr]

	ADR r0, aux
	STR lr, [r0]

	LDMFD sp!, {r1}
	STR r1, [r0, #4]

	ADR r2, procN
	LDR r2, [r2]
	CMP r2, #0
	ADREQ lr, linhaA
	ADRNE lr, linhaB
	SUB lr, lr, #4

	@ R0 - R12
	LDMFD sp!, {r0-r12}
	STMFA lr!, {r0-r12}

	@ pc
	LDMFD sp!, {r0}
	STMFA lr!, {r0}

	@ lr e sp
	MRS r0, cpsr 		@salva modo atual
	MOV r2, lr
	LDR r1, =0b10010011 	@modo supervisor
	MSR cpsr_c, r1		@troca para modo supervisor
	STMFA r2!, {lr}
	STMFA r2!, {sp}
	MSR cpsr_c, r0 		@volta modo
	
	@ cpsr
	ADR r0, aux
	LDR r1, [r0, #4]
	STMFA r2!, {r1}

	@recupra o lr da função atual e retorna
	ADR r0, aux
	LDR lr, [r0]
	MOV pc, lr

timer_init:
	 LDR r0, INTEN
	 LDR r1,=0x10 @bit 4 for timer 0 interrupt enable
	 STR r1,[r0]
	 LDR r0, TIMER0L
	 LDR r1, =0x3000 @setting timer value
	 STR r1,[r0]
	 LDR r0, TIMER0C
	 MOV r1, #0xE0 @enable timer module
	 STR r1, [r0]
	 mrs r0, cpsr
	 bic r0,r0,#0x80
	 msr cpsr_c,r0 @enabling interrupts in the cpsr
	 mov pc, lr

processo_A_init:

	ADR r0, linhaA
	SUB r0, r0, #4
	STMFA r0!, {r0-r12}
	ADR r1, processo_A
	MOV r2, sp
	MRS r3, cpsr
	STMFA r0!, {r0-r3}

	MOV r0, #10
	MOV r2, #20
	MOV R12, #120
	MOV r1, #0x0
	mov pc, lr

processo_B_init:
	ADR r0, linhaB
	SUB r0, r0, #4
	STMFA r0!, {r0-r12}
	ADR r1, processo_B
	MOV r2, sp
	MRS r3, cpsr
	STMFA r0!, {r0-r3}
	MOV pc, lr

main:

	bl processo_A_init	  @inicializa processo A
	bl processo_B_init	  @inicializa processo B
	bl timer_init             @initialize interrupts and timer 0


processo_A: 
	bl print_1
	ADD r1, r1, #1
	b processo_A

processo_B: 
	bl print_2
	b processo_B

@fim:
 @   swi 0x1234

aux:
	.word 0x0, 0x0

linhaA:
	.skip 17*4
linhaB:
	.skip 17*4
procN:
	.word 0x0
