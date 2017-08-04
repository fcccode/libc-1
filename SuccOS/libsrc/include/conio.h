// stdio.h
#ifndef __CONIO__
#define __CONIO__

#define NOCURSOR 32
#define SOLIDCURSOR 256
#define NORMALCURSOR 6

// Defines screen colors 
#define BLACK		 0          
#define RED			 1
#define GREEN		 2
#define BROWN		 3
#define BLUE		 4
#define MAGENTA		 5
#define CYAN		 6
#define LIGHTGRAY	 7
#define DARKGRAY	 8       
#define LIGHTRED     9
#define LIGHTGREEN   10
#define YELLOW		 11
#define LIGHTBLUE	 12
#define LIGHTMAGENTA 13
#define LIGHTCYAN	 14
#define WHITE		 15

// Defines max screen coordinates
#define MAX_X 80
#define MAX_Y 25

#ifdef __cplusplus
extern "C" {
#endif

/* Low level console I/O functions */

// char *cgets(char*);
// int cprintf(const char*, ...);
// int cputs(const char*);
// int cscanf(char*, ...);
int getch(void);
int getche(void);
// int kbhit(void);
// int putch(int);
// int ungetch(int);



void clrscr(void);
void gotoxy(char x, char y);
void cursoron(void);
void cursoroff(void);
void delay(int ms);
int wherex(void);
int wherey(void);
void drawline(int x, int y, int len);
void setbackground(int color);
void newline(void);
void setcursortype(int type);

#ifdef __cplusplus
}
#endif

#endif	// __CONIO__
