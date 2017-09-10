// time.h
#ifndef __TIMEE__
#define __TIMEE__
#include <stdint.h>

typedef	long clock_t;
typedef short time_t;

#ifdef __cplusplus
extern "C" {
#endif

struct tm
{
    uint16_t tm_sec;		/* Seconds: 0-59 (K&R says 0-61?) */
    uint16_t tm_min;		/* Minutes: 0-59 */
    uint16_t tm_hour;		/* Hours since midnight: 0-23 */
    uint16_t tm_mday;		/* Day of the month: 1-31 */
    uint16_t tm_mon;		/* Months *since* january: 0-11 */
    uint16_t tm_year;		/* Years since 1900 */
    uint16_t tm_wday;		/* Days since Sunday (0-6) */
    uint16_t tm_yday;		/* Days since Jan. 1: 0-365 */
    uint16_t tm_isdst;		/* +1 Daylight Savings Time, 0 No DST*/
};



struct tm *localtime();
#ifdef __cplusplus
}
#endif
#endif // __TIMEE__