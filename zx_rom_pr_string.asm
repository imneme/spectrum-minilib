	INCLUDE "romdefs.inc"
	
	SECTION code_clib
	GLOBAL _zx_rom_pr_string

_zx_rom_pr_string:
	pop     af                      ; retaddr
	pop     de                      ; address
	pop     bc                      ; length
	push    af                      ; restore retaddr
	jp      ROM3_PR_STRING
