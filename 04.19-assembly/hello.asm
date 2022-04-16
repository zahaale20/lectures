; Prints "Hello, world!"

        .ORIG x3000
                        ; Get address of first char.
                        ; Load current char.
                        ; While char is not null...
                        ; ...print the char...
                        ; ...increment address...
                        ; ...loop back.
            

STRING  .STRINGZ "Hello, world!\n"
        .END
