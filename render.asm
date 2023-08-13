render_ent0: db 0, 0, 0, 0, 0       ; addr (0,1) - addr (2,3) - ATTR (4)
             db 0, 0, 0, 0          ; addr (5,6) - SPRITE (7,8)
             db 0, 0, 0, 0          ; addr (9,10) - SPRITE (11,12)
render_ent1: db 0, 0, 0, 0, 0
             db 0, 0, 0, 0    
             db 0, 0, 0, 0     
render_ent2: db 0, 0, 0, 0, 0
             db 0, 0, 0, 0     
             db 0, 0, 0, 0     
render_ent3: db 0, 0, 0, 0, 0
             db 0, 0, 0, 0     
             db 0, 0, 0, 0     
render_ent4: db 0, 0, 0, 0, 0
             db 0, 0, 0, 0     
             db 0, 0, 0, 0     
render_ent5: db 0, 0, 0, 0, 0
             db 0, 0, 0, 0     
             db 0, 0, 0, 0     
render_ent6: db 0, 0, 0, 0, 0
             db 0, 0, 0, 0     
             db 0, 0, 0, 0     
render_ent7: db 0, 0, 0, 0, 0
             db 0, 0, 0, 0     
             db 0, 0, 0, 0     
render_ent8: db 0, 0, 0, 0, 0
             db 0, 0, 0, 0     
             db 0, 0, 0, 0     
render_ent9: db 0, 0, 0, 0, 0
             db 0, 0, 0, 0     
             db 0, 0, 0, 0     


             db 0, 0, 0, 0     
             db 0, 0, 0, 0     
             db 0, 0, 0, 0     
             db 0, 0, 0, 0

Render IRP slot, render_ent0, render_ent1, render_ent2, render_ent3, render_ent4
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

Render2 IRP slot, render_ent5, render_ent6, render_ent7, render_ent8, render_ent9
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