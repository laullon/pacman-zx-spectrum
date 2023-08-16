render_bck_pacman:
    db 0, 0, 0, 0, 0       ; addr (0,1) - addr (2,3) - ATTR (4)
    db 0, 0, 0, 0          ; addr (5,6) - SPRITE (7,8)
    db 0, 0, 0, 0          ; addr (9,10) - SPRITE (11,12)
render_bck_blinky:
    db 0, 0, 0, 0, 0
    db 0, 0, 0, 0    
    db 0, 0, 0, 0     
render_bck_pinky:
    db 0, 0, 0, 0, 0
    db 0, 0, 0, 0     
    db 0, 0, 0, 0     
render_bck_inky:
    db 0, 0, 0, 0, 0
    db 0, 0, 0, 0     
    db 0, 0, 0, 0     
render_bck_clyde:
    db 0, 0, 0, 0, 0
    db 0, 0, 0, 0     
    db 0, 0, 0, 0     
render_pacman:
    db 0, 0, 0, 0, 0
    db 0, 0, 0, 0     
    db 0, 0, 0, 0     
render_blinky:
    db 0, 0, 0, 0, 0
    db 0, 0, 0, 0     
    db 0, 0, 0, 0     
render_pinky:
    db 0, 0, 0, 0, 0
    db 0, 0, 0, 0     
    db 0, 0, 0, 0     
render_inky:
    db 0, 0, 0, 0, 0
    db 0, 0, 0, 0     
    db 0, 0, 0, 0     
render_clyde:
    db 0, 0, 0, 0, 0
    db 0, 0, 0, 0     
    db 0, 0, 0, 0     


Render IRP slot, render_bck_pacman, render_bck_blinky, render_bck_pinky, render_bck_inky, render_bck_clyde
    ld a, (slot + 4)
    ld hl, (slot)
    ld (hl), a
    ld hl, (slot+2)
    ld (hl), a

    ld hl, (slot+5)
    ld de, (slot+7)
    ld b, 8
_loop_##slot
    ld a, (de)
    ld (hl), a
    inc h
    inc de
    djnz _loop_##slot

    ld hl, (slot+9)
    ld de, (slot+11)
    ld b, 8
_loop_2_##slot
    ld a, (de)
    ld (hl), a
    inc h
    inc de
    djnz _loop_2_##slot
endm

Render2 IRP slot, render_pacman, render_blinky, render_pinky, render_inky, render_clyde
    ld a, (slot + 4)
    ld hl, (slot)
    ld (hl), a
    ld hl, (slot+2)
    ld (hl), a

    ld hl, (slot+5)
    ld de, (slot+7)
    ld b, 8
_loop_##slot
    ld a, (de)
    or (hl)
    ld (hl), a
    inc h
    inc de
    djnz _loop_##slot

    ld hl, (slot+9)
    ld de, (slot+11)
    ld b, 8
_loop_2_##slot
    ld a, (de)
    or (hl)
    ld (hl), a
    inc h
    inc de
    djnz _loop_2_##slot
endm

    ret