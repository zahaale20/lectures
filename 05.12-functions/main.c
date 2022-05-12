#include <stdio.h>

/* Copy the information found in "add.h": */
#include "add.h"

int main(void) {
    /* Call a function that takes two integers and returns an integer: */
    printf("1 + 2 = %d\n", add(1, 2));

    return 0;
}
