#ifndef MINILIB_H_INCLUDED
#define MINILIB_H_INCLUDED 1

#define __STDIO_H__ -8080

extern const char* input_prompt;

void putchar(char c) __z88dk_fastcall;

void putstr(char *string) __z88dk_fastcall;
void printf(char *string, ...) __z88dk_callee;

short getchar();

short ungetchar(char c) __z88dk_fastcall;

#define fprintf(stream, ...) printf(__VA_ARGS__)
#define fputs(str, stream) putstr(str)
#define puts(str) do { putstr(str); putchar('\n'); } while (0)
#define getc(file) getchar()
#define ungetc(c, file) ungetchar(c)
typedef void* FILE;
#define stdin  0
#define stderr 0
#define feof(file) 0


#endif /* MINILIB_H_INCLUDED */

