        .ORIG x3000

MAIN    JSR FOO
        HALT

FOO     ST  R7, FOOR7   ; FOO is *both* caller and callee. It is therefore
                        ;  responsible for saving all registers, including R7,
                        ;  so that it can eventually return to MAIN.
        JSR BAR
        LD  R7, FOOR7   ; Restore R7.
        RET

BAR     ST  R7, BARR7   ; BAR is also both caller and callee, and also needs to
                        ;  save R7, but we must be careful not to overwrite the
                        ;  existing saved value from FOO.
        JSR FOO
        LD  R7, BARR7   ; Restore R7.
        RET

BAY     RET

; NOTE: This reserves memory for each subroutine *def'n*, not for each
;       subroutine *call*. This scheme only works as long as we do not have
;       multiple *calls* to the same subroutine ongoing simultaneously; i.e.,
;       as long as no subroutine is recursive.
FOOR7   .FILL x00       ; Space for FOO to save R7.
BARR7   .FILL x00       ; Space for BAR to save R7.

        .END
