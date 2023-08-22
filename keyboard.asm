KeyPressed: db 0xff

ReadKeyboard
    ld hl, KeyPressed
    ld bc, 0xdffe
    in a,(c)
    and 2
    jr z, _k_o_pressed

    ld bc, 0xdffe
    in a,(c)
    and 1
    jr z, _k_p_pressed

    ld bc, 0xfbfe
    in a,(c)
    and 1
    jr z, _k_q_pressed

    ld bc, 0xfdfe
    in a,(c)
    and 1
    jr z, _k_a_pressed

    ld (hl), 0xff
    jr _done

_k_o_pressed
    ld (hl), D_left
    jr _done

_k_p_pressed
    ld (hl), D_right
    jr _done

_k_q_pressed
    ld (hl), D_up
    jr _done

_k_a_pressed
    ld (hl), D_down
    jr _done

_done
    ld hl, $5800
    ld (hl), 0
    inc hl
    ld (hl), 0
    inc hl
    ld (hl), 0
    inc hl
    ld (hl), 0
    inc hl

    ld hl, $5800
    ld a, (KeyPressed)
    cp $FF
    jr z, _end
    ld b, 0
    ld c, a
    add hl, bc
    ld (hl), %01001001
_end
    ret

