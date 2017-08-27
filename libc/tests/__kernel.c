#include <conio.h>
#include <time.h>

/*
float.h // start
locale.h // start
math.h // start
stdlib.h // start
*/


extern void main()
{
    clrscr();

    cprintf("[!] Testing 'string' C functions...\r\n");
    string_tests();

    cprintf("[!] Testing 'ctype' C functions...\r\n");
    ctype_tests();

    cprintf("[!] Testing stddef' C functions...\r\n");
    stddef_tests();

    cprintf("[!] Testing 'signal' C functions...\r\n"); 		  // TODO: Look more into signal functions
    signal_tests();

    cprintf("[!] Testing 'conio' C functions...\r\n");
    conio_tests();

    cprintf("[!] Testing 'time' C functions...\r\n");
    time_tests();


    //conio_input_tests();
    for (;;);
}
