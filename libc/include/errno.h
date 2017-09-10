// errno.h
#ifndef __ERRNO__
#define __ERRNO__

#define ERROR_SUCCESS	       0    // The operation completed successfully
#define ERROR_INVALID_FUNCTION 1    // Incorrect function
#define ERROR_FILE_NOT_FOUND   2    // The system cannot find the file specified
#define ERROR_FILE_EXISTS      3    // The file exists
#define	ERROR_BUFFER_OVERFLOW  4    // The file name is too long
#define	ERROR_INVALID_PARAM    5    // Typed a command correctly but specified the incorrect parameter
#define	ERROR_ACCESS_DENIED    6    // Access denied

#ifdef __cplusplus
extern "C" {
#endif

int errno = 0;

#ifdef __cplusplus
}
#endif

#endif // __ERRNO__