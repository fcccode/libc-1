#include ".\\..\\..\\libsrc\\include\\stdio.h"
#include ".\\..\\..\\libsrc\\include\\ctype.h"
#include ".\\..\\..\\libsrc\\include\\conio.h"
#include ".\\..\\..\\libsrc\\include\\string.h"



void clearbuff(char *var) {
	while (var)	*var++ = '\0';
}

void cli(char * prompt, char buffer[])
{
	newline();								// Print new console line	
	printf(prompt);							// Print cmd prompt
	gets(buffer);							// Get user input and store in buffer

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

extern void kmain()
{
	char buffer[64];
	char *prompt = "root@SuccOS:~$ ";

	clrscr();
	setbackground(0x07);
	puts("SuccOS [version 0.0.1]");
	puts("Copyright (C) 2017 - 2018 Joshua Riek");

	for (;;) cli(prompt, buffer);
}

