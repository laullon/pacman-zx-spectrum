org $8000

DrawATTRs:
    ld a, 0             ; border blacl
    out (0xfe), a    

    ld hl, $4000        ;pixels 
    ld de, $4001        ;pixels + 1
    ld bc, $17FF        ;pixels area length - 1
    ld (hl), 0          ;set first byte to '0'
    ldir                ;copy bytes

    ld hl, MAP
    ld de, $5800

_loop:
    ld a, (hl)      ; next block on MAP
    and $0f
    ld bc, ATTRS

    add a, c        ; bc = bc + a
    ld c, a         ;
    adc a, b        ;
    sub c           ;
    ld b, a         ;

    ld a, (bc)
    ld (de), a
    inc hl
    inc de
    ld a, (hl)
    cp $FF          ; last block on MAP?
    jp NZ, _loop

DrawMaze:
    ld de, MAP
    ld bc, 0        ; 0 x 0
_loop:
    ld a, (de)      ; next block on MAP
    cp 1            
    jp Z, _dot
    cp 2            
    jp Z, _power
    cp 4            
    jp Z, _door
    cp $10          
    jp z, _w_left_t
    cp $20
    jp z, _w_vert
    cp $30
    jp z, _w_hori
    cp $40
    jp z, _w_t_d
    cp $50
    jp z, _w_right_top
    cp $60
    jp z, _w_end_l
    cp $70
    jp z, _w_end_r
    cp $80
    jp z, _w_end_b
    cp $90
    jp z, _w_left_b
    cp $a0
    jp z, _w_right_b
    cp $b0
    jp z, _w_t_r
    cp $c0
    jp z, _w_t_l
    cp $d0
    jp z, _w_t_t
    jp _next

_dot:
    call Get_Position_Address
    inc h
    inc h
    inc h
    ld (hl), %00011000
    inc h
    ld (hl), %00011000
    jp _next

_power:
    call Get_Position_Address
    inc h
    inc h
    ld (hl), %00011000
    inc h
    ld (hl), %00111100
    inc h
    ld (hl), %00111100
    inc h
    ld (hl), %00011000
    jp _next

_w_left_t:
    call Get_Position_Address
    inc h
    inc h
    ld (hl), %00011111
    inc h
    ld (hl), %00100000
    inc h
    ld (hl), %00100000
    inc h
    ld (hl), %00100011
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    jp _next

_door:
    call Get_Position_Address
    inc h
    inc h
    inc h
    ld (hl), %11111111
    inc h
    ld (hl), %11111111
    jp _next

_w_hori:
    call Get_Position_Address
    inc h
    inc h
    ld (hl), %11111111
    inc h
    ld (hl), %00000000
    inc h
    ld (hl), %00000000
    inc h
    ld (hl), %11111111
    jp _next

_w_vert:
    call Get_Position_Address
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    jp _next

_w_t_d:
    call Get_Position_Address
    inc h
    inc h
    ld (hl), %11111111
    inc h
    ld (hl), %00000000
    inc h
    ld (hl), %00000000
    inc h
    ld (hl), %11000011
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    jp _next

_w_right_top:
    call Get_Position_Address
    inc h
    inc h
    ld (hl), %11111000
    inc h
    ld (hl), %00000100
    inc h
    ld (hl), %00000100
    inc h
    ld (hl), %11000100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    jp _next

_w_end_l:
    call Get_Position_Address
    inc h
    inc h
    ld (hl), %00011111
    inc h
    ld (hl), %00100000
    inc h
    ld (hl), %00100000
    inc h
    ld (hl), %00011111
    jp _next

_w_end_r:
    call Get_Position_Address
    inc h
    inc h
    ld (hl), %11111000
    inc h
    ld (hl), %00000100
    inc h
    ld (hl), %00000100
    inc h
    ld (hl), %11111000
    jp _next

_w_end_b:
    call Get_Position_Address
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00011000
    jp _next

_w_left_b:
    call Get_Position_Address
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00100011
    inc h
    ld (hl), %00100000
    inc h
    ld (hl), %00100000
    inc h
    ld (hl), %00011111
    jp _next

_w_right_b:
    call Get_Position_Address
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %11000100
    inc h
    ld (hl), %00000100
    inc h
    ld (hl), %00000100
    inc h
    ld (hl), %11111000
    jp _next

_w_t_r:
    call Get_Position_Address
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00100011
    inc h
    ld (hl), %00100000
    inc h
    ld (hl), %00100000
    inc h
    ld (hl), %00100011
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    jp _next

_w_t_l:
    call Get_Position_Address
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %11100100
    inc h
    ld (hl), %00000100
    inc h
    ld (hl), %00000100
    inc h
    ld (hl), %11100100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    jp _next

_w_t_t:
    call Get_Position_Address
    ld (hl), %00100100
    inc h
    ld (hl), %00100100
    inc h
    ld (hl), %11000011
    inc h
    ld (hl), %00000000
    inc h
    ld (hl), %00000000
    inc h
    ld (hl), %11111111
    jp _next

_next:
    inc c
    ld a,c                  ; Col 32 ?
    cp 32
    jp NZ, _same_row
    ld c,0
    inc b
_same_row:
    inc de
    ld a, (de)
    cp $FF          ; last block on MAP?
    jp NZ, _loop



Fin:
    halt
    jp DrawMaze


; Get Position Address 
; b row
; c col
; ret hl
; addr format 010TTSSS LLLCCCCC
Get_Position_Address:
    push af
    push bc
    ld a, b
    rla
    rla
    rla
    ld b, a
    ld a, c
    rla
    rla
    rla
    ld c, a
    call Get_Pixel_Address
    pop bc
    pop af
    ret

; Get screen address
;  B = Y pixel position
;  C = X pixel position
; Returns address in HL
;
Get_Pixel_Address:
    LD A,B          ; Calculate Y2,Y1,Y0
    AND %00000111   ; Mask out unwanted bits
    OR %01000000    ; Set base address of screen
    LD H,A          ; Store in H
    LD A,B          ; Calculate Y7,Y6
    RRA             ; Shift to position
    RRA
    RRA
    AND %00011000   ; Mask out unwanted bits
    OR H            ; OR with Y2,Y1,Y0
    LD H,A          ; Store in H
    LD A,B          ; Calculate Y5,Y4,Y3
    RLA             ; Shift to position
    RLA
    AND %11100000   ; Mask out unwanted bits
    LD L,A          ; Store in L
    LD A,C          ; Calculate X4,X3,X2,X1,X0
    RRA             ; Shift into position
    RRA
    RRA
    AND %00011111   ; Mask out unwanted bits
    OR L            ; OR with Y5,Y4,Y3
    LD L,A          ; Store in L
    RET
include "mapa.asm"

end $8000