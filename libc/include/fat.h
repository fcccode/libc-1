// locale.h
#ifndef __FAT12__
#define __FAT12__
#include <stdint.h>

#define ATTRIB_READ_ONLY 0x01
#define ATTRIB_HIDDEN	 0x02
#define ATTRIB_SYSTEM	 0x04
#define ATTRIB_SUBDIR	 0x10
#define ATTRIB_ARCHIVE   0x20

typedef struct _entbuf
{
    uint8_t fileName[10];
    uint8_t fileExtension[4];
    uint16_t fileAttribute;
    uint8_t fileReserved[10];
    uint16_t fileCreatedMonth;
    uint16_t fileCreatedDay;
    uint16_t fileCreatedYear;
    uint16_t fileAccessedMonth;
    uint16_t fileAccessedDay;
    uint16_t fileAccessedYear;
    uint16_t fileModifiedMonth;
    uint16_t fileModifiedDay;
    uint16_t fileModifiedYear;
    uint16_t startCluster;
    uint16_t fileSize;
} EBUF;


#ifdef __cplusplus
extern "C" {
#endif

void resetFloppy(void);			// Reset the floppy disk
void openRoot(void);			// Open the root dir
void closeRoot(void);			// Close the root dir and flush buffer
struct rootEnt* readRoot(void);		// Read the root dir contents
char *fmtFatFilename(char*);		// Format the given filename into fat12 

#ifdef __cplusplus
}
#endif

#endif // __FAT12__