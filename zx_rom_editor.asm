	INCLUDE "romdefs.inc"
	
	SECTION code_clib
	GLOBAL _zx_rom_editor
	EXTERN _call_with_errhandler
	
_zx_rom_editor:
	push    hl
	exx
	ld      de, call_editor
	pop     bc
	exx
	push    ix
	call    _call_with_errhandler
	pop     ix
	ret

call_editor:
	call    ROM3_EDITOR
	ld      hl,0
	ret
