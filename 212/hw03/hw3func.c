/*****************************************************************
//
// FILE: hw3func.c
//
// DESCRIPTION: This file contains user input fucntion defenitions for hw3
//
//****************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern int debug;

/*****************************************************************
//
// Function name: getfield
//
// DESCRIPTION: get the address information from a user and cacatinate the street numbers to the street name
//
// Parameters:  char street[]:  address name to be stored
//              int limit[]:    maximum length of address that can be stored
//
// Return values: VOID
//
//****************************************************************/

void getfield(char street[], int limit)
{
    char hold[limit];
    int  i = 0;
    while(i == 0)
    {
      fgets(hold, limit, stdin);
      if(hold[0] != '\n')
      {
            hold[strlen(hold) - 1] = ' ';
            strcat(street,hold);
      }
      else if(hold[0] == '\n')
      {
          i = 1;
      }
    }
}
