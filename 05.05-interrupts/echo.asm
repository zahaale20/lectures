            .ORIG x1000     ; Place this service routine in the area of memory
                            ;  reserved for the OS. Note that we will also have
                            ;  to set 0x0180 in the IVT to 0x1000.

            ADD R6, R6, #-1 ; Push R0 and R1 onto the supervisor stack; an ISR
            STR R0, R6, #0  ;  has no caller. Everything is callee-save, as
            ADD R6, R6, #-1 ;  the interrupted program cannot possibly know
            STR R1, R6, #0  ;  when this service routine will run.

            LDI R0, KBDR    ; Load a character from the KBDR. We do not need to
                            ;  poll the KBSR; the only way to get this far is
                            ;  if the user already typed a character.

                            ; NOTE: Due to a bug in the LC-3 simulator, this is
                            ;       the first point at which it is safe to set
                            ;       breakpoints and step through instructions.

POLLD       LDI R1, DSR     ; Poll the DSR. The display does not have support 
            BRzp POLLD      ;  for interrupts, and we cannot add that in
                            ;  software alone.

            STI R0, DDR     ; Store the character in the DDR.

            LDR R1, R6, #0  ; Pop R1 and R0 off of the supervisor stack.
            ADD R6, R6, #1
            LDR R0, R6, #0
            ADD R6, R6, #1

            RTI             ; Return.

KBSR        .FILL xFE00     ; The address of the Keyboard Status Register
KBDR        .FILL xFE02     ; The address of the Keyboard Data Register
DSR         .FILL xFE04     ; The address of the Display Status Register
DDR         .FILL xFE06     ; The address of the Display Data Register

            .END
