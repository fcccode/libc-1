// ctype.h
#ifndef __CTYPE__
#define __CTYPE__

#ifdef __cplusplus
extern "C" {
#endif

/* Prototypes of the Standard C library ctype functions */

int isalnum(int);						// Checks whether the passed character is alphanumeric
int isalpha(int);						// Checks whether the passed character is alphabetic
int iscntrl(int);						// Checks whether the passed character is control character
int isdigit(int);						// Checks whether the passed character is decimal digit
int isgraph(int);						// Checks whether the passed character has graphical representation (Not a whitespace)
int islower(int);						// Checks whether the passed character is a lowercase letter
int isprint(int);						// Checks whether the passed character is printable
int ispunct(int);						// Checks whether the passed character is a punctuation character
int isspace(int);						// Checks whether the passed character is white-space
int isupper(int);						// Checks whether the passed character is an uppercase letter
int isxdigit(int);						// Checks whether the passed character is a hexadecimal digit
int tolower(int);						// This function converts uppercase letters to lowercase.
int toupper(int);						// This function converts lowercase letters to uppercase.

#ifdef __cplusplus
}
#endif

#endif // __CTYPE__