	INCLUDE "romdefs.inc"
	
	SECTION code_clib
	GLOBAL _printf
	EXTERN _putstr
	EXTERN putchar_a

_printf:
	pop     bc
	pop     hl
print_loop:
	ld      a, (hl)
	or      a
	jr      z, printf_done
	inc     hl
	cp      '%'
	jr      nz, printf_printchar
	ld      a, (hl)
	inc     hl
	cp      '%'
	jr      z, print_percent
	pop     de
	cp      's'
	jr      z, print_string
	cp      'd'
	jr      z, print_signed
	cp      'u'
	jr      z, print_unsigned
	cp      'p'
	jr      z, print_unsigned
	cp      'c'
	jr      z, print_char
	jr      print_loop
print_percent:
	inc     hl
printf_printchar:
	call    putchar_a
	jr      print_loop
printf_done:
	push    bc
	ret
print_char:
	ld      a, e
	jr      printf_printchar
print_string:
	ex      de,hl
	call    _putstr
	ex      de,hl
	jr      print_loop
print_signed:
	bit     7,d
	jr      z, print_unsigned
	push    hl
	ld      hl, 0
	or      a
	sbc     hl, de
	ex      de, hl
	pop     hl
	ld      a, '-'
	rst     $10
print_unsigned:
	ex      de,hl
	push    bc
	push    de
	ld      e,0xff
	ld      bc,-10000
	call    ROM3_SP_NO
	ld      b,h
	ld      c,l
	call    ROM3_OUT_NUM_1
	pop     de
	pop     bc
	ex      de, hl
	jr      print_loop
