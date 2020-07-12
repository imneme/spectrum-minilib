#include <stdlib.h>
#include <minilib.h>
#include <zx_romcall.h>
#include <string.h>


extern unsigned short zxn_window_channel;

int main()
{
#ifndef __ZXNEXT
    zx_rom_cls();
#endif
    zx_rom_chan_open(2);
#ifdef __ZXNEXT
    putchar(14);
#endif
#ifdef __SPECTRUM
    input_prompt = "Prompt> ";
#endif
    printf("ZX Spectrum Readline...\n\n");
    while (1) {
	char outputting = 0;
#ifndef __SPECTRUM
	putstr("Prompt> ");
#endif
	char c;
	do {
	    c = getchar();
	    if (!outputting) {
		putstr("You say: ");
		outputting = 1;
	    }
	    putchar(c);
	} while (c != '\n');
    }

    /* return 0; */
}
