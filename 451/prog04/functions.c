#include <stdlib.h>
#include <stdio.h>
#include <sys/stat.h>
#include "structs.h"

long file_size (char* file_name);

long file_size (char * file_name)
{
	struct stat size_struct;
	if (stat (file_name, &size_struct) == 0)
	{
		return size_struct.st_size;
	}
	return 0;
}
