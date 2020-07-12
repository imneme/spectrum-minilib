	INCLUDE "romdefs.inc"
	
	SECTION code_clib
	GLOBAL _zx_rom_pause_1

_zx_rom_pause_1:
	ld      b,h
	ld      c,l
	jp      ROM3_PAUSE_1


