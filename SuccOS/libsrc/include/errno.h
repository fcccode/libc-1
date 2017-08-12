// errno.h
#ifndef __ERRNO__
#define __ERRNO__

#define	ENOFILE		1	// No such file or directory
#define	E2BIG		2	// Arg list too long
#define	ENOEXEC		3	// Exec format error
#define	EEXIST		4	// File exists
#define	ENOTDIR		5	// Not a directory
#define	EISDIR		6	// Is a directory
#define	EINVAL		7	// Invalid argument
#define	EFBIG		8	// File too large
#define	ENAMETOOLONG	9	// Filename too long
#define	ENOSYS		10	// Function not implemented

#ifdef __cplusplus
extern "C" {
#endif

/* Definitions of the Standard C library errno header */

int errno = 0;

#ifdef __cplusplus
}
#endif

#endif // __ERRNO__