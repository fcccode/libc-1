// string.h
#ifndef __STRING__
#define __STRING__

#ifndef NULL
#define NULL			((void *)0)		// Define NULL
#endif

typedef unsigned int size_t;

int strchr(const char *str, int c);

int strcmp(const char *str1, const char *str2);					// Compaire two strings
int strncmp(const char *str1, const char *str2, size_t n);		// Compaire up to n chars in two strings
char *strcpy(char *dest, const char *src);					    // Coppies string to dest
char *strncpy(char *dest, const char *src, size_t n);			// Copies up to n chars in string
size_t strlen(const char *str1);								// Return the length of the string
#endif // __STRING__