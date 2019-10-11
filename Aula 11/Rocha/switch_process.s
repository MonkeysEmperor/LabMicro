.global switch_process
.text

switch_process:
    ADR r0, save_lr
    STR lr, [r0]
    LDMFD sp!, {r0-r12}
    LDR lr, last_process
    SUB lr, lr, #4
    STMFA lr!, {r0-r12}
    LDR r2, [sp], #4 @resgata o pc do processo que foi interrompido (o lr-4 logo que acontece a interrupcao)
    MOV r12, lr @Salvando o endereço dessa pilha pra usar dps
    ADR r5, save_cpsr
    MRS r1, cpsr    @ salvando o modo corrente em r1
    STR r1, [r5]
    LDR r3, =0b10010011
    MSR cpsr_ctl, r3 @ alterando o modo para supervisor
    MOV r0, sp
    MOV r1, lr
    STMFA r12!, {r0-r3}
    LDR r0, save_cpsr
    MSR cpsr, r0
    LDR r0, =nproc
    LDR r1, [r0]
    ADD r1, r1, #1
    AND r1, r1, #1
    STR r1, [r0]
    CMP r1, #0
    LDREQ r0, =linhaA
    LDRGT r0, =linhaB
    STR r1, [r0] @(?)
    LDR lr, last_process
    LDR r0, [lr, #60]
    STMFD sp!, {r0}
    LDMFD lr!, {r0-r12}
    STMFD sp!, {r0-r12}
    LDR lr, save_lr
    LDMFD sp!,{r0-r12,pc}^
    BX lr

    save_lr:
    .word 0
    save_cpsr:
    .word 0

last_process:
    .word 0x3050