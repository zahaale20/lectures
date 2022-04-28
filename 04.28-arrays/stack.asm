        .ORIG x3000

        ; NOTE: Stacks may grow from "low to high" or, equivalently, from
        ;       "high to low". There is no asymptotic performance difference,
        ;       but it is more convenient to go "high to low".
        LEA R1, ARR     ; Initialize the stack pointer in R1.
        ADD R1, R1, #4  ; Offset the stack pointer to be one location below
                        ;  the "array" backing the stack.

        ; Push 1:
        AND R2, R2, #0
        ADD R2, R2, #1
        ADD R1, R1, #-1 ; Move the stack pointer *down* one location.
        STR R2, R1, #0

        ; Push 2:
        ADD R2, R2, #1
        ADD R1, R1, #-1 ; Move the stack pointer *down* one location.
        STR R2, R1, #0

        ; Push 3:
        ADD R2, R2, #1
        ADD R1, R1, #-1 ; Move the stack pointer *down* one location.
        STR R2, R1, #0

        ; Pop into R3:
        LDR R3, R1, #0
        ADD R1, R1, #1  ; Move the stack pointer *up* one location.

        HALT

ARR     .BLKW #4        ; An array of length 4

        .END
