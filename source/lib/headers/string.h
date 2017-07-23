// string.h
#ifndef __STRING__
#define __STRING__

#ifdef __cplusplus
extern "C" {
#endif

typedef unsigned int size_t;

int strcmp(const char *str1, const char *str2);
int strncmp(const char *str1, const char *str2, size_t n);

#ifdef __cplusplus
}
#endif

#endif // __STRING__