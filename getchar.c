#include <zx_romcall.h>
#include <minilib.h>
#include <string.h>

char buffer[256] = "\r";
char* buffptr = buffer+1;
char* buffend = buffer+1;

short ungetchar(char c) __z88dk_fastcall
{
    if (buffptr == buffer)
	return -1;
    --buffptr;
    *buffptr=c;
    return c;
}

short getchar()
{
    if (buffptr == buffend) {
	input_prepare();
	char* line = input_line(0, 0);
	while (!line) {
	    line = input_line(buffer,buffend-buffer-1);
	}
	input_finish();
	char* end = strchr(line, '\r');
	unsigned short length = end - line;
	memcpy(buffer, line, length);
	buffptr = buffer;
	buffend = buffptr + length;
	*buffend++ = '\n';
    }
    return *buffptr++;
}
