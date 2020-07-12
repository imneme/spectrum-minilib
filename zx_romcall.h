#ifndef ZX_ROMCALL_H_INCLUDED
#define ZXN_RPM3CALL_H_INCLUDED 1

void input_prepare();
char* input_line(char* prefill, unsigned short length) __z88dk_callee;
void input_finish();

void zx_rom_pr_string(char* addr, unsigned short length) __z88dk_callee;
void zx_rom_plot_sub(char x, char y) __z88dk_callee;
void zx_rom_beeper(unsigned short freqtime, unsigned short tstates) __z88dk_callee;
void zx_rom_cls();
void zx_rom_cls_lower();
void zx_rom_set_min();
char zx_rom_wait_key();
void zx_rom_chan_open(char c) __z88dk_fastcall;
char* zx_rom_bc_spaces(unsigned short size) __z88dk_fastcall;
void zx_rom_pause_1(unsigned short frames) __z88dk_fastcall;
short zx_rom_editor(short (*handler)()) __z88dk_fastcall;
unsigned short zx_rom_test_room(unsigned short space) __z88dk_fastcall;

#endif /* ZX_ROMCALL_H_INCLUDED */
