.text
.global main

main:  mov r6, #0xA
            mov r4, r6
loop:       subs r6, r6, #1
            mulne r5, r4, r6
            movne r4, r5
            bne loop
