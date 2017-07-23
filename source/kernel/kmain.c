#include <stdio.h>
#include <ctype.h>
#include <conio.h>
#include <string.h>

void clearbuff(char *var) {
	while (var)	*var++ = '\0';
}


extern void kmain()
{
	char buffer[30];
	int ret;

	clrscr();
	setbackground(0x1e);
	puts("SuccOS [version 0.0.1]");
	puts("Copyright (C) 2017 - 2018 Joshua Riek");

	for (;;)
	{
		newline();								// Print new console line	
		printf("root@SuccOS:~$ ");				// Print out the input cursor
		gets(buffer);							// Get user input and store in buff

		if (!strcmp(buffer, "help"))
		{
			
		}
		else if (!strcmp(buffer, "cls"))
		{
		
		}
		else if (!strcmp(buffer, "echo"))
		{

		}
		else if (!strcmp(buffer, "reboot"))
		{

		}
		else if (!strcmp(buffer, "shutdown"))
		{

		}
		else
		{
			puts("Invalid command entered!");
		}
		clearbuff(buffer);
	}
}

