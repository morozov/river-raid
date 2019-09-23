CLS       equ #0D6B ; https://skoolkid.github.io/rom/asm/0D6B.html
BORDCR    equ #5C48 ; https://skoolkid.github.io/rom/asm/5C48.html
ATTR_P    equ #5C8D ; https://skoolkid.github.io/rom/asm/5C8D.html

; Clear the screen
; It's not enough to just fill the video memory with zeroes
; Since the game doesn't initialize BORDER and PAPER properly
XOR A
LD (ATTR_P), A
LD (BORDCR), A
OUT (#FE), A
CALL CLS

; Load the image
LD DE, (#5CF4)   ; restore the FDD head position
LD BC, #0705     ; load 7 sectors of compressed image
LD HL, #9C40     ; destination address (40000)
CALL #3D13       ;
CALL #9C40       ; decompress the image

; Load the data
LD DE, (#5CF4)   ; restore the FDD head position
LD BC, #4205     ; load 66 sectors of data
LD HL, #BB00     ; destination address (47872)
CALL #3D13
JP #BB00
