            .ORIG x1000     ; Place this service routine in the area of memory
                            ;  reserved for the OS. Note that we will also have
                            ;  to set one of the TVT entries to 0x1000.

            ADD R6, R6, #-1 ; Push to R1 onto the supervisor stack.
            STR R1, R6, #0

POLLK       LDI R0, KBSR    ; Load the contents of the KBSR.
            BRzp POLLK      ; Repeat until the user types a character.

            LDI R0, KBDR    ; Load a character from the KBDR. This is the one
                            ;  situation where LDI is useful: for accessing a
                            ;  constant address that doesn't fit in 9 bits.

POLLD       LDI R1, DSR     ; Load the contents of the DSR.
            BRzp POLLD      ; Repeat until the display is ready for a character.

            STI R0, DDR     ; Store the character in the DDR.

            LDR R1, R6, #0  ; Pop R1 off of the supervisor stack.
            ADD R6, R6, #1

            RTI             ; Return.

KBSR        .FILL xFE00     ; The address of the Keyboard Status Register
KBDR        .FILL xFE02     ; The address of the Keyboard Data Register
DSR         .FILL xFE04     ; The address of the Display Status Register
DDR         .FILL xFE06     ; The address of the Display Data Register

            .END
