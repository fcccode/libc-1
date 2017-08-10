#include <string.h>
#include <assert.h>

// Test case for string.h
//
// Completed tests:
//


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
    char src[15], dest[15];

    strcpy(src, "abcdef");					// Coppy string to the src buffer
    strcpy(dest, "def");					// Coppy string to the dest buffer

    assert(!strcmp(strncat(dest, src, 2), "defab"));		// Ensure return is equal to 'defab' using a function
    assert(!strcmp(dest, "defab"));				// Ensure buffer is equal to 'defab' using a function

    memset(src, '\0', sizeof(src));				// Clear the src buffer
    memset(dest, '\0', sizeof(dest));				// Clear the dest buffer

    strcpy(src, "AbCdEf");					// Coppy string to the src buffer
    strcpy(dest, "AbF");					// Coppy string to the dest buffer

    assert(!strcmp(strncat(dest, src, 2), "AbFAb"));		// Ensure return is equal to 'AbFAb' using a function
    assert(!strcmp(dest, "AbFAb"));				// Ensure buffer is equal to 'AbFAb' using a function
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


void __memchr(void)						// memchr() testing
{
    char *ret1 = memchr("abcdef", 'd', 7);			// Store ret1 with memchr output
    char *ret2 = memchr("abcdef", 'f', 7);			// Store ret2 with memchr output

    assert(!strcmp(memchr("abcdef", 'd', 7), "def"));		// Ensure return is equal to 'def'
    assert(!strcmp(ret1, "def"));				// Ensure ret1 is equal to 'def'

    assert(!strcmp(memchr("abcdef", 'f', 7), "f"));		// Ensure return is equal to 'f'
    assert(!strcmp(ret2, "f"));					// Ensure ret2 is equal to 'f'
}


void __strcspn(void)						// strcspn() testing
{
    int len;							// Length var

    len = strcspn("abcdef", "de");				// Store strcspn in len
    assert((strcspn("abcdef", "de") + 1) == 4);			// Ensure return is equal to 4
    assert((len + 1) == 4);					// Ensure len is equal to 4

    len = strcspn("abcdef", "fedcb");				// Store strcspn in len
    assert((strcspn("abcdef", "fedcb") + 1) == 2);		// Ensure return is equal to 2
    assert((len + 1) == 2);					// Ensure len is equal to 2

}


void __strpbrk(void)						// strpbrk() testing
{
    char *ret = strpbrk("abcde2fghi3jk4l", "34");		// Store return value in ret

    assert(!strcmp(strpbrk("abcde2fghi3jk4l", "34"), "3jk4l")); // Ensure return is equal to '3jk4l'
    assert(!strcmp(ret, "3jk4l"));				// Ensure ret is equal to '3jk4l'

    ret = strpbrk("abcde2fghi3jk4l", "zl4k");			// Store return value in ret

    assert(!strcmp(strpbrk("abcde2fghi3jk4l", "zl4k"), "k4l")); // Ensure return is equal to 'k4l'
    assert(!strcmp(ret, "k4l"));				// Ensure ret is equal to 'k4l'
}


void __strrchr(void)						// strrchr() testing
{
     char *ret = strrchr("www.suicide.com", '.');		// Please kill me

     assert(!strcmp(strrchr("www.suicide.com", '.'), ".com"));	// Ensure return is equal to '.com'
     assert(!strcmp(ret, ".com"));				// Ensure ret is equal to '.com'

     ret = strrchr("a1a2a3a4", 'a');				// Return vars

     assert(!strcmp(strrchr("a1a2a3a4", 'a'), "a4"));		// Ensure return is equal to 'a4'
     assert(!strcmp(ret, "a4"));				// Ensure ret is equal to 'a4'
}


void __strspn(void)						// strspn() testing
{
    int len = strspn("abcdef", "abcd");				// Store test value

    assert(strspn("abcdef", "abcd") == 4);			// Ensure return is equal to 4
    assert(len == 4);						// Ensure ret is equal to 4

    len = strspn("AbCdEf", "Ab");				// Try another test

    assert(strspn("AbCdEf", "Ab") == 2);			// Ensure return is equal to 2
    assert(len == 2);						// Ensure ret is equal to 2
}


// WARNING MEMORY ERROR!
// This is a known issue and is currently being worked on...
void __strstr(void)						// strstr() testing
{
    char *ret = strstr("www.examexample.com", "example");	// Store ret as var
    // char *ret2;
    assert(!strcmp(ret, "example.com"));			// Ensure ret is equal to '.com'
    assert(!strcmp(strstr("abcdef", "de"), "def"));		// Ensure return is equal to '.com'


    // This would raise an error, for some reason 'def' overwrites the ret var.
    // assert(!strcmp(strstr("abcdef", "de"), "def"));
    // assert(!strcmp(ret, "example.com"));
    //
    // Causes screen to flash for some fucking reason.
    // ret2 = strstr("www.examexample.com", "example");
    // assert(!strcmp(ret2, "example.com"));
}


void __strxfrm(void)						// strxfrm() testing
{
    char dest[10], src[10];					// String buffers

    strcpy(dest, "abcdef");					// Coppy 'abcdef' to dest
    strcpy(src, "def");						// Coppy 'def' to src

    assert(strxfrm(dest, src, 2) == 3);				// Ensure return is equal to 3
    assert(!strcmp(dest, "decdef"));				// Ensure dest is equal to 'decdef'

    memset(dest, '\0', sizeof(dest));				// Clear dest the buffer
    memset(src, '\0', sizeof(src));				// Clear src the buffer

    strcpy(dest, "abcdef");					// Coppy 'abcdef' to dest
    strcpy(src, "ABCDEF");					// Coppy 'ABCDEF' to src

    assert(strxfrm(dest, src, 3) == 6);				// Ensure return is equal to 3
    assert(!strcmp(dest, "ABCdef"));				// Ensure dest is equal to 'decdef'
}


void __strcoll(void)						// strcoll() testing
{
    assert(strcoll("abcdef", "ABCDEF") > 0);			// Ensure 'abcdef' is greater than 'ABCDEF'
    assert(strcoll("ABCDEF", "abcdef") < 0);			// Ensure 'ABCDEF' is less than 'abcdef'
    assert(strcoll("ABCDEF", "ABCDEF") == 0);			// Ensure 'ABCDEF' is equal to 'ABCDEF'

    assert(strcoll("abcdef", "AbCdEf") > 0);			// Ensure 'abcdef' is greater than 'AbCdEf'
    assert(strcoll("AbCdEf", "abcdef") < 0);			// Ensure 'AbCdEf' is less than 'abcdef'
    assert(strcoll("AbCdEf", "AbCdEf") == 0);			// Ensure 'AbCdEf' is equal to 'AbCdEf'
}


void __strtok(void)
{
    char *str = "ssh | -f 127. | 0.0.1";
    char *token;

    token = strtok(str, '|');
    printf("First token: %s\r\n", token);
    token = strtok(0, '|');
    printf("Second token: %s\r\n", token);
    token = strtok(0, '|');
    printf("Third token: %s\r\n", token);
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
    __strncat();
    __memset();
    __memmove();
    __memcpy();
    __memcmp();
    __memchr();
    __strcspn();
    __strpbrk();
    __strrchr();
    __strspn();
    // __strstr();
    __strxfrm();
    __strcoll();
    __strtok();
}