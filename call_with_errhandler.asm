	SECTION code_clib
	GLOBAL _call_with_errhandler

SYSVAR_ERR_SP           equ     $5C3D
	
;;; On entry:   DE'=Routine to call, BC'=Error Hander
;;; On exit:    (whatever *either* the routine to call, *OR* the error handler
;;;             returns EXCEPT FOR BC, which is trashed -- generally we expect
;;;             results to be in HL or DEHL)
_call_with_errhandler:
	ld      hl, (SYSVAR_ERR_SP)     ; save the old error handler
	push    hl                      ;
	ld      hl, restore_err_sp      ; when we return from error handler,
	push    hl                      ; exit via restore_err_sp which will
					; restore it
	exx                             ; access our arguments
	push    bc                      ; push the error handler
	ld      (SYSVAR_ERR_SP), sp     ; install it
	call    jump_de_alt             ; call de after switching regs
	pop     bc                      ; discard our (unused) error handler
	pop     bc                      ; and retaddr that would take us here
restore_err_sp:
	pop     bc                      ; retrieve old error handler
	ld      (SYSVAR_ERR_SP), bc     ; install it
	ret

jump_de_alt:
	push    de                      ; where we're jumping to
	exx                             ; switch registers first
	ret                             ; whee, off we go
