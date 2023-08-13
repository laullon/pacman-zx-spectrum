build:
	pasmo --alocal --name pacman --tapbas main.asm pacman.tap pacman.symbol
	${HOME}/Downloads/b2t80s_osx -mode 48k -tap pacman.tap --debug

 


