// ctype.h
#ifndef __CTYPE__
#define __CTYPE__

#ifdef __cplusplus
extern "C" {
#endif

/* Prototypes of the Standard C library ctype functions */

int isalnum(int c);						// Checks whether the passed character is alphanumeric
int isalpha(int c);						// Checks whether the passed character is alphabetic
int iscntrl(int c);						// Checks whether the passed character is control character
int isdigit(int c);						// Checks whether the passed character is decimal digit
int isgraph(int c);						// Checks whether the passed character has graphical representation (Not a whitespace)
int islower(int c);						// Checks whether the passed character is a lowercase letter
int isprint(int c);						// Checks whether the passed character is printable
int ispunct(int c);						// Checks whether the passed character is a punctuation character
int isspace(int c);						// Checks whether the passed character is white-space
int isupper(int c);						// Checks whether the passed character is an uppercase letter
int isxdigit(int c);						// Checks whether the passed character is a hexadecimal digit
int tolower(int c);						// This function converts uppercase letters to lowercase.
int toupper(int c);						// This function converts lowercase letters to uppercase.

#ifdef __cplusplus
}
#endif

#endif // __CTYPE__