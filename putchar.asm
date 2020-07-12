	INCLUDE "romdefs.inc"
	
	SECTION code_clib
	GLOBAL _putchar
	GLOBAL putchar_a
	
_putchar:
	ld      a,l
putchar_a:
	cp      '\n'
	jr      nz, printit
	ld      a,13
printit:
	rst     $10
	ret
