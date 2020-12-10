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
        lda #$00      ; Put the value 0 in accumulator
        sta $d020     ; Put value of acc in $d020
        sta $d021     ; Put value of acc in $d021
        tax           ; Put value of acc in x reg
        lda #$20       ; Put the value $20 in acc
clrloop
        sta $0400,x   ; Put value of acc in $0400 + value in x reg
        sta $0500,x
        sta $0600,x
        sta $0700,x
        dex            ; Decrement value in x reg
        bne clrloop    ; If not zero, branch to clrloop

        ;rts
