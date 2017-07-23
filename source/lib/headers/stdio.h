// stdio.h
#ifndef __STDIO__
#define __STDIO__
int strcmp(const char *str1, const char *str2);

int printf(const char *format, ...);	// 22 WIP
int scanf(const char *format, ...);		// 28 WIP
int getchar(void);						// 35
char *gets(char *str);					// 36
int putchar(int c);						// 38
int puts(const char *str);				// 39

#define FILENAME_MAX    11				// Define filename max length
#define BUFSIZ          4096			// Define buffsize
#define NULL			((void *)0)		// Define NULL
#define EOF				(-1)            // End of File or Error return code

#endif // __STDIO__