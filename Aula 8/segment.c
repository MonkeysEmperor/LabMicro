#include <stdlib.h>
#include <stdio.h>
#include "segment.h"
#define SYSCFG 0x03ff0000
#define IOPMOD ((volatile unsigned *)(SYSCFG+0x5000))
#define IOPDATA ((volatile unsigned *)(SYSCFG+0x5008))


int main(void) {
    // inicalização
    *IOPMOD |= SEG_MASK;
    *IOPDATA |= SEG_MASK;
    imprime(0x6, 0, 1, 2, 3);
    
    return 0;
}