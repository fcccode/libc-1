#include <ctype.h>
#include <assert.h>
#include <stdio.h>


void __isalnum(void)						// isalnum() testing
{
    int i, ret;
    for (i = 0; i <= 256; i++)
    {
	ret = isalnum(i);
	if (i >= 48 && i <= 57) assert(ret);			// Digits
	else if (i >= 65 && i <= 90) assert(ret);		// Uppercase chars
	else if (i >= 97 && i <= 122) assert(ret);		// Lowercase chars
	else assert(!ret);
    }
}


void __isalpha(void)						// isalpha() testing
{
    int i, ret;
    for (i = 0; i <= 256; i++)
    {
	ret = isalpha(i);
	if (i >= 65 && i <= 90) assert(ret);			// Uppercase chars
	else if (i >= 97 && i <= 122) assert(ret);		// Lowercase chars
	else assert(!ret);
    }
}


void __iscntrl(void)						// iscntrl() testing
{
    int i, ret;
    for (i = 0; i <= 256; i++)
    {
	ret = iscntrl(i);
	if (i >= 0 && i <= 31) assert(ret);			// Control characters
	else if (i == 127 || i == 256) assert(ret);		// Control characters
	else assert(!ret);
    }
}


void __isdigit(void)						// isdigit() testing
{
    int i, ret;
    for (i = 0; i <= 256; i++)
    {
	ret = isdigit(i);
	if (i >= 48 && i <= 57) assert(ret);			// Digits
	else assert(!ret);
    }
}


void __isgraph(void)						// isgraph() testing
{
    int i, ret;
    for (i = 0; i <= 256; i++)
    {
	ret = isgraph(i);
	if (i >= 33 && i <= 126) assert(ret);			// Printable?
	else assert(!ret);
    }
}


void __islower(void)						// islower() testing
{
    int i, ret;
    for (i = 0; i <= 256; i++)
    {
	ret = islower(i);
	if (i >= 97 && i <= 122) assert(ret);			// Lowercase chars
	else assert(!ret);
    }
}
void __isprint(void)						// isprint() testing
{
    int i, ret;
    for (i = 0; i <= 256; i++)
    {
	ret = isprint(i);
	if (i >= 32 && i <= 126) assert(ret);			// Printable?
	else assert(!ret);
    }
}


void __ispunct(void)						// ispunct() testing
{
    int i, ret;
    for (i = 0; i <= 256; i++)
    {
	ret = ispunct(i);
	if (i >= 33 && i <= 47) assert(ret);			// Punctuation?
	else if (i >= 58 && i <= 64) assert(ret);		// Punctuation?
	else if (i >= 91 && i <= 96) assert(ret);		// Punctuation?
	else if (i >= 123 && i <= 126) assert(ret);		// Punctuation?
	else assert(!ret);
    }
}


void __isspace(void)						// isspace() testing
{
    int i, ret;
    for (i = 0; i <= 256; i++)
    {
	ret = isspace(i);
	if (i >= 9 && i <= 13) assert(ret);			// White space?
	else if (i == 32) assert(ret);				// White space?
	else assert(!ret);
    }
}


void __isupper(void)						// isupper() testing
{
    int i, ret;
    for (i = 0; i <= 256; i++)
    {
	ret = isupper(i);
	if (i >= 65 && i <= 90) assert(ret);			// Uppercase?
	else assert(!ret);
    }
}


void __isxdigit(void)						// isxdigit() testing
{
    int i, ret;
    for (i = 0; i <= 256; i++)
    {
	ret = isxdigit(i);
	if (i >= 48 && i <= 57) assert(ret);			// Hexadecimal?
	else if (i >= 65 && i <= 70) assert(ret);		// Hexadecimal?
	else if (i >= 97 && i <= 102) assert(ret);		// Hexadecimal?
	else assert(!ret);
    }
}


void __tolower(void)						// tolower() testing
{
    int i;
    for (i = 0; i <= 256; i++)
    {
	if (isupper(i)) assert(islower(tolower(i)));		// Convert to lower
    }
}


void __toupper(void)						// toupper() testing
{
    int i;
    for (i = 0; i <= 256; i++)
    {
	if (islower(i)) assert(isupper(toupper(i)));		// Convert to upper
    }
}


void ctype_tests(void)
{
    __isalnum();
    __isalpha();
    __iscntrl();
    __isdigit();
    __isgraph();
    __islower();
    __isprint();
    __ispunct();
    __isspace();
    __isupper();
    __isxdigit();
    __tolower();
    __toupper();
}