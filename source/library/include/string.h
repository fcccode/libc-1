// string.h
#ifndef __STRING__
#define __STRING__

#ifndef NULL
#define NULL			((void *)0)		// Define NULL
#endif

typedef unsigned int size_t;

#ifdef __cplusplus
extern "C" {
#endif

/* Prototypes of the Standard C library string functions */

void *memchr(const void*, int, size_t);					// Finds first occurance of a byte
int memcmp(const void*, const void*, size_t);			// Compares the first n bytes of str1 and str2
void *memcpy(void*, const void*, size_t);			    // Copies n characters from src to dest
void *memmove(void*, const void*, size_t);				// Another function to copy n characters from str2 to str1.
void *memset(void*, int, size_t);                       // Copies the character c to the first n characters of the string 
char *strcat(char*, const char*);						// Append string src to the string dest
char *strncat(char*, const char*, size_t);				// Append n chracters from string src to the string dest
char *strchr(const char*, int);							// Finds first occurance of a char
int strcmp(const char*, const char*);					// Compaire two strings
int strncmp(const char*, const char*, size_t);			// Compaire up to n chars in two strings
int strcoll(const char *str1, const char *str2);		// Compaire two strings [!] DOES NOT USE LC_COLLATE [!]   
char *strcpy(char*, const char*);						// Coppies string to dest
char *strncpy(char*, const char*, size_t);				//Copies up to n chars in string
// size_t strcspn(const char *str1, const char *str2);
// char *strerror(int errnum);
size_t strlen(const char*);								// Return the length of the string
// char *strpbrk(const char *str1, const char *str2);
// char *strrchr(const char *str, int c);
// size_t strspn(const char *str1, const char *str2);
// char *strstr(const char *haystack, const char *needle);
//char *strtok(char *str, const char *delim);
//size_t strxfrm(char *dest, const char *src, size_t n);

#ifdef __cplusplus
}
#endif

#endif // __STRING__