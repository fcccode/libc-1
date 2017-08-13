#include <stdio.h>
#include <ctype.h>
#include <conio.h>
#include <string.h>
#include <assert.h>

extern void ktest()
{
    int i = 0;
    char ch;
    clrscr();
    puts("SuccOS [version i don't fucking know]");
    puts("Copyright (C) 2017 - 2018 Joshua Riek\n");
    textbackground(4);
    textcolor(14);
    cputs("STRINGGGGGGG|\r\n");
    cprintf("Number: %s\r\n", "7 - 2018 Joshua Riek");

    puts("Testing 'string' C functions...\n");
    string_tests();
    puts("Testing 'ctype' C functions...\n");
    ctype_tests();
    for (;;);
}
