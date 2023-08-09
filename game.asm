GameLoop:
    ld a, 2
    out (0xfe), a    
    ld ix, SPRITES 
    call DrawSprite
    ld bc, SPRITE_SIZE
    add ix, bc
    call DrawSprite
    ld bc, SPRITE_SIZE
    add ix, bc
    call DrawSprite
    ld bc, SPRITE_SIZE
    add ix, bc
    call DrawSprite
    ld bc, SPRITE_SIZE
    add ix, bc
    call DrawSprite
    ld a, 0
    out (0xfe), a    
    halt
    jr GameLoop

DrawSprite:
    ld h, (ix+5)
    ld l, (ix+4)      

    ld a, (ix+3)      ; next frame
    ld de, 8
_frame_loop:
    cp 0
    jr z, _frame_ok
    add hl, de
    dec a
    jr _frame_loop
_frame_ok
    ld d, h
    ld e, l

    ld a, (ix+3)
    ld b, (ix+2)
    inc a
    cp b
    jr nz, _next
    ld a, 0
_next
    ld (ix+3), a

    ld b, (ix+0)      ; pos
    ld c, (ix+1)
stop:
    call Get_Attr_Address
    ld a, (ix+6)
    ld (hl), a
    call Get_Position_Address
    ld b, 8
_loop
    ld a, (de)
    ld (hl), a
    inc h
    inc de
    djnz _loop
    ret


include "sprites.asm"

