	INCLUDE "romdefs.inc"
	
	SECTION code_clib
	GLOBAL _zx_rom_chan_open

_zx_rom_chan_open:
	ld      a, l
	jp      ROM3_CHAN_OPEN
