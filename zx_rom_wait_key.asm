	INCLUDE "romdefs.inc"
	
	SECTION code_clib
	GLOBAL _zx_rom_wait_key

_zx_rom_wait_key:
	push    ix
	call    ROM3_WAIT_KEY
	pop     ix
	ld      l,a
	ld      h,0
	ret

