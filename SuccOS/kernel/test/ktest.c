#include ".\\..\\..\\libsrc\\include\\stdio.h"
#include ".\\..\\..\\libsrc\\include\\ctype.h"
#include ".\\..\\..\\libsrc\\include\\conio.h"
#include ".\\..\\..\\libsrc\\include\\string.h"
#include ".\\..\\..\\libsrc\\include\\assert.h"


extern void ktest()
{
	clrscr();
	setbackground(0x9f);
	puts("SuccOS [version i don't fucking know]");
	puts("Copyright (C) 2017 - 2018 Joshua Riek\n");

	puts("Testing 'string' functions...");

	conio_tests();
	for (;;);
}
