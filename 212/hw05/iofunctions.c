/*****************************************************************
//
// FILE: iofunctions.c
//
// DESCRIPTION: This file contains the file input and output function defenitions for hw5
//
//****************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "account.h"

/*****************************************************************
//
// Function name: readfile
//
// DESCRIPTION: Read from a text file, parse the data, then store it into a struct account array
//
// Parameters:  struct account accarray[]:  pointer to and array of account structs
//              int * numcust:              poitner to an integer that's used to record how many accounts were collected
//              char filename[]:            character array of the file to thats to be read from
//
// Return values:
//                 0: file not found
//                 1: file was found
//
//****************************************************************/

int readfile(struct account accarray[], int * numcust, char filename[])
{
    FILE *file;
    file = fopen(filename, "r");
    int i;
    int status;
    char *item;
    char line[121];

    if(!file)
    {
        status = 0;
     }
     else
     {
         i = 0;
         while (fgets(line, 40, file))
        {
            item = strtok(line, ":");
            strcpy(accarray[i].name, item);

            item = strtok(NULL, " ");
            accarray[i].accountno = atoi(item);

            item = strtok(NULL, "\n");
            accarray[i].balance = atoi(item);
            i++;
        }
        status = 1;
        fclose(file);
    }
    *numcust = i;
    return status;
}

/*****************************************************************
//
// Function name: writefile
//
// DESCRIPTION: write from an account array to a text file
//
// Parameters:  struct account accarray[]:  pointer to an array of account structs to read from
//              int * numcust:              integer of the number of accounts in the struct accounts array
//              char filename[]:            character array of the file to write to
//
// Return value: always 0
//
//****************************************************************/

int writefile(struct account accarray[], int numcust, char filename[])
{
    FILE *file;
    file = fopen(filename, "w");
    int i = 0;

    if(!file)
    {
        printf("Error: File Does Not Exist\n");
    }

    while(i < numcust)
    {
        fprintf(file, "%s:%d %.2f\n", accarray[i].name, accarray[i].accountno, accarray[i].balance);
        i++;
    }
    fclose(file);
    return 0;
}
