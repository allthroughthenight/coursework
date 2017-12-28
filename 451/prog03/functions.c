#include <stdlib.h>

void error(char *);

void error(char *msg)
{
    perror(msg);
    exit(0);
}
