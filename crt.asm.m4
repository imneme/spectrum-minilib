	defc __crt_org_code = CRT_ORG_CODE

include "../crt_memory_model_z80.inc"

EXTERN _main
GLOBAL _start

SECTION CODE

SECTION code_crt_init

_start:

	exx
	push	hl
	push	iy
	exx

IFDEF CRT_ZX_INIT
	GLOBAL	crt_zx_init
	GLOBAL	_input_prepare
	GLOBAL	_input_line
	GLOBAL	_input_finish
	GLOBAL	_input_prompt
	EXTERN	zx_input_prepare
	EXTERN	zx_input_line
	EXTERN	zx_input_finish
	EXTERN	zx_input_prompt
	defc	_input_prepare = zx_input_prepare
	defc	_input_line    = zx_input_line
	defc	_input_finish  = zx_input_finish
	defc	_input_prompt  = zx_input_prompt
	call	crt_zx_init
ENDIF

IFDEF CRT_ZXN_INIT
	GLOBAL	crt_zxn_init
	GLOBAL	_input_prepare
	GLOBAL	_input_line
	GLOBAL	_input_finish
	EXTERN	zxn_input_prepare
	EXTERN	zxn_input_line
	EXTERN	zxn_input_finish
	defc	_input_prepare = zxn_input_prepare
	defc	_input_line    = zxn_input_line
	defc	_input_finish  = zxn_input_finish
	call	crt_zxn_init
ENDIF

SECTION code_crt_main

	GLOBAL	after_main

	call _main
after_main:
	ld      b,h
	ld	c,l
	exx
	pop	iy
	pop	hl
	exx
	ret

SECTION BSS_END

	GLOBAL	_beyond_end

_beyond_end: