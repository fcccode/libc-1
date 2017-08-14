#include <conio.h>
#include <assert.h>
#include <stdio.h>

void __getch(void)						// getch() testing
{
    int c;
    printf("\tEnter a character: ");
    c = getch();						// Get key pressed
    putch(c);							// Print the key pressed
    puts("\n");
}


void __getche(void)					        // getche() testing
{
    char ch;
    printf("\tEnter a character: ");
    ch = getche();					        // Get key pressed and echo it
    printf("\r\n\tThe character was '%c'", ch);			// Print out what the char was
    puts("\n");
}


void __ungetch(void)
{
    int i;
    char ch;
    printf("\tEnter a character: ");

    ch = getche();						// Get a char to push
    ungetch(ch);						// Push the char back to the stack

    printf("\r\n\tNext in buffer is '%c'", getch());
    puts("\n");
}


void __kbhit(void)					       // kbhit() testing
{
    puts("\tTouch a key.");
    while (!kbhit()) {}					       // Hang untill a key is pressed
    puts("\tYou have touched a key!");
    puts("\n");
}


void __gotoxy(void)						// gotoxy() testing
{
    int x = wherex();						// Save current x pos
    int y = wherey();						// Save current y pos

    gotoxy(1, 1);						// Move cursor to pos(1, 1)

    assert(wherex() == 1);					// Ensure x value is at 1
    assert(wherey() == 1);					// Ensure y value is at 1

    gotoxy(x, y);						// Restore x and y pos

}


void __wherex(void)
{
    int x = wherex();						// Save current x pos

    gotoxy(1, wherey());					// Move cursor to pos(1, ypos)

    assert(wherex() == 1);					// Ensure x value is at 1

    gotoxy(x, wherey());					// Restore x pos
}


void __wherey(void)
{
    int y = wherey();						// Save current y pos

    gotoxy(wherex(), 1);					// Move cursor to pos(xpos, 1)

    assert(wherey() == 1);					// Ensure y value is at 1

    gotoxy(wherex(), y);					// Restore y pos
}


void __textcolor(void)						// textcolor() testing
{
    textcolor(LIGHTMAGENTA);					// Set text color to pink
    cprintf("\tI should be pink!\r\n\n");			// Check if output is truely pink
    textcolor(YELLOW);						// Set text color back to yellow
}


void __textbackground(void)					// textbackground() testing
{
    textbackground(BLUE);					// Set text bg to blue
    cprintf("\tI should have a blue background!\r\n\n");	// Check if output bg is truely blue
    textbackground(BLACK);					// Set text bg back to black
}


void __highvideo(void)						// highvideo() testing
{
    textcolor(CYAN);						// Set text color to pink
    cprintf("\tLow video cyan!\r\n");				// Check if output is truely light cyan
    highvideo();
    cprintf("\tHigh video cyan!\r\n\n");			// Check if output is truely bright cyan
    textcolor(YELLOW);						// Set text color back to yellow
}


void __lowvideo(void)						// lowvideo() testing
{
    textcolor(LIGHTRED);					// Set text color to pink
    cprintf("\tHigh video red!\r\n");				// Check if output is truely light cyan
    lowvideo();
    cprintf("\tLow video red!\r\n\n");				// Check if output is truely bright cyan
    textcolor(YELLOW);						// Set text color back to yellow
}


void conio_tests(void)
{
    __gotoxy();
    __wherex();
    __wherey();
}


void conio_input_tests(void)
{
    cprintf("\t[!] Testing 'textcolor()'\r\n");
    __textcolor();
    cprintf("\t[!] Testing 'textbackground()'\r\n");
    __textbackground();
    cprintf("\t[!] Testing 'highvideo()'\r\n");
    __highvideo();
    cprintf("\t[!] Testing 'lowvideo()'\r\n");
    __lowvideo();
    cprintf("\t[!] Testing 'getch()'\r\n");
    __getch();
    cprintf("\t[!] Testing 'getche()'\r\n");
    __getche();
    cprintf("\t[!] Testing 'ungetch()'\r\n");
    __ungetch();
    cprintf("\t[!] Testing 'kbhit()'\r\n");
    __kbhit();
}