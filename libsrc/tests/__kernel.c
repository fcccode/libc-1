#include <stdio.h>
#include <ctype.h>
#include <conio.h>
#include <string.h>
#include <assert.h>
#include <bios.h>

extern void main()
{
        clrscr();
    textcolor(YELLOW);
    cprintf("[!] Testing 'string' C functions...\r\n");
    string_tests();
    cprintf("[!] Testing 'ctype' C functions...\r\n");
    ctype_tests();
    cprintf("[!] Testing 'conio' C functions...\r\n");
    conio_tests();
    conio_input_tests();
    for (;;);
}
