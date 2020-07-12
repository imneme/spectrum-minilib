	INCLUDE "romdefs.inc"
	
	SECTION code_clib
	GLOBAL _zx_rom_bc_spaces

_zx_rom_bc_spaces:
	ld      b,h
	ld      c,l
	rst     $30
	ex      de,hl
	ret

