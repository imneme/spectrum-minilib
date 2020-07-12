	INCLUDE "romdefs.inc"
	
	SECTION code_clib
	GLOBAL _zx_rom_plot_sub

_zx_rom_plot_sub:
	pop     af                      ; retaddr
	pop     bc                      ; yx
	push    af                      ; restore retaddr
	jp      ROM3_PLOT_SUB
