// string.h
#ifndef __STRING__
#define __STRING__

#ifndef NULL
#define NULL ((void *)0)
#endif

#ifndef _SIZE_T_DEFINED
#define _SIZE_T_DEFINED
typedef unsigned int size_t;
#endif

#ifdef __cplusplus
extern "C" {
#endif

/* Prototypes of the Standard C library string functions */

void *memchr(const void*, int, size_t);				// Finds first occurance of a byte
int memcmp(const void*, const void*, size_t);			// Compares the first n bytes of str1 and str2
void *memcpy(void*, const void*, size_t);			// Copies n characters from src to dest
void *memmove(void*, const void*, size_t);			// Another function to copy n characters from str2 to str1.
void *memset(void*, int, size_t);				// Copies the character c to the first n characters of the string
char *strcat(char*, const char*);				// Append string src to the string dest
char *strncat(char*, const char*, size_t);			// Append n chracters from string src to the string dest
char *strchr(const char*, int);					// Finds first occurance of a char
int strcmp(const char* , const char*);				// Compaire two strings
int strncmp(const char*, const char*, size_t);			// Compaire up to n chars in two strings
int strcoll(const char *, const char*);				// Compaire two strings [!] DOES NOT USE LC_COLLATE [!]
char *strcpy(char*, const char*);				// Coppies string to dest
char *strncpy(char*, const char*, size_t);			// Copies up to n chars in string
size_t strcspn(const char*, const char*);			// Length of str1 but entirely of characters not in str2
// char *strerror(int errnum);					//
size_t strlen(const char*);					// Return the length of the string
char *strpbrk(const char*, const char*);			// Finds first char in str1 that matches any char in str2
char *strrchr(const char*, int);				// Finds last occurrence of char c in the string
size_t strspn(const char*, const char*);			// Finds the length of the start of str1 which consists entirely of chars in str2
char *strstr(const char*, const char*);				// Finds first occurance of an entire string in a larger string set
char *strtok(char*, const char);				//
size_t strxfrm(char*, const char*, size_t);			// Transforms the first n chars of src into locale and puts them into the dest

#ifdef __cplusplus
}
#endif

#endif // __STRING__