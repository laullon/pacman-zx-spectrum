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
    cp 5
    jp nz, noUpdate
    ld (hl), 0

IRP sprite, pacman, blinky, pinky, inky, clyde
    ;; RESTORE MAP
    ld ix, sprite
    ld iy, render_bck_##sprite
    call RestoreMapSprite
endm

IRP sprite, pacman, blinky, pinky, inky, clyde
    ld a, (sprite + 3)
    cp 0
    jp nz, notMove_##sprite
    ld ix, sprite
    call MoveSprite
notMove_##sprite
endm

IRP sprite, pacman, blinky, pinky, inky, clyde
    ld ix, sprite
    ld iy, render_##sprite
    call DrawSprite
endm

IRP sprite, pacman, blinky, pinky, inky, clyde
    ;; RESTORE MAP
    ld ix, sprite
    call NextFrameSprite
endm

    ld a, 3
    out (0xfe), a

noUpdate:

    ;;------

    ld a, 0
    out (0xfe), a
    halt
    jp GameLoop

; RestoreMap
; hl -> sprite
RestoreMapSprite:
    ld b, (ix+S_row)            ; pos
    ld c, (ix+S_col)

    call Get_Position_Address
    ld (iy+5), l
    ld (iy+6), h

    call Get_Attr_Address
    ld (iy+0), l
    ld (iy+1), h
    ld (iy+4), $46

    call Get_Map_Sprite
    ld (iy+7), l
    ld (iy+8), h

    ld b, (ix+S_target_row)            ; pos
    ld c, (ix+S_target_col)

    call Get_Position_Address
    ld (iy+9), l
    ld (iy+10), h

    call Get_Attr_Address
    ld (iy+2), l
    ld (iy+3), h

    call Get_Map_Sprite
    ld (iy+11), l
    ld (iy+12), h

    ret

; Get Map Sprite
; hl -> sprite
Get_Map_Sprite
    call Get_Map_Address
    ld a, (hl)
    cp 1
    jp Z, _dot
    cp 2
    jp Z, _power
    jp _empty

_dot:
    ld hl, dot
    jp _done

_power:
    ld hl, power
    jp _done

_empty:
    ld hl, empty
    jp _done

_done

    ret

; Move
; hl -> sprite
; destroy a,hl
MoveSprite:
    ld a, (ix+S_target_row)
    ld (ix+S_row), a
    ld a, (ix+S_target_col)
    ld (ix+S_col), a

    ld a, (ix+S_direction)
    cp D_right
    jp z, _right
    cp D_left
    jp z, _left
    cp D_up
    jp z, _up
    cp D_down
    jp z, _down
    jp _done

_right
    ld a, (ix+S_target_col)
    inc a
    cp 30
    jp nz, _contr
    dec a
    dec a
    ld (ix+S_direction), D_left
_contr
    ld (ix+S_target_col), a
    jp _done

_left
    ld a, (ix+S_target_col)
    dec a
    cp 0
    jp nz, _contl
    inc a
    inc a
    ld (ix+S_direction), D_right
_contl
    ld (ix+S_target_col), a
    jp _done

_up
    ld a, (ix+S_target_row)
    dec a
    cp 0
    jp nz, _contu
    inc a
    inc a
    ld (ix+S_direction), D_down
_contu
    ld (ix+S_target_row), a
    jp _done

_down
    ld a, (ix+S_target_row)
    inc a
    cp 24
    jp nz, _contd
    dec a
    dec a
    ld (ix+S_direction), D_up
_contd
    ld (ix+S_target_row), a
    jp _done

_done
    ret


; NextFrameSprite
; claculate the next framen and
; the next frame offset
; hl -> sprite
; destroy a, hl
NextFrameSprite:
    ld a, (ix+S_n_frames)
    inc (ix+S_a_frame)
    cp (ix+S_a_frame)
    jr z, _zero
    jr _done
_zero
    ld (ix+S_a_frame), 0
_done
    ld a, (ix+S_a_frame)
    ld b, (ix+S_direction)
stop
    sla a           ; offset x2
    sla b           ; direction x8
    sla b
    sla b
    add a, b
    ld (ix+S_f_offeset), a
    ret

DrawSprite:
    ld b, (ix+S_row)            ; pos
    ld c, (ix+S_col)
    call Get_Attr_Address
    ld (iy+0), l
    ld (iy+1), h
    call Get_Position_Address
    ld (iy+5), l
    ld (iy+6), h

    ld b, (ix+S_target_row)            ; pos
    ld c, (ix+S_target_col)
    call Get_Attr_Address
    ld (iy+2), l
    ld (iy+3), h
    call Get_Position_Address
    ld (iy+9), l
    ld (iy+10), h

    ld a, (ix+S_color)
    ld (iy+4), a

    ld h, (ix+S_sprite_H)      ; 1st frame
    ld l, (ix+S_sprite_L)
    ld e, (ix+S_f_offeset)      ; offset
    ld d, 0
    add hl, de

    ld c, (hl)
    inc hl
    ld b, (hl)

    ld (iy+7), c
    ld (iy+8), b
    ld l, c
    ld h, b
    ld bc, 8
    add hl, bc
    ld (iy+11), l
    ld (iy+12), h


    ret


include "sprites.asm"

