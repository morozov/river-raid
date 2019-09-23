pr_string   EQU #203C ; https://skoolkid.github.io/rom/asm/1FFC.html#203C
chan_open   EQU #1601 ; https://skoolkid.github.io/rom/asm/1601.html
dstbuffer   EQU #5B00
dstsys      EQU #5C4F ; https://skoolkid.github.io/rom/asm/5C4F.html
dstprog     EQU #5CCB
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

sysvars:
    DEFB    #B6,#5C ; CHANS
    DEFB    #B6,#5C ; CURCHL
    DEFB    #CB,#5C ; PROG
    DEFB    #CB,#5C ; NXTLIN
    DEFB    #00,#80 ; DATADD
    DEFB    #EA,#5C ; E-LINE
    DEFB    #00,#00 ; K-CUR
    DEFB    #EC,#5C ; CH-ADD
    DEFB    #FD,#5C ; X-PTR
    DEFB    #FD,#5C ; WORKSP

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

; Restore system variables
    LD      HL, sysvars
    LD      DE, dstsys
    LD      BC, start-sysvars
    LDIR

; PRINT AT 0,0
    LD      A, #02
    CALL    chan_open
    LD      DE,at00
    LD      BC,sysvars-at00
    CALL    pr_string

; RANDOMIZE USR 23762
    JP      dstprog+7
