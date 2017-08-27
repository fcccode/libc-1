#include <signal.h>
#include <assert.h>
#include <stdio.h>

void signal_catchfunc(int signal)
{
    return;
}

void signal_tests(void)
{
    if (signal(SIGINT, signal_catchfunc) == SIG_ERR)
    {
	printf("Error: unable to set signal handler.\r\n");
    }

    if (raise(SIGINT) != 0)
    {
	printf("Error: unable to raise SIGINT signal.\r\n");
    }
}