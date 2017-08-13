// limits.h
#ifndef __LIMITS__
#define __LIMITS__

#define CHAR_BIT    8		    // Number if bits in a byte
#define CHAR_MIN    (-128)	    // Minimum value of a char
#define CHAR_MAX    127		    // Maximum value of a char

#define SCHAR_MIN   (-128)	    // Minimum value of a char
#define SCHAR_MAX   127		    // Maximum value of a char
#define UCHAR_MAX   255		    // Maximum value of an unsigned char

#define SHRT_MAX    32767	    // Maximum value of a short int
#define SHRT_MIN    (-SHRT_MAX-1)   // Minimum value of a short int
#define USHRT_MAX   65535U	    // Maximum value of an unsigned short

#define INT_MAX	    32767           // Maximum value of an int
#define INT_MIN	    (-INT_MAX-1)    // Minimum value of an int
#define UINT_MAX    65535U          // Maximum value of an unsigned int

#define LONG_MAX    2147483647L	    // Maximum value of a long int
#define LONG_MIN    (-LONG_MAX-1)   // Minimum value of a long int
#define ULONG_MAX   4294967295UL    // Maximum value of an unsigned long

#endif // __LIMITS__