; Defines functions for computing greatest common divisors.
; CSC 225, Assignment 6
; Given code, Spring '21
; TODO: Complete this file.

            .ORIG x4000


; int gcd(int, int)

; Callee setup:
GCDFN       ADD R6, R6, #-2     ; push space for return value and address
            STR R7, R6, #0      ; store return address
            ADD R6, R6, #-1     ; push space for dynamic link
            STR R5, R6, #0      ; store dynamic link
            
            ADD R5, R6, #-1     ; retrieve a and b from the stack
            ADD R6, R5, #0      
            LDR R0, R5, #4
            LDR R1, R5, #5
            
            NOT R2, R1          ; two's complement of b 
            ADD R2, R2, #1      ; (b --> -b)
            ADD R3, R0, R2      ; R3: a - b
            
; "caller setup", just stores if a == b
            BRnp NEG          ; if a == b, store a or ;, else check POS/NEG
            STR R0, R5, #0
            
            BRnzp DONE
            
; caller setup: neg
NEG         BRzp POS            ; if a < b, (a, b - a); else go to POS func
            NOT R3, R3          ; twos comp of a; start of NEG func
            ADD R3, R3, #1

            ADD R6, R6, #-1     ; push space a
            STR R3, R6, #0      ; store a
            ADD R6, R6, #-1     ; push space for b
            STR R0, R6, #0      ; store b - a

            JSR GCDFN           ; recursive call --> keep looping until a and b are equal (gcd is found)
            
            LDR R1, R6, #0      ; load gcd into stack
            ADD R6, R6, #3      ; pop vars -> everything we've calculated and put into the stack
            STR R1, R5, #0      ; store gcd into stack
            
            BRnzp DONE

; caller setup: pos
POS         BRnz DONE            ; if a < b, (a - b, b); else finish
            ADD R6, R6, #-1     ; push space for pos result
            STR R1, R6, #0
            ADD R6, R6, #-1
            STR R3, R6, #0
            
            JSR GCDFN
            
            LDR R1, R6, #0      ; load gcd into stack
            ADD R6, R6, #3      ; pop vars -> everything we've calculated and put into the stack
            STR R1, R5, #0      ; store gcd into stack

; callee teardown
DONE        LDR R0, R5, #0      ; load 
            STR R0, R5, #3      ; store tmp/gcd into stack
            ADD R6, R6, #1      ; pop 
            LDR R5, R6, #0      ; load dynamic link
            ADD R6, R6, #1      ; pop
            LDR R7, R6, #0      ; load return address
            ADD R6, R6, #1      ; pop
            RET                 ; recursive call to disassmeble the stack

            .END                ; end of function



;   * Push space for the return value
            ;   * Push space for the dynamic link, return address
            ;   * Push space for "tmp"
            ; int tmp;

            ; Retrieve "a" and "b" from the stack...
            ; if (a == b) {
            ;     tmp = a;
            ; }
            ; else if (a < b) {
            ;     Caller setup:
            ;       * Push arguments
            ;     tmp = gcd(a, b - a);
            ;     Caller teardown:
            ;       * Pop return value
            ;       * Pop arguments
            ; }
            ; else {
            ;     Caller setup...
            ;     tmp = gcd(a - b, b);
            ;     Caller teardown...
            ; }

            ; Callee teardown:
            ;  * Set the return value
            ;  * Pop "tmp"
            ;  * Restore dynamic link, return address
            ;  * Return
            ; return tmp;
