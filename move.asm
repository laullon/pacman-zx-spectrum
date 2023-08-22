checkNextDirectionPacman:
    ld ix, pacman
    ld a, (KeyPressed)
    cp $ff                          ; Key pressed ?
    jr z, _next                     ; no

    ld b, (ix+S_target_row)
    ld c, (ix+S_target_col)
    ld a, (KeyPressed)              ; check if the keyboard
    call IsValidMove                ; produce a valid direction
    cp 0                            ; change
    jp z, _next                     ; no, ignore keyboard
    ld a, (KeyPressed)              ; yes, change nex direction
    ld (ix+S_nextdirection), a
    jp _end

_next
    ld b, (ix+S_target_row)
    ld c, (ix+S_target_col)
    ld a, (ix+S_nextdirection)      ; check if pacman can
    call IsValidMove                ; continue moving
    cp 0
    jp nz, _end                     ; yes
    ld (ix+S_nextdirection), D_stop ; no, stop
_end
    ret

checkNextDirectionGhost:
    ld b, (ix+S_target_row)
    ld c, (ix+S_target_col)
    ld a, (ix+S_nextdirection)      ; check if the ghost can
    call IsValidMove                ; continue moving
    cp 0
    jp nz, _end                     ; yes
    ld a, (ix+S_nextdirection)      ; no, try next direction
    inc a
    cp 4
    jr z, _zero
    ld (ix+S_nextdirection), a
    jr _recheck
_zero
    ld (ix+S_nextdirection), 0
_recheck
    call checkNextDirectionGhost
_end
    ret

; arguments: 
;   a - direction
;  bc - pos
; return
;   Z if ok
; destroy a, bc
IsValidMove:
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
    inc c
    jp _done

_left
    dec c
    jp _done

_up
    dec b
    jp _done

_down
    inc b
    jp _done

_done
IFDEF DEBUG
    call Get_Attr_Address
    ld (hl), %01111111
ENDIF
    call Get_Map_Address        ; next target map info
    ld a, (hl)
    and $0f                     ; remove wall info ($x0 is a wall)
    cp 0                        ; wall?    
_end
    ret
