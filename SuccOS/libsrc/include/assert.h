// assert.h
#ifndef __ASSERT__
#define __ASSERT__

#ifdef __cplusplus
extern "C" {
#endif

#ifdef NDEBUG
# define assert (e) ((void) 0)
#else
# define assert(e) ((e) ? (void)(0) : _assert(__FILE__, __LINE__, #e))

void _assert(const char*, int, const char*);	// Raise assertion error in system console!

#endif // NDEBUG

#ifdef __cplusplus
}
#endif

#endif // __ASSERT__