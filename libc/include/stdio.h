// stdio.h
#ifndef __STDIO__
#define __STDIO__

#ifndef NULL
#define NULL		((void *)0)		// Define NULL
#endif

#define FILENAME_MAX    11			// Define filename max length
#define EOF		(-1)			// End of File or Error return code
#define FOPEN_MAX	(20)

//void outp(unsigned char, unsigned char);
//void outportp(unsigned char, unsigned char);
//void outp(unsigned short, unsigned short);
//void outportw(unsigned short, unsigned short);
//void pause() { _asm xchg bx, bx };

int rename(const char*, const char*);		// Causes the filename to be changed
int printf(const char *format, ...);
int scanf(const char *format, ...);
int getchar(void);
char *gets(char *str);
int putchar(int c);
int puts(const char *str);


#endif // __STDIO__