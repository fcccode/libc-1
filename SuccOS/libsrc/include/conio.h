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

char *cgets(char *__buf);    //
int cputs(const char*);			   // Make text go to current window
int cprintf(const char *__fmt, ...);   //
int cscanf(const char *__fmt, ...); //
int getch(void);
int getche(void);
int kbhit(void);
int putch(int);
int ungetch(int);


void textbackground(int color);
void textcolor(int color);

/* misc done    */
void clrscr(void);
void gotoxy(char x, char y);
void cursoron(void);
void cursoroff(void);
void delay(int ms);
int wherex(void);
int wherey(void);
void drawline(int x, int y, int len);
void newline(void);
void setcursortype(int type);

#ifdef __cplusplus
}
#endif

#endif	// __CONIO__
