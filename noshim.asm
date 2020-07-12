	INCLUDE "romdefs.inc"
	
	SECTION code_clib
	GLOBAL _zx_rom_cls
	GLOBAL _zx_rom_cls_lower
	GLOBAL _zx_rom_set_min
	
	defc _zx_rom_cls        = ROM3_CLS
	defc _zx_rom_cls_lower  = ROM3_CLS_LOWER
	defc _zx_rom_set_min    = ROM3_SET_MIN
