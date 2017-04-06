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
#include "record.h"

extern int debug;

/*****************************************************************
//
// Function name: addRecord
//
// DESCRIPTION: adds a new record to the database
//
// Parameters:  struct record **:   pointer to next null entry for new record
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
    if(debug == 1)
    {
        printf("************************************\n");
        printf("\tDEBUG MODE\n");
        printf("Record number is: TEST\n");
        printf("Account number is: %i\n", accnum);
        printf("Name is: %s\n", name);
        printf("Address is: %s\n", addr);
        printf("Birth year is: %i\n", byear);
        printf("************************************\n\n");
    }
    printf("Record successfully added\n\n");
    return 0;
}

/*****************************************************************
//
// Function name: printRecord
//
// DESCRIPTION: prints out a record based on the account number given and starting data base pointer
//
// Parameters:  struct record *:    header pointer
//             int accnum:          account numer to search for
//
// Return values: 1:    success
//                0:    failure
//
//****************************************************************/

int printRecord (struct record * pRecord, int accnum)
{
    if(debug == 1)
    {
        printf("************************************\n");
        printf("\tDEBUG MODE\n");
        printf("Record number is: TEST\n");
        printf("Account number is: %i\n", accnum);
        printf("************************************\n\n");
    }
    printf("Record printed\n\n");
    return 0;
}

/*****************************************************************
//
// Function name: modifyRecord
//
// DESCRIPTION: modify record based on account number given
//
// Parameters:  struct record **:   header pointer address
//             int accnum:          account numer to search for
//             char name[]:         name to change in the record
//
// Return values: 1:    success
//                0:    failure
//
//****************************************************************/

int modifyRecord (struct record * pRecord, int accnum, char name[] )
{
    if(debug == 1)
    {
        printf("************************************\n");
        printf("\tDEBUG MODE\n");
        printf("Record number is: TEST\n");
        printf("Account number is: %i\n", accnum);
        printf("Name is: %s\n", name);
        printf("************************************\n\n");
    }
    printf("Record modified\n\n");
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
    if(debug == 1)
    {
        printf("************************************\n");
        printf("\tDEBUG MODE\n");
        printf("Record number is: TEST\n");
        printf("************************************\n\n");
    }
    printf("All records printed\n\n");
}

/*****************************************************************
//
// Function name: deleteRecord
//
// DESCRIPTION: delete a record from the address book for the account number given
//
// Parameters:  struct record **:   pointer to address book header
//             int accnum:          account numer to searc for
//
// Return values: 1:    success
//                0:    failure
//
//****************************************************************/

int deleteRecord(struct record ** pRecord, int accnum)
{
    if(debug == 1)
    {
        printf("************************************\n");
        printf("\tDEBUG MODE\n");
        printf("Record number is: TEST\n");
        printf("Account number is: %i\n", accnum);
        printf("************************************\n\n");
    }
    printf("Record deleted\n\n");
    return 0;
}
