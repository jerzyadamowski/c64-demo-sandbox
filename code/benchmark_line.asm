; C64
BASIC         = $0801

;==========================================================
; BASIC header
;==========================================================

* = BASIC

        !byte $0b, $08
        !byte $9A                     ; BASIC line number:  $029A = 666; $029B = 667
        !byte $02, $9E
        !byte '0' + entry % 10000 / 1000
        !byte '0' + entry %  1000 /  100
        !byte '0' + entry %   100 /   10
        !byte '0' + entry %    10
        !byte $00, $00, $00           ; end of basic

entry
        lda #$00
        tax
        tay
        ;jsr $1000 ; initialize music
        nop

mainloop:
        lda $d012    ; load $d012
        cmp #$80     ; is it equal to #$80?
        bne mainloop ; if not, keep checking

        inc $d020    ; inc border colour
        inc $d021
        ;jsr $1003    ; jump to music play routine
        nop
        dec $d020    ; dec border colour
        dec $d021
        jmp mainloop ; keep looping
