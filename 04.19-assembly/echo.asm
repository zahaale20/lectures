; Read and echo one typed character.

        .ORIG x3000

        GETC            ; Read a character into R0.
        OUT             ; Echo the typed character.
        HALT

        .END
