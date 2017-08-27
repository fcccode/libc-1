#include <stddef.h>
#include <assert.h>

struct address
{
    char name[50];
    char street[50];
    int phone;
};

void stddef_tests(void)
{
    assert(offsetof(struct address, name) == 0);			// Ensure the offset of 'name' is 0
    assert(offsetof(struct address, street) == 50);			// Ensure the offset of 'street' is 50
    assert(offsetof(struct address, phone) == 100);			// Ensure the offset of 'phone' is 100
}
