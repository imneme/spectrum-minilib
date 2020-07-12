	include "romdefs.inc"

	SECTION data_clib

	GLOBAL _zxn_window_channel
	
_zxn_window_channel:
	defw    0
	
	SECTION code_clib
	GLOBAL crt_zxn_init

err_die:
	rst     $08
	db      ERR_J_INVIO

crt_zxn_init:

	ld      de, IDE_MODE
	ld      a,1
	exx
	ld      bc, $0102
	exx
	ld      c, 7
	rst     $08
	db      M_P3DOS
	jr      nc, err_die

	exx
	ld      (_zxn_window_channel), hl
	exx

	ret

