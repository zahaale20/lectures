; Left shift a value from memory, R1 times.

        .ORIG x3000

        LD  R2, DATA    ; Labels can be used to load and store.
LOOP    ADD R2, R2, R2
        ADD R1, R1, #-1
        BRp LOOP        ; Labels can also be used for branches.
        HALT
        
DATA    .FILL x0001

        .END