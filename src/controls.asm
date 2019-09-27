            ORG #607A
moveup      EQU #670A
movedn      EQU #6717

; see http://www.breakintoprogram.co.uk/computers/zx-spectrum/keyboard
; Map Q instead of 2 to UP
    LD      A, #FB
    IN      A, (#FE)
    BIT     0, A
    CALL    Z, moveup

; Map A instead of W to DOWN
    LD      A, $FD
    IN      A, (#FE)
    BIT     0, A
    CALL    Z, movedn
