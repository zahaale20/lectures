        .ORIG x3000

        LEA R1, ARR     ; R1 = ARR

        AND R2, R2, #0  ; R2 = 5
        ADD R2, R2, #5

        STR R2, R1, #1  ; ARR[1] = 5

        HALT

ARR     .BLKW #4        ; An array of length 4

        .END
