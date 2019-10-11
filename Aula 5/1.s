.text
.globl main

main:   mov r0, #0
        ldr r1, =0x4000
        ldr r2, =0x5000       
for:    cmp r0, #32
        bge out
        rsb r4, r0, #28
        ldr r3, [r2, r4]
        str r3, [r1, r0]
        add r0, r0, #4
        b   for
out:    swi 0x0




