#include ".\..\include\conio.h"
#include ".\..\include\string.h"

void iscntrl_test(void)
{
	int i;

	for (i = 0; i <= 127; i++)
	{
		if (!iscntrl(i) && (i >= 0 && i <= 31) && i == 127)
		{
			printf("[Error][iscntrl] Returned: %d\r\n", i);
		}
	}
}

void conio_tests(void)
{

}