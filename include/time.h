// time.h
#ifndef __TIMEE__
#define __TIMEE__

typedef	long clock_t;
typedef short time_t;

struct tm
{
    int	tm_sec;		/* Seconds: 0-59 (K&R says 0-61?) */
    int	tm_min;		/* Minutes: 0-59 */
    int	tm_hour;	/* Hours since midnight: 0-23 */
    int	tm_mday;	/* Day of the month: 1-31 */
    int	tm_mon;		/* Months *since* january: 0-11 */
    int	tm_year;	/* Years since 1900 */
    int	tm_wday;	/* Days since Sunday (0-6) */
    int	tm_yday;	/* Days since Jan. 1: 0-365 */
    int	tm_isdst;	/* +1 Daylight Savings Time, 0 No DST*/
};
struct tm localtime();
#endif // __TIMEE__