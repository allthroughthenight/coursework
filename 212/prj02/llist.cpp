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

#include <iostream>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "llist.h"

using namespace std;

/*****************************************************************
//
// Function name: llist()
//
// DESCRIPTION: llist constructor
//
// Parameters: N/A
//
//****************************************************************/

llist::llist()
{
    /* not implemented */
}

/*****************************************************************
//
// Function name: llist()
//
// DESCRIPTION: llist constructor
//
// Parameters: filename[]: name of file to read from
//
//****************************************************************/

llist::llist(char filename[])
{
    /* not implemented */
}

/*****************************************************************
//
// Function name: ~llist()
//
// DESCRIPTION: llist destructor
//
// Parameters: N/A
//
//****************************************************************/

llist::~llist()
{
    /* not implemented */
}

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

int llist::addRecord(int accnum, char name[], char addr[], int byear)
{
    struct record * before = start;
    struct record * temp = new record;

    temp->accountno = accnum;
    strcpy(temp->name, name);
    strcpy(temp->address, addr);
    temp->yearofbirth = byear;
    temp->next = NULL;

    /* Empty list */
    if (start == NULL) {
        start = temp;
        #ifdef DEBUG
            cout << "******************************************\n";
            cout << "           empty list\n";
            cout << "******************************************\n";
        #endif
    }
    /* One record list */
    else if (before->next == NULL)
    {
        before->next = temp;
        #ifdef DEBUG
            cout << "******************************************\n";
            cout << "           one record list\n";
            cout << "******************************************\n";
        #endif
    }
    /* Multi-record list */
    else
    {
        while (before->next != NULL)
        {
            before = before->next;
        }
        before->next = temp;
        #ifdef DEBUG
            cout << "******************************************\n";
            cout << "           multi record list\n";
            cout << "******************************************\n";
        #endif
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

int llist::printRecord(int accnum)
{
    struct record * temp = start;
    int found = 0;

    /* Empty list */
    if(start == NULL)
    {
        cout << "No records available\n\n";
    }
    /* Check the head */
    else if (temp->accountno == accnum) {
        found == 1;

        cout << "Account Number: " << temp->accountno << "\n";
        cout << "Name: " << temp->name << "\n";
        cout << "Address: " << temp->address << "\n";
        cout << "Birth Year: " << temp->yearofbirth << "\n\n";
    }
    /* Check the list */
    else
    {
        while(temp->next != NULL)
        {
            if (temp->accountno == accnum)
            {
                found == 1;

                cout << "Account Number: " << temp->accountno << "\n";
                cout << "Name: " << temp->name << "\n";
                cout << "Address: " << temp->address << "\n";
                cout << "Birth Year: " << temp->yearofbirth << "\n";
            }
            temp = temp->next;
        }

        /* Check the tail */
        if (found == 0)
        {
            if (temp->accountno == accnum)
            {
                cout << "Account Number: " << temp->accountno << "\n";
                cout << "Name: " << temp->name << "\n";
                cout << "Address: " << temp->address << "\n";
                cout << "Birth Year: " << temp->yearofbirth << "\n\n";
            }
            else
            {
                cout << "Record not found\n\n";
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
// Parameters: int accnum:          account numer to search for
//             char name[]:         address
//
// Return values: 1:    success
//                0:    failure
//
//****************************************************************/

int llist::modifyRecord(int accnum, char addr[] )
{
    struct record * temp = start;
    struct record * hold;

    int item = 1;

    /* Empty list */
    if(start == NULL)
    {
        cout << "\nNo records available\n\n";

        #ifdef DEBUG
            cout << "******************************************\n";
            cout << "           empty list\n";
            cout << "******************************************\n";
        #endif
    }
    /* Check the head */
    else if (temp->accountno == accnum) {
        strcpy(temp->address, addr);
        #ifdef DEBUG
            cout << "******************************************\n";
            cout << "           changed head\n";
            cout << "******************************************\n";
        #endif
    }
    /* Check the list */
    else
    {
        #ifdef DEBUG
            cout << "******************************************\n";
            cout << "           multi record list\n";
            cout << "******************************************\n";
        #endif

        while(temp->next != NULL)
        {
            if (temp->accountno == accnum)
            {
                strcpy(temp->address, addr);
                #ifdef DEBUG
                    cout << "******************************************\n";
                    cout << "           changed in list record\n";
                    cout << "******************************************\n";
                #endif
            }
            hold = temp->next;
            temp = hold;
        }

        /* Check the tail */
        if (temp->accountno == accnum)
        {
            strcpy(temp->address, addr);

            #ifdef DEBUG
                cout << "******************************************\n";
                cout << "           changed tail\n";
                cout << "******************************************\n";
            #endif

        } else{
            cout << "\nRecord not found\n\n";
        }
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

void llist::printAll()
{
    struct record * hold;
    struct record temp = *start;

    /* Empty list */
    if (start == NULL)
    {
        cout << "\nNo records available\n\n";
    }
    else
    {
        while(temp.next != NULL)
        {
            cout << "Account Number: " << temp.accountno << "\n";
            cout << "Name: " << temp.name << "\n";
            cout << "Address: " << temp.address << "\n";
            cout << "Birth Year: " << temp.yearofbirth << "\n\n";

            hold = temp.next;
            temp = *hold;
        }

        /* Print the tail */
        cout << "Account Number: " << temp.accountno << "\n";
        cout << "Name: " << temp.name << "\n";
        cout << "Address: " << temp.address << "\n";
        cout << "Birth Year: " << temp.yearofbirth << "\n\n";
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

int llist::deleteRecord(int accnum)
{
    struct record *compare = start;
    int target = accnum;
    int flag   = 0;

    /* Empty list */
    if (start == NULL)
    {
        printf("No records available\n\n");

        #ifdef DEBUG
            cout << "******************************************\n";
            cout << "           empty list\n";
            cout << "******************************************\n";
        #endif
    }

    /* One record list */
    else if (compare->next == NULL)
    {
        if (compare->accountno == target)
        {

            #ifdef DEBUG
                cout << "******************************************\n";
                cout << "           one record list\n";
                cout << "******************************************\n";
            #endif

            start = NULL;
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
        #ifdef DEBUG
            cout << "******************************************\n";
            cout << "           multi-record list\n";
            cout << "******************************************\n";
        #endif

        struct record *before;
        struct record *after = compare->next;

        /* Check the head */
        if (compare->accountno == target)
        {
            (start) = compare->next;
            free(compare);

            #ifdef DEBUG
                cout << "******************************************\n";
                cout << "           head deleted\n";
                cout << "******************************************\n";
            #endif
        }

        /* Check the list */
        while (compare->next != NULL)
        {
            if (compare->accountno == target)
            {
                before->next = after;
                free(compare);
                #ifdef DEBUG
                    cout << "******************************************\n";
                    cout << "           list item deleted\n";
                    cout << "******************************************\n";
                #endif
            }
            before  = compare;
            compare = compare->next;
            after   = after->next;
        }

        /* Check the tail */
        if (compare->accountno == target)
        {
            before->next = NULL;
            free(compare);
            #ifdef DEBUG
                cout << "******************************************\n";
                cout << "          tail deleted\n";
                cout << "******************************************\n";
            #endif
        }
    }
}
