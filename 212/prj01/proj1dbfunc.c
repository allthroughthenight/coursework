/*****************************************************************
//
// HOMEWORK: hw3
//
// CLASS: ICS 212
//
// FILE: hw3dbfunc.c
//
// DESCRIPTION: This file contains data base fucntion defenitions for hw3
//
//****************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "record.h"

extern int debug;

/*****************************************************************
//
// Function name: addRecord
//
// DESCRIPTION: Adds a new record to the beginning of the database
//
// Parameters: struct record **:    pointer to next null entry for new record
//             int accnum:          account numer for the new record
//             char name[]:         name for the new record
//             char addr[]:         address for the new record
//             int byear:           birth year for the new entry
//
// Return values: 1:    success
//                0:    failure
//
//****************************************************************/

int addRecord (struct record ** pRecord, int accnum, char name[], char addr[], int byear)
{
    struct record *before = *pRecord;
    struct record  *temp = (struct record *) malloc(sizeof(struct record));

    (*temp).accountno = accnum;
    strcpy((*temp).name, name);
    strcpy((*temp).address, addr);
    (*temp).yearofbirth = byear;
    (*temp).next = NULL;

    /* Empty list */
    if (*pRecord == NULL) {
        *pRecord = temp;
    }

    /* One record list */
    else if ((*before).next == NULL)
    {
        (*before).next = temp;
    }

    /* Multi-record list */
    else
    {
        while ((*before).next != NULL)
        {
            before = (*before).next;
        }
        (*before).next = temp;
    }

    /* Record information */
    if (debug == 1)
    {
        printf("************************************\n");
        printf("Account number: %i\n", (*temp).accountno);
        printf("Name: %s\n", (*temp).name);
        printf("Address: %s\n", (*temp).address);
        printf("Year of birth: %i\n", (*temp).yearofbirth);
        printf("************************************\n\n");
    }
    return 0;
}

/*****************************************************************
//
// Function name: printRecord
//
// DESCRIPTION: Prints out a record based on the account number given and starting data base pointer
//
// Parameters: struct record *:     header pointer
//             int accnum:          account numer to search for
//
// Return values: 1:    success
//                0:    failure
//
//****************************************************************/

int printRecord (struct record * pRecord, int accnum)
{
    struct record * temp = pRecord;
    int found = 0;

    /* Empty list */
    if(pRecord == NULL)
    {
        printf("No records available\n\n");
    }

    /* Check the head */
    else if ((*temp).accountno == accnum) {
        found == 1;

        printf("Account Number: %i\n", (*temp).accountno);
        printf("Name: %s\n", (*temp).name);
        printf("Address: %s\n", (*temp).address);
        printf("Birth Year: %i\n\n", (*temp).yearofbirth);
    }

    /* Check the list */
    else
    {
        while((*temp).next != NULL)
        {
            if ((*temp).accountno == accnum)
            {
                found == 1;

                printf("Account Number: %i\n", (*temp).accountno);
                printf("Name: %s\n", (*temp).name);
                printf("Address: %s\n", (*temp).address);
                printf("Birth Year: %i\n\n", (*temp).yearofbirth);
            }
            temp = (*temp).next;
        }

        /* Check the tail */
        if (found == 0)
        {
            if ((*temp).accountno == accnum)
            {
                printf("Account Number: %i\n", (*temp).accountno);
                printf("Name: %s\n", (*temp).name);
                printf("Address: %s\n", (*temp).address);
                printf("Birth Year: %i\n\n", (*temp).yearofbirth);
            }
            else
            {
                printf("Record not found\n\n");
            }
        }
    }
    return 0;
}

/*****************************************************************
//
// Function name: modifyRecord
//
// DESCRIPTION: modify record based on account number given
//
// Parameters: struct record **:    header pointer address
//             int accnum:          account numer to search for
//             char name[]:         name to change in the record
//
// Return values: 1:    success
//                0:    failure
//
//****************************************************************/

int modifyRecord (struct record * pRecord, int accnum, char address[] )
{

    struct record * temp;
    struct record * hold;
    temp = pRecord;
    int item = 1;

    /* Current account information */
    if(debug == 1)
    {
        printf("************************************\n");
        printf("Old address: %s\n", (*temp).address);
        printf("************************************\n\n");
    }

    /* Empty list */
    if(pRecord == NULL)
    {
        printf("\nNo records available\n\n");
    }

    /* Check the head */
    else if ((*temp).accountno == accnum) {
        strcpy((*temp).address, address);
    }

    /* Check the list */
    else
    {
        while((*temp).next != NULL)
        {
            if ((*temp).accountno == accnum)
            {
                strcpy((*temp).address, address);
            }
            hold = (*temp).next;
            temp = hold;
        }

        /* Check the tail */
        if ((*temp).accountno == accnum)
        {
            strcpy((*temp).address, address);
        } else{
            printf("\nRecord not found\n\n");
        }
    }

    /* Post account information */
    if(debug == 1)
    {
        printf("************************************\n");
        printf("Current address: %s\n", (*temp).address);
        printf("************************************\n\n");
    }
    return 0;
}

/*****************************************************************
//
// Function name: printAllRecord
//
// DESCRIPTION: print all records of the given address book
//
// Parameters:  struct record *:    pointer to the address book header
//
// Return values: N/A
//
//****************************************************************/

void printAllRecords(struct record * pRecord)
{
    struct record * hold;
    struct record * temp = pRecord;

    /* Empty list */
    if (pRecord == NULL)
    {
        printf("\nNo records available\n\n");
    }
    else
    {
        while((*temp).next != NULL)
        {
            printf("Account Number: %i\n", (*temp).accountno);
            printf("Name: %s\n", (*temp).name);
            printf("Address: %s\n", (*temp).address);
            printf("Birth Year: %i\n\n", (*temp).yearofbirth);
            hold = (*temp).next;
            temp = hold;
        }

        /* Print the tail */
        printf("Account Number: %i\n", (*temp).accountno);
        printf("Name: %s\n", (*temp).name);
        printf("Address: %s\n", (*temp).address);
        printf("Birth Year: %i\n\n", (*temp).yearofbirth);
    }
}

/*****************************************************************
//
// Function name: deleteRecord
//
// DESCRIPTION: delete a record from the address book for the account number given
//
// Parameters: struct record **:    pointer to address book header
//             int accnum:          account numer to searc for
//
// Return values: 1:    success
//                0:    failure
//
//****************************************************************/

int deleteRecord(struct record ** pRecord, int accnum)
{
    struct record *compare = *pRecord;
    int target = accnum;
    int flag = 0;

    /* Empty list */
    if (*pRecord == NULL)
    {
        printf("No records available\n\n");
    }

    /* One record list */
    else if ((*compare).next == NULL)
    {
        if ((*compare).accountno == target)
        {
            *pRecord = NULL;
            free(compare);
        }
        else
        {
            printf("\nRecord not found\n\n");
        }
    }

    /* Multi-record list */
    else
    {
        struct record *before;
        struct record *after = (*compare).next;

        /* Check the head */
        if ((*compare).accountno == target)
        {
            (*pRecord) = (*compare).next;
            free(compare);
        }

        /* Check the list */
        while ((*compare).next != NULL)
        {
            if ((*compare).accountno == target)
            {
                (*before).next = after;
                free(compare);
            }
            before = compare;
            compare = (*compare).next;
            after = (*after).next;
        }

        /* Check the tail */
        if ((*compare).accountno == target)
        {
            (*before).next = NULL;
            free(compare);
        }
    }
    return 0;
}

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
    int i = 0;
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
