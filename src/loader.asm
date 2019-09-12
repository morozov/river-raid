; Load the image
LD DE, (#5CF4)   ; restore the FDD head position
LD BC, #0705     ; load 7 sectors of compressed image
LD HL, #9C40     ; destination address (40000)
CALL #3D13       ;
CALL #9C40       ; decompress the image
