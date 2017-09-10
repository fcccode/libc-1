// stdint.h
#ifndef __STDINT__
#define __STDINT__
#include <stddef.h>

// Exact-width integer types
typedef signed char int8_t;
typedef unsigned char uint8_t;			   // Exactly equal to a byte (8 bits)
typedef short int16_t;
typedef unsigned short uint16_t;		   // Exactly equal to a word (2 bytes)

// Limits of exact-width integer types
#define INT8_MIN (-128)
#define INT16_MIN (-32768)

#define INT8_MAX 127
#define INT16_MAX 32767

#define UINT8_MAX 0xff /* 255u */
#define UINT16_MAX 0xffff /* 65535u */

#endif // __STDINT__

