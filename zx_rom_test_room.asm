	INCLUDE "romdefs.inc"
	
	SECTION code_clib
	GLOBAL _zx_rom_test_room

_zx_rom_test_room:
	ld      b,h
	ld      c,l
	jp      ROM3_TEST_ROOM


