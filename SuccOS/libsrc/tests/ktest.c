#include <stdio.h>
#include <ctype.h>
#include <conio.h>
#include <string.h>
#include <assert.h>


extern void ktest()
{
    clrscr();
    setbackground(0x9f);
    puts("SuccOS [version i don't fucking know]");
    puts("Copyright (C) 2017 - 2018 Joshua Riek\n");

    puts("Testing 'string' functions...");

    string_tests();
    for (;;);
}
