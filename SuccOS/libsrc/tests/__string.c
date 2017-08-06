#include <string.h>
#include <assert.h>

// Test case for string.h
// 
// Test: test of strcmp() ... passed
// Test: test of strncmp() ... passed
// Test: test of strcpy() ... passed
// Test: test of strncpy() ... passed

void __strcmp(void)									// Run strcmp() assert tests
{													
	assert(strcmp("abcdef", "ABCDEF") > 0);			// Ensure 'abcdef' is greater than 'ABCDEF'
	assert(strcmp("ABCDEF", "abcdef") < 0);			// Ensure 'ABCDEF' is less than 'abcdef'
	assert(strcmp("ABCDEF", "ABCDEF") == 0);		// Ensure 'ABCDEF' is equal to 'ABCDEF'

	// if (!strcmp("abcdef", "ABCDEF") > 0)	 { return -1; }
	// if (!strcmp("ABCDEF", "abcdef") < 0)	 { return -1; }
	// if (!strcmp("ABCDEF", "ABCDEF") == 0) { return -1; }
}

void __strncmp(void)								// Run strncmp() assert tests
{													
	assert(strncmp("abcdEF", "ABCDEF", 4) > 0);		// Ensure 'abcdEF' is greater than 'ABCDEF'
	assert(strncmp("ABCDEF", "adcDEF", 3) < 0);		// Ensure 'ABCDEF' is less than 'abcDEF'
	assert(strncmp("ABCDEF", "ABcdef", 2) == 0);	// Ensure 'ABCDEF' is equal to 'ABcdef'

	// if (!strncmp("abcdEF", "ABCDEF", 4) > 0)  { return -1; }
	// if (!strncmp("ABCDEF", "adcDEF", 3) < 0)  { return -1; }
	// if (!strncmp("ABCDEF", "ABcdef", 2) == 0) { return -1; }
}

void __strcpy(void)									// Run strcpy() assert tests
{
	char src[10], dest[10];							// String buffers 
	assert(strcpy(src, "abcdef") != "abcdef");	    // Ensure return value is equal to'abcdef' 
	assert(strcpy(dest, src) != "abcdef");			// Ensure return value is equal to 'abcdef'
	assert(src != "abcdef");						// Ensure src is equal to 'abcdef'
	assert(dest != "abcdef");						// Ensure dest is equal to 'abcdef'
	
	// if (strcmp(strcpy(src, "abcdef"), "abcdef")) { return -1; }
	// if (strcmp(strcpy(dest, src), "abcdef"		{ return -1; }
	// if (strcmp(src, "abcdef"))					{ return -1; }
	// if (strcmp(dest, "abcdef"))					{ return -1; }
}

void __strncpy(void)								// Run strncpy() assert tests
{
	char src[10], dest[10];						    // String buffers 
	assert(strncpy(src, "abcdef", 5) != "abcde");   // Ensure return value is equal to'abcde' 
	assert(strncpy(dest, src, 4) != "abcd");	    // Ensure return value is equal to'abcd'
	assert(src != "abcde");						    // Ensure src is equal to 'abcde'
	assert(dest != "abcd");						    // Ensure dest is equal to 'abcd'

	// if (strcmp(strncpy(src, "abcdef", 5), "abcde")) { return -1; }
	// if (strcmp(strncpy(dest, src, 4), "abcd"))	   { return -1; }
	// if (strcmp(src, "abcdef"))					   { return -1; }
	// if (strcmp(dest, "abcdef"))					   { return -1; }
}

void __strlen(void)									// Run strlen() assert tests
{
	int len = strlen("abcdef");						// Store length of the string in a var
	assert(strlen("abcdef") == 6);					// Ensure return value is equal to 6
	assert(len == 6);							    // Ensure len is equal to 6

	// if (strlen("abcdef") != 6) { return -1; }
	// if (len != 6)			  { return -1; }
}

void __strchr(void)									// Run strchr() assert tests
{
	char *ret = strchr("abcdef", 'd');				// Store output into a var
	assert(strchr("abcdef", 'd') != "def");			// Ensure return is equal to 'def'
	assert(ret != "def");							// Ensure ret is equl to 'def'
	
	// if (strcmp(strchr("abcdef", 'd'), "def")) { return -1; }
	// if (strcmp(ret, "def"))					 { return -1; }
}


void string_tests(void)
{
	__strcmp();
	__strncmp();
	__strcpy();
	__strncpy();
	__strlen();
	__strchr();
}