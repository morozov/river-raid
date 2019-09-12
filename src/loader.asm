; Clear the screen
XOR A            ; BORDER 0
OUT ($FE), A     ;
LD HL, #4000     ; from 16385
LD DE, #4001     ; to   16385
LD BC, #1AFF     ; repeat 6911 times
LDIR             ; copy

; Load the image
LD DE, (#5CF4)   ; restore the FDD head position
LD BC, #0705     ; load 7 sectors of compressed image
LD HL, #9C40     ; destination address (40000)
CALL #3D13       ;
CALL #9C40       ; decompress the image
