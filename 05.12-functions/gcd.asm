; Defines functions for computing greatest common divisors.
; CSC 225, Assignment 6
; Given code, Spring '21
; TODO: Complete this file.

            .ORIG x4000

; int gcd(int, int)
GCDFN       ; Callee setup:
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

            .END
