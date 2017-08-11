#include <ctype.h>
#include <assert.h>
#include <stdio.h>

void __isalnum(void)
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


void __isalpha(void)
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


void __iscntrl(void)
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


void __isdigit(void)
{
    int i, ret;
    for (i = 0; i <= 256; i++)
    {
	ret = isdigit(i);
	if (i >= 48 && i <= 57) assert(ret);			// Digits
	else assert(!ret);
    }
}


void __isgraph(void)
{
    int i, ret;
    for (i = 0; i <= 256; i++)
    {
	ret = isgraph(i);
	if (i >= 33 && i <= 126) assert(ret);			// Printable?
	else assert(!ret);
    }
}


void __islower(void)
{
    int i, ret;
    for (i = 0; i <= 256; i++)
    {
	ret = islower(i);
	if (i >= 97 && i <= 122) assert(ret);			// Lowercase chars
	else assert(!ret);
    }
}
void __isprint(void)
{
    int i, ret;
    for (i = 0; i <= 256; i++)
    {
	ret = isprint(i);
	if (i >= 32 && i <= 126) assert(ret);			// Printable?
	else assert(!ret);
    }
}


void __ispunct(void)
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


}void ctype_tests(void)
{
    __isalnum();
    __isalpha();
    __iscntrl();
    __isdigit();
    __isgraph();
    __islower();
    __isprint();
    __ispunct();
}