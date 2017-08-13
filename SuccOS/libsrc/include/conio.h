// stdio.h
#ifndef __CONIO__
#define __CONIO__

#define NOCURSOR 32
#define SOLIDCURSOR 256
#define NORMALCURSOR 6

// Defines max screen coordinates
#define MAX_X 80
#define MAX_Y 25

#ifdef __cplusplus
extern "C" {
#endif

/* Low level console I/O functions */

char *cgets(char *__buf);    			//
int cputs(const char*);				// Returns a string to the screen
int cprintf(const char*, ...); 			// Prints formatted output to the screen
int cscanf(const char *__fmt, ...); //		//
int getch(void);				// Get keyboard keypress
int getche(void);				// Get keyboard keypress and echo
int kbhit(void);				// Is keyboard hit?
int putch(int);					// Print char on the screen
int ungetch(int);				// Pushes a char back into the keyboard buffer

void clrscr(void);				// Clears the screen
void textbackground(int);			// Change of current background color in text mode
void textcolor(int);				// Change the color of drawing text
void gotoxy(int, int);				// Places cursor at a desired location on screen
int wherex(void);				// Return the x pos of the cursor
int wherey(void);			        // Return the y pos of the cursor
void highvideo(void);				// Set to high intensity bits for text
void lowvideo(void);				// Set to low intensity bits for text

/* misc done    */
void cursoron(void);
void cursoroff(void);
void delay(int ms);

void drawline(int x, int y, int len);
void newline(void);
void setcursortype(int type);

#ifdef __cplusplus
}
#endif

#endif	// __CONIO__
