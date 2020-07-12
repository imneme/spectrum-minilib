	EXTERN  after_main
	GLOBAL  _exit_fastcall
	GLOBAL  entry_sp
	
	SECTION data_clib
entry_sp:
	dw      0

	SECTION code_crt_init

exit_store_stack:
	ld      hl, 0
	add     hl, sp
	ld      (entry_sp), hl

	SECTION code_clib
_exit:
	pop     af
	pop     hl
_exit_fastcall:
	ld      sp, (entry_sp)
	jp      after_main
