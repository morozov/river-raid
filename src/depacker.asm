pr_string   EQU #203C ; https://skoolkid.github.io/rom/asm/1FFC.html#203C
chan_open   EQU #1601 ; https://skoolkid.github.io/rom/asm/1601.html
dstbuffer   EQU #5B00
chans       EQU #5C4F ; https://skoolkid.github.io/rom/asm/5C4F.html
chinfo      EQU #5CB6 ; https://skoolkid.github.io/rom/asm/5CB6.html
dstprog     EQU #5CCB
kbdupdn     EQU #607A
moveup      EQU #670A
movedn      EQU #6717
dstlern     EQU #7800

; it should be at least 63488−16687=46801 in order to not have
; the depacker overwritten by the uncompressed LERN
    ORG     #BB00
    JP      start

srcbuffer:
    incbin  buffer.zx7

srcprog:
    incbin  Prog.zx7

srclern:
    incbin  LERN.zx7

    include lib/dzx7_standard.asm

at00:
    DEFB    #16,#00,#00 ; AT 0,0

; see http://www.breakintoprogram.co.uk/computers/zx-spectrum/keyboard
kbdpatch:

; Map Q instead of 2 to UP
    LD      A, $FB
    IN      A, ($FE)
    BIT     0, A
    CALL    Z, moveup

; Map A instead of W to DOWN
    LD      A, $FD
    IN      A, ($FE)
    BIT     0, A
    CALL    Z, movedn

start:
    LD      HL, srcbuffer
    LD      DE, dstbuffer
    CALL    dzx7_standard

    LD      HL, srcprog
    LD      DE, dstprog
    CALL    dzx7_standard

    LD      HL, srclern
    LD      DE, dstlern
    CALL    dzx7_standard

; Patch keyboard controls
    LD      HL, kbdpatch
    LD      DE, kbdupdn
    LD      BC, start - kbdpatch
    LDIR

; Set CHANS back to its 48K value
    LD      HL, chans
    LD      BC, chinfo
    LD      (HL), C
    INC     HL
    LD      (HL), B

; PRINT AT 0,0
    LD      A, #02
    CALL    chan_open
    LD      DE,at00
    LD      BC,kbdpatch-at00
    CALL    pr_string

; RANDOMIZE USR 23762
    JP      dstprog+7
