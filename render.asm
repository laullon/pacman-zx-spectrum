render_ent0: db 0, 0, 0     ; addr - ATTR
             db 0, 0, 0, 0  ; addr - SPRITE
render_ent1: db 0, 0, 0
             db 0, 0, 0, 0     
render_ent2: db 0, 0, 0
             db 0, 0, 0, 0     
render_ent3: db 0, 0, 0
             db 0, 0, 0, 0     
render_ent4: db 0, 0, 0
             db 0, 0, 0, 0     
render_ent5: db 0, 0, 0
             db 0, 0, 0, 0     
render_ent6: db 0, 0, 0
             db 0, 0, 0, 0     
render_ent7: db 0, 0, 0
             db 0, 0, 0, 0     
render_ent8: db 0, 0, 0
             db 0, 0, 0, 0     
render_ent9: db 0, 0, 0
             db 0, 0, 0, 0     


Render IRP slot, render_ent0, render_ent1, render_ent2, render_ent3, render_ent4, render_ent5, render_ent6, render_ent7, render_ent8, render_ent9
    ld hl, (slot)
    ld a, (slot + 2)
    ld (hl), a
    ld hl, (slot+3)
    ld de, (slot+5)
    ld b, 8
_loop_##slot
    ld a, (de)
    ld (hl), a
    inc h
    inc de
    djnz _loop_##slot
endm
    ret