// stdio.h
#ifndef __STDIO__
#define __STDIO__

#ifndef NULL
#define NULL		((void *)0)		// Define NULL
#endif

#define FILENAME_MAX    11			// Define filename max length
#define BUFSIZ          4096			// Define buffsize
#define EOF		(-1)			// End of File or Error return code
#define FOPEN_MAX	(20)

typedef struct _iobuf
{
    char* _ptr;
    int	_cnt;
    char* _base;
    int	_flag;
    int	_file;
    int	_charbuf;
    int	_bufsiz;
    char* _tmpfname;
} FILE;

int printf(const char *format, ...);
int scanf(const char *format, ...);
int getchar(void);
char *gets(char *str);
int putchar(int c);
int puts(const char *str);

#endif // __STDIO__