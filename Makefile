CC = zcc +zx -s -m  -SO3 -clib=sdcc_ix --reserve-regs-iy -pragma-define:CRT_ZX_INIT=1 -I.
CC_ZXN = zcc +zxn -s -m  -SO3 -clib=sdcc_ix --reserve-regs-iy -pragma-define:CRT_ZXN_INIT=1 -I.

MINILIB_OBJS = call_with_errhandler.o jump_hl.o  \
		noshim.o printf.o putchar.o \
		putstr.o zx_rom_chan_open.o zx_rom_pr_string.o \
		zx_rom_beeper.o zx_rom_plot_sub.o zx_rom_bc_spaces.o \
		zx_rom_wait_key.o zx_rom_pause_1.o zx_rom_editor.o \
		zx_rom_test_room.o zx_input_line.o zxn_input_line.o \
		crt_zx_init.o crt_zxn_init.o getchar.o exit.o

TARGETS = mini.lib example-zx.tap example-zxn.tap

%.o: %.asm
	z80asm $<

all: $(TARGETS)

clean:
	rm -f $(TARGETS) $(MINILIB_OBJS)

example-zx.tap: example.c zx_romcall.h minilib.h mini.lib
	$(CC) -s -m $< -o example-zx \
		-lmini -startup=" -1" -zorg:32768 -create-app

example-zxn.tap: example.c zx_romcall.h minilib.h mini.lib
	$(CC_ZXN) -s -m $< -o example-zxn \
		-lmini -startup=" -1" -zorg:32768 -create-app

mini.lib: $(MINILIB_OBJS)
	z80asm --make-lib=$@ $^

call_with_errhandler.o: call_with_errhandler.asm
jump_hl.o: jump_hl.asm
noshim.o: noshim.asm
printf.o: printf.asm
putchar.o: putchar.asm
putstr.o: putstr.asm
zx_rom_chan_open.o: zx_rom_chan_open.asm
zx_rom_pr_string.o: zx_rom_pr_string.asm
zx_rom_plot_sub.o: zx_rom_plot_sub.asm
zx_rom_beeper.o: zx_rom_beeper.asm
zx_rom_bc_spaces.o: zx_rom_bc_spaces.asm
zx_rom_wait_key.o: zx_rom_wait_key.asm
zx_rom_pause_1.o: zx_rom_pause_1.asm
zx_rom_editor.o: zx_rom_editor.asm
zx_rom_test_room.o: zx_rom_test_room.asm
zx_input_line.o: zx_input_line.asm
zxn_input_line.o: zxn_input_line.asm
crt_zxn_init.o: crt_zxn_init.asm
crt_zx_init.o: crt_zx_init.asm
getchar.o: getchar.c
exit.o: exit.asm
