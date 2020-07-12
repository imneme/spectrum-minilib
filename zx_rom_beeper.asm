	INCLUDE "romdefs.inc"
	
	SECTION code_clib
	GLOBAL _zx_rom_beeper

_zx_rom_beeper:
	pop     af                      ; retaddr
	pop     de                      ; freqtime
	pop     hl                      ; tstates
	push    af                      ; restore retaddr
	push    ix
	call    ROM3_BEEPER
	pop     ix
	ret

