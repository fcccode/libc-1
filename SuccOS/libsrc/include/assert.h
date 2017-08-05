// assert.h
#ifndef __ASSERT__
#define __ASSERT__



#ifdef NDEBUG
# define assert (e) ((void) 0)
#else
#define assert(e) ((e) ? (void)(0) : _assert(__FILE__, __LINE__, #e))
#endif

/* Definitions of the Standard C library assert header */
void _assert(const char *file, int line, const char *e);



#endif // __ASSERT__