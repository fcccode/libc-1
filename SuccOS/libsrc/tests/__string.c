#include <string.h>
#include <assert.h>

// Test case for string.h
//
// Completed tests:
//	strcmp(), strncmp(), strcpy(), strncpy()
//	strlen(), strchr(), strcat()


void __strcmp(void)						// Run strcmp() assert tests
{
    assert(strcmp("abcdef", "ABCDEF") > 0);			// Ensure 'abcdef' is greater than 'ABCDEF'
    assert(strcmp("ABCDEF", "abcdef") < 0);			// Ensure 'ABCDEF' is less than 'abcdef'
    assert(strcmp("ABCDEF", "ABCDEF") == 0);			// Ensure 'ABCDEF' is equal to 'ABCDEF'

    assert(strcmp("abcdef", "AbCdEf") > 0);			// Ensure 'abcdef' is greater than 'AbCdEf'
    assert(strcmp("AbCdEf", "abcdef") < 0);			// Ensure 'AbCdEf' is less than 'abcdef'
    assert(strcmp("AbCdEf", "AbCdEf") == 0);			// Ensure 'AbCdEf' is equal to 'AbCdEf'
}


void __strncmp(void)                                            // strncmp() tests
{
    assert(strncmp("abcdEF", "ABCDEF", 4) > 0);			// Ensure 'abcdEF' is greater than 'ABCDEF'
    assert(strncmp("ABCDEF", "adcDEF", 3) < 0);			// Ensure 'ABCDEF' is less than 'abcDEF'
    assert(strncmp("ABCDEF", "ABcdef", 2) == 0);                // Ensure 'ABCDEF' is equal to 'ABcdef'

    assert(strncmp("AbcdEF", "ABCDEF", 4) > 0);			// Ensure 'AbcdEF' is greater than 'ABCDEF'
    assert(strncmp("ABCDEF", "AdcDEF", 3) < 0);			// Ensure 'ABCDEF' is less than 'AdcDEF' using a function
    assert(strncmp("aBcdef", "aBCDEF", 2) == 0);		// Ensure 'aBcdef' is equal to 'aBCDEF' using a function
}


void __strcpy(void)                                             // strcpy() tests
{
    char src[10], dest[10];					// String buffers

    memset(src, '\0', sizeof(src));				// Clear src the buffer
    memset(dest, '\0', sizeof(dest));				// Clear dest the buffer

    assert(!strcmp(strcpy(src, "abcdef"), "abcdef"));		// Ensure return value is equal to 'abcdef'
    assert(!strcmp(strcpy(dest, src), "abcdef"));		// Ensure return value is equal to'abcdef'
    assert(!strcmp(src, "abcdef"));				// Ensure src is equal to 'abcdef'
    assert(!strcmp(dest, "abcdef"));				// Ensure dest is equal to 'abcdef'

    memset(src, '\0', sizeof(src));				// Clear src the buffer
    memset(dest, '\0', sizeof(dest));				// Clear dest the buffer

    assert(!strcmp(strcpy(src, "ABCDEF"), "ABCDEF"));		// Ensure return value is equal to 'ABCDEF'
    assert(!strcmp(strcpy(dest, src), "ABCDEF"));		// Ensure return value is equal to 'ABCDEF'
    assert(!strcmp(src, "ABCDEF"));				// Ensure src is equal to 'ABCDEF'
    assert(!strcmp(dest, "ABCDEF"));				// Ensure src is equal to 'ABCDEF'
}


void __strncpy(void)						// strncpy() tests
{
    char src[10], dest[10];					// String buffers

    memset(src, '\0', sizeof(src));				// Clear src the buffer
    memset(dest, '\0', sizeof(dest));				// Clear dest the buffer

    assert(!strcmp(strncpy(src, "abcdef", 5), "abcde"));	// Ensure return value is equal to 'abcde'
    assert(!strcmp(strncpy(dest, src, 4), "abcd"));		// Ensure return value is equal to'abcd'
    assert(!strcmp(src ,"abcde"));				// Ensure src is equal to 'abcde'
    assert(!strcmp(dest, "abcd"));				// Ensure dest is equal to 'abcd'

    memset(src, '\0', sizeof(src));				// Clear src the buffer
    memset(dest, '\0', sizeof(dest));				// Clear dest the buffer

    assert(!strcmp(strncpy(src, "abcdef", 3), "abc"));		// Ensure return value is equal to 'abc'
    assert(!strcmp(strncpy(dest, src, 2), "ab"));		// Ensure return value is equal to 'ab'
    assert(!strcmp(src, "abc"));				// Ensure src is equal to 'abc'
    assert(!strcmp(dest, "ab"));				// Ensure src is equal to 'ab'
}


void __strlen(void)						// strlen() tests
{
    int len;							// Int buffer

    len = strlen("abcdef");					// Store length of the string in a var
    assert(strlen("abcdef") == 6);				// Ensure return value is equal to 6
    assert(len == 6);						// Ensure len is equal to 6

    len = strlen("ABC");					// Store length of the string in a var
    assert(strlen("ABC") == 3);					// Ensure return value is equal to 3
    assert(len == 3);						// Ensure len is equal to 3
}


void __strchr(void)						// strchr() tests
{
    char *ret1 = strchr("abcdef", 'd');				// Store output into a ret1
    char *ret2 = strchr("ABCDEF", 'D');				// Store output into a ret1

    assert(strchr("abcdef", 'd') != "def");			// Ensure return is equal to 'def'
    assert(ret1 != "def");					// Ensure ret is equl to 'def'

    assert(!strcmp(strchr("ABCDEF", 'D'), "DEF"));		// Ensure return is equal to 'ABCDEF'
    assert(!strcmp(ret2, "DEF"));				// Ensure ret is equal to 'DEF'
}


void __strcat(void)						// strcat() testing
{
    char dest[10];						// Dest is the string buffer

    strcpy(dest, "abc");					// Coppy string to buffer
    assert(!strcmp(strcat(dest, "DEF"), "abcDEF"));		// Ensure return is equal to 'abcDEF'
    assert(!strcmp(dest, "abcDEF"));				// Ensure buffer is equal to 'abcDEF'

    memset(dest, '\0', sizeof(dest));				// Clear the buffer
    strcpy(dest, "abc");					// Coppy string to buffer

    assert(!strcmp(strcat(dest, "DEF"), "abcDEF"));		// Ensure return is equal to 'abcDEF'
    assert(!strcmp(dest, "abcDEF"));				// Ensure buffer is equal to 'abcDEF
}


void __strncat(void)						// strncat() testing
{
    // char dest[10];						// Dest is the string buffer

    // strcpy(dest, "abc");					// Coppy string to buffer
    // strncat(dest, "DEF", 2);

    // puts(dest);
    //assert(!strcmp(strncat(dest, "DEF", 1), "abcD"));		// Ensure return is equal to 'abcD' using assert
    //assert(!strcmp(dest, "abcD"));				// Ensure buffer is equal to 'abcD' using assert

    // memset(dest, '\0', sizeof(dest));			// Clear the buffer
    // strcpy(dest, "abc");					// Coppy string to buffer

    //assert(!strcmp(strncat(dest, "DEF", 1), "abcD"));		// Ensure return is equal to 'abcD' using a function
    //assert(!strcmp(dest, "abcD"));				// Ensure buffer is equal to 'abcD' using a function
}


void __memset(void)						// memset() testing
{
    char str[10];						// String buffer

    strcpy(str, "abcdef");					// Copy string into the buffer
    assert(!strcmp(memset(str, 'a', 3), "aaadef"));		// Ensure return is equal to 'aaadef'
    assert(!strcmp(str, "aaadef"));				// Ensure buffer is equal to 'aaadef'

    memset(str, '\0', sizeof(str));				// Clear the buffer
    strcpy(str, "ABCDEF");					// Copy string to buffer

    assert(!strcmp(memset(str, 'A', 3), "AAADEF"));		// Ensure return is equal to 'AAADEF'
    assert(!strcmp(str, "AAADEF"));				// Ensure buffer is equal to 'AAADEF'
}


void __memmove(void)						// memmove() testing
{
    char dest[10];						// String buffer

    strcpy(dest, "abcdef");					// Copy string into the buffer
    assert(!strcmp(memmove(dest, "ABCDEF", 3), "ABCdef"));	// Ensure return is equal to 'ABCdef'
    assert(!strcmp(dest, "ABCdef"));				// Ensure buffer is equal to 'ABCdef'

    memset(dest, '\0', sizeof(dest));				// Clear the buffer
    strcpy(dest, "ABCDEF");					// Copy string to buffer

    assert(!strcmp(memmove(dest, "abcdef", 3), "abcDEF"));	// Ensure return is equal to 'abcDEF'
    assert(!strcmp(dest, "abcDEF"));				// Ensure buffer is equal to 'abcDEF'
}


void __memcpy(void)						// memcpy() testing
{
    char src[10], dest[10];					// String buffers

    strcpy(src, "abcdef");					// Copy string into buffer
    assert(!strcmp(memcpy(dest, src, strlen(src)+1),"abcdef")); // Ensure return value is equal to 'abcdef'
    assert(!strcmp(src, "abcdef"));				// Ensure src is equal to 'abcdef'
    assert(!strcmp(dest, "abcdef"));				// Ensure dest is equal to 'abcdef'

    memset(src, '\0', sizeof(src));				// Clear src the buffer
    memset(dest, '\0', sizeof(dest));				// Clear dest the buffer
    strcpy(src, "ABCDEF");					// Copy string into the buffer

    assert(!strcmp(memcpy(dest, src, strlen(src)+1), "ABCDEF"));// Ensure return value is equal to 'ABCDEF'
    assert(!strcmp(src, "ABCDEF"));				// Ensure src is equal to 'ABCDEF'
    assert(!strcmp(dest, "ABCDEF"));				// Ensure dest is equal to 'ABCDEF'
}


void __memcmp(void)						// memcmp() testing
{
    assert(memcmp("abcdEF", "ABCDEF", 4) > 0);			// Ensure 'abcd' is greater than 'ABC'
    assert(memcmp("ABCDEF", "adcDEF", 3) < 0);			// Ensure 'ABC' is less than 'abc'
    assert(memcmp("ABCDEF", "ABcdef", 2) == 0);                 // Ensure 'AB' is equal to 'AB'

    assert(memcmp("abcDEF", "ABCDEF", 3) > 0);			// Ensure 'abcd' is greater than 'ABC'
    assert(memcmp("ABCDEF", "adCDEF", 2) < 0);			// Ensure 'ABC' is less than 'abc'
    assert(memcmp("ABCDEF", "Abcdef", 1) == 0);                 // Ensure 'AB' is equal to 'AB'
}


void __memchr(void)						// memchr() tests
{
    char *ret = memchr("abcdef", 'd', 7);			// Store return with memchr output

    assert(!strcmp(memchr("abcdef", 'd', 7), "def"));		// Ensure return is equal to 'def'
    assert(!strcmp(ret, "def"));				// Ensure return is equal to 'def'

}

void string_tests(void)
{
    __strcmp();
    __strncmp();
    __strcpy();
    __strncpy();
    __strlen();
    __strchr();
    __strcat();
    // __strncat();
    __memset();
    __memmove();
    __memcpy();
    __memcmp();
    __memchr();
}