#include ".\\..\\..\\libsrc\\include\\stdio.h"
#include ".\\..\\..\\libsrc\\include\\string.h"
#include ".\\..\\..\\libsrc\\include\\assert.h"

// 21 functions 
static int passed;

void memchr_test(void)
{
	const char *str = "The quick brown fox";
	const char chr = 'b';
	char *ret = memchr(str, chr, strlen(str));

	if (!strcmp(ret, "brown fox"))
	{
		passed++;
	} 
	else 
	{
		puts("Error in 'memchr'");
	}
}
int test_assert(int x)
{
	return x;
}
void run_string_tests(void)
{
	int i;

	for (i = 0; i <= 9; i++)
	{
		test_assert(i);
		printf("%s %s\r\n",  __LINE__);
	}

	memchr_test();
	printf("Percent toatal = %d", 10/2);

	// memechr_test();
}