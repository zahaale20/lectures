        .ORIG x3000

        ; R2 and R7 are "caller-save", but we are not currently using them for
        ;  anything meaningful, so we don't have to save them.
        JSR SUB         ; Call SUB.
        ; ...if we cared about R2 or R7, we would have to restore them here.

        JSR SUB         ; Call SUB again.
        HALT

; Subtracts one register from another.
;  Takes the minuend in R0, subtrahend in R1.
;  Returns the difference in R2.
SUB     ST  R3, SAVER3  ; Save R3 -- note that R3 is "callee-save", it may or
                        ;  may not be meaningful, but we have no way of knowing,
                        ;  so we have to save it regardless.

        NOT R3, R1      ; Negate R1.
        ADD R3, R3, #1
        ADD R2, R0, R3  ; Add -R1 to R0.
        LD  R3, SAVER3  ; Restore R3.
        RET             ; Return.

SAVER3  .FILL x00       ; Space in which to save R3.

        .END
