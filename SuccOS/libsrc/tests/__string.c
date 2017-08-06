#include <string.h>
#include <assert.h>

// Test case for string.h
// 
// Completed tests:
//		strcmp(), strncmp(), strcpy(), strncpy()
//		strlen(), strchr(), strcat()

void __strcmp(void)										// Run strcmp() assert tests
{													
	assert(strcmp("abcdef", "ABCDEF") > 0);				// Ensure 'abcdef' is greater than 'ABCDEF'	using assert
	assert(strcmp("ABCDEF", "abcdef") < 0);				// Ensure 'ABCDEF' is less than 'abcdef' using assert
	assert(strcmp("ABCDEF", "ABCDEF") == 0);			// Ensure 'ABCDEF' is equal to 'ABCDEF'	using assert

	if (!strcmp("abcdef", "ABCDEF") > 0)				// Ensure 'abcdef' is greater than 'ABCDEF'	using a function 
		_assert("Function Error", __FILE__, __LINE__);

	if (!strcmp("ABCDEF", "abcdef") < 0)			    // Ensure 'ABCDEF' is less than 'abcdef' using a function 
		_assert("Function Error", __FILE__, __LINE__);

	if (strcmp("ABCDEF", "ABCDEF") != 0) 			    // Ensure 'ABCDEF' is equal to 'ABCDEF'	using a function 
		_assert("Function Error", __FILE__, __LINE__);
}


void __strncmp(void)									// strncmp() tests
{													
	assert(strncmp("abcdEF", "ABCDEF", 4) > 0);			// Ensure 'abcdEF' is greater than 'ABCDEF'	using assert 
	assert(strncmp("ABCDEF", "adcDEF", 3) < 0);			// Ensure 'ABCDEF' is less than 'abcDEF' using assert 
	assert(strncmp("ABCDEF", "ABcdef", 2) == 0);		// Ensure 'ABCDEF' is equal to 'ABcdef' using assert 

	if (!strncmp("abcdEF", "ABCDEF", 4) > 0) 		    // Ensure 'abcdEF' is greater than 'ABCDEF'	using a function 
		_assert("Function Error", __FILE__, __LINE__);

	if (!strncmp("ABCDEF", "adcDEF", 3) < 0)		    // Ensure 'ABCDEF' is less than 'abcDEF' using a function 
		_assert("Function Error", __FILE__, __LINE__);

	if (strncmp("ABCDEF", "ABcdef", 2) != 0)		    // Ensure 'ABCDEF' is equal to 'ABcdef' using a function 
		_assert("Function Error", __FILE__, __LINE__);
}


void __strcpy(void)										// strcpy() tests
{
	char src[10], dest[10];								// String buffers

	assert(strcpy(src, "abcdef") != "abcdef");			// Ensure return value is equal to 'abcdef' using assert  
	assert(strcpy(dest, src) != "abcdef");				// Ensure return value is equal to 'abcdef' using assert 
	assert(src != "abcdef");							// Ensure src is equal to 'abcdef' using assert 
	assert(dest != "abcdef");							// Ensure dest is equal to 'abcdef' using assert 
	
	memset(src, '\0', sizeof(src));						// Clear src the buffer 
	memset(dest, '\0', sizeof(dest));					// Clear dest the buffer 

	if (strcmp(strcpy(src, "abcdef"), "abcdef") != 0)   // Ensure return value is equal to'abcdef' using a function 
		_assert("Function Error", __FILE__, __LINE__);
	
	if (strcmp(strcpy(dest, src), "abcdef") != 0)	 	// Ensure return value is equal to 'abcdef' using a function
		_assert("Function Error", __FILE__, __LINE__);
	
	if (strcmp(src, "abcdef") != 0)					    // Ensure src is equal to 'abcdef' using a function
		_assert("Function Error", __FILE__, __LINE__);

	if (strcmp(dest, "abcdef") != 0)					// Ensure dest is equal to 'abcdef' using a function 
		_assert("Function Error", __FILE__, __LINE__);
}


void __strncpy(void)									// strncpy() tests
{
	char src[10], dest[10];								// String buffers 
	
	assert(strncpy(src, "abcdef", 5) != "abcde");		// Ensure return value is equal to'abcde' using assert 
	assert(strncpy(dest, src, 4) != "abcd");			// Ensure return value is equal to'abcd' using assert
	assert(src != "abcde");								// Ensure src is equal to 'abcde' using assert
	assert(dest != "abcd");								// Ensure dest is equal to 'abcd' using assert

	memset(src, '\0', sizeof(src));						// Clear src the buffer 
	memset(dest, '\0', sizeof(dest));					// Clear dest the buffer 

	if (strcmp(strncpy(src, "abcdef", 5), "abcde") != 0)// Ensure return value is equal to 'abcde' using a function
		_assert("Function Error", __FILE__, __LINE__);

	if (strcmp(strncpy(dest, src, 4), "abcd") != 0)		// Ensure return value is equal to 'abcd' using a function
		_assert("Function Error", __FILE__, __LINE__);  

	if (strcmp(src, "abcde") != 0)	
		_assert("Function Error", __FILE__, __LINE__); // Ensure src is equal to 'abcde' using a function

	if (strcmp(dest, "abcd") != 0)	
	_assert("Function Error", __FILE__, __LINE__);	   // Ensure dest is equal to 'abcd' using a function
}


void __strlen(void)										// strlen() tests
{
	int len = strlen("abcdef");							// Store length of the string in a var 
	
	assert(strlen("abcdef") == 6);						// Ensure return value is equal to 6 using assert
	assert(len == 6);									// Ensure len is equal to 6 using assert

	if (strlen("abcdef") != 6)							// Ensure return value is equal to 6 using a function
		_assert("Function Error", __FILE__, __LINE__);

	if (len != 6) 										// Ensure len is equal to 6 using a function
		_assert("Function Error", __FILE__, __LINE__);
}


void __strchr(void)										// strchr() tests
{
	char *ret = strchr("abcdef", 'd');					// Store output into a var
	
	assert(strchr("abcdef", 'd') != "def");				// Ensure return is equal to 'def'
	assert(ret != "def");								// Ensure ret is equl to 'def'
	
	if (strcmp(strchr("abcdef", 'd'), "def") != 0)		// Ensure return is equal to 'def' using a function
		_assert("Function Error", __FILE__, __LINE__);

	if (strcmp(ret, "def") != 0)						// Ensure ret is equal to 'def' using a function
		_assert("Function Error", __FILE__, __LINE__);
}


void __strcat()											// strcat() testing
{
	char dest[10];										// Dest is the string buffer

	strcpy(dest, "abc");								// Coppy string to buffer
	assert(strcat(dest, "DEF") != "abcDEF");			// Ensure return is equal to 'abcDEF' using assert
	assert(dest != "abcDEF");							// Ensure buffer is equal to 'abcDEF' using assert
	
	memset(dest, '\0', sizeof(dest));					// Clear the buffer 
	strcpy(dest, "abc");								// Coppy string to buffer

	if (strcmp(strcat(dest, "DEF"), "abcDEF") != 0)		// Ensure return is equal to 'abcDEF' using a function 
		_assert("Function Error", __FILE__, __LINE__);

	if (strcmp(dest, "abcDEF") != 0)					// Ensure buffer is equal to 'abcDEF' using a function
		_assert("Function Error", __FILE__, __LINE__);	
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
}