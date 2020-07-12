	INCLUDE "romdefs.inc"
	
	SECTION code_clib
	GLOBAL _putstr
	EXTERN putchar_a

_putstr:
	ld      a, (hl)
	or      a
	ret     z
	inc     hl
	call    putchar_a
	jr      _putstr
