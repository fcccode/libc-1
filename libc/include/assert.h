// assert.h
#ifndef __ASSERT__
#define __ASSERT__
#ifdef __cplusplus
extern "C" {
#endif

#ifdef NDEBUG
# define assert (e)		((void) 0)
#else
# define assert(e) ((e) ? (void)(0) : _assert(#e, __FILE__, __LINE__))

void _assert(const char*, const char*, int);	// Raise assertion error in system console!

#endif // NDEBUG

#ifdef __cplusplus
}
#endif

#endif // __ASSERT__