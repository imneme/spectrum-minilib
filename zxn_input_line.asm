	include "romdefs.inc"

	GLOBAL  zxn_input_prepare
	GLOBAL  zxn_input_line
	GLOBAL  zxn_input_finish
	GLOBAL  _input_size
	EXTERN  _call_with_errhandler
	EXTERN  _zxn_window_channel

	SECTION data_clib
_input_size:
	defb    0
_input_buffer:
	defw    0
	
	SECTION code_clib
	
zxn_input_prepare:
	ld      hl, -384
	add     hl, sp
	ld      a, h
	cp      $c0
	jr      nc, other_end
set_buffer:
	ld      (_input_buffer), hl
	ret
other_end:
	ld      hl, (SYSVAR_STKEND)
	jr      set_buffer

;;      ld      bc, 0x100
;;      rst     $30     ; make BC spaces, DE = start
;;      ld      (_input_buffer), de
;;      ret

	
;; dummy:
;;      defb    "wow-fun", '\r'
;;      defs    256

;;      GLOBAL  _printf
;; wtf: defb    "input buffer = %u, BC = %u\n\0"
	
zxn_input_line:
	;;  stack: length, str-addr, retaddr
	pop     af      ; return address
	pop     hl      ; prefill string, start
	pop     bc      ; and length
	push    af      ; restore return address

;;      push    hl
;;      push    bc

;;      push    bc
;;      ld      hl, (_input_buffer)
;;      push    hl
;;      ld      hl, wtf
;;      push    hl
;;      call    _printf

;;      pop     bc
;;      pop     hl
	
	;;  stack: retaddr
	push    ix      ; save IX for caller
	;;  stack: retaddr, ix

	ld      de,(SYSVAR_CURCHL)      ; save current channel
	push    de                      ; ...
	;; stack: retaddr, ix, curchl
	ld      de,(_zxn_window_channel)        ; set current channel to magic window
	ld      (SYSVAR_CURCHL), de     ;
	
	ld      de, (_input_buffer)
	push    bc
	push    de
	inc     bc
	ldir
	exx
	ld      a, 255
	;; stack: retaddr, ix, curchl, length, buff-addr
;       ldir
	pop     hl
	pop     de
	; ld    e,4
	push    hl
	;; stack: retaddr, ix, curchl, buff-addr
	exx
	ld      de, IDE_WINDOW_LINEIN
	ld      c, 7
	rst     $08
	defb    M_P3DOS

	pop     hl
	push    hl

	ld      a,e
	ld      (_input_size),a
	ld      d,0
	add     hl,de
	ld      (hl),'\r'
	
	pop     hl
	pop     bc
	ld      (SYSVAR_CURCHL), bc     ; restore original channel
	ld      bc, 0xfefe
	in      b, (c)
	pop     ix                      ; restore ix for caller
	bit     0,b
	jr      nz, good_exit
	ld      hl, 0
	ld      b,e
	inc     b
	jr      start_loop
del_loop:
	ld      a,12
	rst     $10
start_loop:
	djnz    del_loop
	ret
good_exit:
	ld      a, '\r'
	rst     $10
	ret

;; z_zxn_input_line:
;;      ;; stack: length, str-addr, retaddr
;;      pop     af                      ; return address
;;      pop     hl                      ; prefill string, start
;;      pop     bc                      ; and length
;;      push    af                      ; restore return address
;;      ;; stack: retaddr
;;      push    ix                      ; save IX for caller
;;      ;; stack: retaddr, ix
;;      ld      de,(SYSVAR_CURCHL)      ; save current channel
;;      push    de                      ; ...
;;      ;; stack: retaddr, ix, curchl
;;      ld      de,(_zxn_window_channel)        ; set current channel to magic window
;;      ld      (SYSVAR_CURCHL), de     ;
;;      push    bc
;;      push    hl
;;      ;; stack: retaddr, ix, curchl, length, str-addr
	
;; ;;   push    bc
;; ;;   ld      (iy), 0xff              ; clear any errors
;; ;;   ld      hl,SYSVAR_FLAGX
;; ;;   res     7,(hl)
;; ;;   set     5,(hl)
;; ;;   call    ROM3_SET_WORK           ; clear workspace
;; ;;   pop     bc                      ; length

;;      ld      bc, 0x100
;;      rst     $30                     ; make BC spaces, DE = start
;;      ;; stack: retaddr, ix, curchl, length, str-addr
;;      pop     hl                      ; and start
;;      ;; stack: retaddr, ix, curchl, length
;;      pop     bc
;;      push    bc
;;      ;; stack: retaddr, ix, curchl, length
;;      inc     bc                      ; avoid zero copy
;;      push    de                      ; save start address for later
;;      ;; stack: retaddr, ix, curchl, length, buff-addr
;;      ldir                            ; copy over
;;      ex      de,hl
;;      dec     hl                      ; nicely terminate with return, just
;;      ld      (hl),13                 ; in case

;;      exx
;;      ld      a, 255
;;      ;; stack: retaddr, ix, curchl, length, buff-addr
;;      pop     hl
;;      pop     de
;;      push    hl
;;      ;; stack: retaddr, ix, curchl, buff-addr
;;      exx
;;      ld      de, IDE_WINDOW_LINEIN
;;      ld      c, 7
;;      rst     $08
;;      defb    M_P3DOS
;;      pop     hl
;;      push    hl
;;      ;; stack: retaddr, ix, curchl, buff-addr
;;      ld      a,e
;;      ld      (_input_size),a
;;      ld      d,0
;;      add     hl,de
;;      ld      (hl),'\r'
;;      pop     hl
;;      ;; stack: retaddr, ix, curchl

;;      pop     bc
;;      ld      (SYSVAR_CURCHL), bc     ; restore original channel
;;      pop     ix                      ; restore ix for caller
;;      ret

zxn_input_finish:
;;      ld      hl, (_input_buffer)
;;      ld      bc, 0x100
;;      call    ROM3_RECLAIM_2
;;      ld      hl, 0
;;      ld      (_input_buffer), hl
	ret


