@N-> r1
@valor-> r3
@endereco-> r2
@resultado-> r9

@deslocador endereço -> r8
colunas:    mov r4, #0
            cmp r9, #1
            bxne lr
forCols:    cmp r4, r1
            bxge lr
            mov r8, r4
            mov r7, #0
            mov r6, #0
forCol:     cmp r7, r1
            bge endForCol
            ldrb r5, [r2, r8]
            add r7, r7, #1 @atualiza contador
            add r6, r6, r5 @atualiza soma da coluna
            add r8, r8, r1 @atualiza deslocador de endereço
            b forCol
endForCol:  cmp r6, r3
            movne r9, #0
            bxne lr
            add r4, r4, #1
            b forCols




