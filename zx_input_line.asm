	include "romdefs.inc"

	GLOBAL  zx_input_prepare
	GLOBAL  zx_input_line
	GLOBAL  zx_input_finish
	GLOBAL  zx_input_prompt
	EXTERN  asm_strlen
	EXTERN  _call_with_errhandler
	EXTERN  _putstr
	
	SECTION data_clib

zx_input_prompt:
	dw      0
	
	SECTION code_clib

zx_input_prepare:
	ld      a,1
	call    ROM3_CHAN_OPEN
	call    ROM3_CLS_LOWER
	ld      (iy+IY_TV_FLAG),1
	ld      hl, (zx_input_prompt)
	ld      a,h
	or      l
	jp      nz, _putstr
	ret

zx_input_line:
	pop     af
	pop     hl
	pop     bc
	push    af
	push    ix
	push    hl
	push    bc
;                               ; string to fill buffer with
;       call    asm_strlen              ; note its length
;       push    hl
	ld      (iy), 0xff              ; clear any errors
	ld      hl,SYSVAR_FLAGX
	res     7,(hl)
	set     5,(hl)
	call    ROM3_SET_WORK           ; clear workspace
	pop     bc                      ; length
	inc     bc
	rst     $30
	pop     hl                      ; string
	push    de
	ldir
	ex      de,hl
	dec     hl
	ld      (hl),13
	ld      (SYSVAR_K_CUR),hl
	pop     de
	exx
	ld      de, do_edit
	ld      bc, fail_edit
	exx
	call    _call_with_errhandler
	pop     ix
	ret

do_edit:
	push    de
	call    ROM3_EDITOR
	ld      (iy+IY_K_CUR_hi),0

	call    ROM3_IN_CHAN_K
	jr      nz,not_chan_k
	call    ROM3_ED_COPY
	ld      bc,(SYSVAR_ECHO_E)
	call    ROM3_CL_SET
not_chan_k:
	ld      hl,SYSVAR_FLAGX
	res     5,(hl)
	pop     hl
	ret

fail_edit:
	ld      hl, 0
	ret
	
zx_input_finish:
	call ROM3_INPUT_1P
	call ROM3_SET_WORK
	ld a,2
	jp ROM3_CHAN_OPEN
