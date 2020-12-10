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
        lda #$01
        sta $d015    ; Turn sprite 0 on
        sta $d027    ; Make it white
        lda #$40
        sta $d000    ; set x coordinate to 40
        sta $d001    ; set y coordinate to 40
        lda #$80
        sta $07f8    ; set pointer: sprite data at $2000

mainloop
        lda $d012
        cmp #$ff     ; raster beam at line $ff?
        bne mainloop ; no: go to mainloop

        lda dir      ; in which direction are we moving?
        beq down     ; if 0, down

                    ; moving up
        ldx coord    ; get coord
        dex          ; decrement it
        stx coord    ; store it
        stx $d000    ; set sprite coords
        stx $d001
        cpx #$40     ; if it's not equal to $40...
        bne mainloop ; just go back to the mainloop

        lda #$00     ; otherwise, change direction
        sta dir
        jmp mainloop

down
        ldx coord    ; this should be familiar
        inx
        stx coord
        stx $d000
        stx $d001
        cpx #$e0
        bne mainloop

        lda #$01
        sta dir
        jmp mainloop

coord
        !byte $40   ; current x and y coordinate
dir
        !byte 0     ; direction: 0 = down-right, 1 = up-left
