frameCounter: db 0

GameLoop:
    ld a, 1
    out (0xfe), a    

    call Render

    ld a, 2
    out (0xfe), a    

    ;; UPDATE next frame
    ld hl, frameCounter
    ld a, (hl)
    inc a
    ld (hl), a
    cp 10
    jp nz, noUpdate
    ld (hl), 0

    ;; RESTOREMap MAP
    ld hl, pacman
    ld iy, render_ent0
    call RestoreMap

    ld hl, blinky
    ld iy, render_ent1
    call RestoreMap

    ld hl, pinky
    ld iy, render_ent2
    call RestoreMap

    ld hl, inky
    ld iy, render_ent3
    call RestoreMap

    ld hl, clyde
    ld iy, render_ent4
    call RestoreMap

    ;; MOVE
    ld hl, pacman
    call Move

    ld hl, blinky
    call Move

    ld hl, pinky
    call Move

    ld hl, inky
    call Move

    ld hl, clyde
    call Move


    ld a, 3
    out (0xfe), a    


    ;; DRAW
    ld ix, pacman 
    ld iy, render_ent5
    call DrawSprite

    ld ix, blinky 
    ld iy, render_ent6
    call DrawSprite

    ld ix, pinky 
    ld iy, render_ent7
    call DrawSprite

    ld ix, inky 
    ld iy, render_ent8
    call DrawSprite

    ld ix, clyde 
    ld iy, render_ent9
    call DrawSprite

    ld a, 3
    out (0xfe), a    



    ld hl, pacman + 2 
    call UpdateNextFrame

    ld hl, blinky + 2 
    call UpdateNextFrame

    ld hl, pinky + 2 
    call UpdateNextFrame

    ld hl, inky + 2 
    call UpdateNextFrame

    ld hl, clyde + 2 
    call UpdateNextFrame

noUpdate:

    ;;------

    ld a, 0
    out (0xfe), a    
    halt
    jp GameLoop

; RestoreMap
; hl -> sprite
RestoreMap:
    ld b, (hl)      ; pos
    inc hl
    ld c, (hl)
    call Get_Attr_Address
    ld (iy+0), l
    ld (iy+1), h
    ld (iy+2), $46
    call Get_Map_Address
    ld a, (hl)
    cp 1            
    jp Z, _dot
    cp 2            
    jp Z, _power
    cp 3            
    jp Z, _empty
    jp _done

_dot:
    call Get_Position_Address
    ld (iy+3), l
    ld (iy+4), h
    ld hl, dot
    ld (iy+5), l
    ld (iy+6), h
    jp _done

_power:
    call Get_Position_Address
    ld (iy+3), l
    ld (iy+4), h
    ld hl, power
    ld (iy+5), l
    ld (iy+6), h
    jp _done

_empty:
    call Get_Position_Address
    ld (iy+3), l
    ld (iy+4), h
    ld hl, empty
    ld (iy+5), l
    ld (iy+6), h
    jp _done

_done
    ret

; Move
; hl -> sprite
; destroy a,hl
Move:
    inc hl
    ld a, (hl)
    inc a
    and $1f
    ld (hl), a
    ret

; UpdateNextFrame
; claculate the next framen and 
; the next frame offset
; hl -> sprite
; destroy a, hl
UpdateNextFrame:
    ld a, (hl)      ; total frames
    inc hl
    inc (hl)
    cp (hl)         ; actual frame
    jr z, _zero
    jr _done
_zero
    ld (hl), 0
_done
    ld a, (hl)
    rlca            ; offset (x8)
    rlca
    rlca
    inc hl
    ld (hl), a
    ret

DrawSprite:
    ld b, (ix+0)      ; pos
    ld c, (ix+1)
    ld a, (ix+7)
    call Get_Attr_Address
    ld (iy+0), l
    ld (iy+1), h
    ld (iy+2), a

    ld h, (ix+6)      ; 1st frame
    ld l, (ix+5)      
    ld e, (ix+4)      ; offset
    ld d, 0
    add hl, de
    ld (iy+5), l
    ld (iy+6), h
    call Get_Position_Address
    ld (iy+3), l
    ld (iy+4), h

    ret


include "sprites.asm"

