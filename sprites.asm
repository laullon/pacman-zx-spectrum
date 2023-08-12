pacman:
    db 17, 15                       ; 0 1 row , col
    db 4,1                          ; 2 3 nFrames, aFrame
    db 0                            ; 4   next frame ofs
    dw pacman_                      ; 5 6 1st frame
    db $46                          ; 7   color

blinky:
    db 8, 15       
    db 2,1          
    db 0
    dw ghost     
    db $42

inky:
    db 10, 15       
    db 2,1          
    db 0
    dw ghost     
    db $45

pinky:
    db 10, 17       
    db 2,1          
    db 0
    dw ghost     
    db $43

clyde:
    db 10, 13       
    db 2,1          
    db 0
    dw ghost     
    db $06

pacman_:
    db %00111100
    db %01110110
    db %11111111
    db %11111111
    db %11111111
    db %11111111
    db %01111110
    db %00111100

    db %00111100
    db %01110110
    db %11111111
    db %11111111
    db %11100000
    db %11111111
    db %01111110
    db %00111100

    db %00111100
    db %01110110    
    db %11111111
    db %11111100
    db %11100000
    db %11111100
    db %01111110
    db %00111100

    db %00111100
    db %01110110
    db %11111111
    db %11111111
    db %11100000
    db %11111111
    db %01111110
    db %00111100

ghost:
    db %00111100
    db %01111110    
    db %11011011
    db %11111111
    db %11011011
    db %11100111
    db %11111111
    db %10101010

    db %00111100
    db %01111110    
    db %11011011
    db %11111111
    db %11011011
    db %11100111
    db %11111111
    db %01010101

dot:
    db %00000000
    db %00000000
    db %00000000
    db %00011000
    db %00011000
    db %00000000
    db %00000000
    db %00000000

power:
    db %00000000
    db %00000000
    db %00011000
    db %00111100
    db %00111100
    db %00011000
    db %00000000
    db %00000000

empty:
    db 0,0,0,0,0,0,0,0