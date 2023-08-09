SPRITE_SIZE: equ 7

SPRITES:
    db 17, 15                       ; row , col
    db 3,1                          ; nFrames, aFrame
    dw pacman_1                     ; 1st frame
    db $46                          ; color

    db 8, 15       
    db 2,1          
    dw ghost_1     
    db $42

    db 10, 15       
    db 2,1          
    dw ghost_1     
    db $45

    db 10, 17       
    db 2,1          
    dw ghost_1     
    db $43

    db 10, 13       
    db 2,1          
    dw ghost_1     
    db $06

pacman_1:
    db %00111100
    db %01110110
    db %11111111
    db %11111111
    db %11111111
    db %11111111
    db %01111110
    db %00111100

pacman_2:
    db %00111100
    db %01110110
    db %11111111
    db %11111111
    db %11100000
    db %11111111
    db %01111110
    db %00111100

pacman_3:
    db %00111100
    db %01110110    
    db %11111111
    db %11111100
    db %11100000
    db %11111100
    db %01111110
    db %00111100

ghost_1:
    db %00111100
    db %01111110    
    db %11011011
    db %11111111
    db %11011011
    db %11100111
    db %11111111
    db %10101010

ghost_2:
    db %00111100
    db %01111110    
    db %11011011
    db %11111111
    db %11011011
    db %11100111
    db %11111111
    db %01010101

