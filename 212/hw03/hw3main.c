/*****************************************************************
//
// HOMEWORK: hw3
//
// CLASS: ICS 212
//
// FILE: hw3main.c
//
// DESCRIPTION: This file contains the main function to drive hw3
//
//****************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "hw3header.h"

struct record * start = NULL;
int debug = 0;

void main(int argc, char * argv[])
{

    if ((argc == 2) && ((strcmp(argv[1], "debug") == 0)))
    {
        debug = 1;
    } else if (argc >= 2)
    {
        debug = 2;
    } else
    {
        debug =0;
    }

    switch (debug)
    {
    case 1:
        printf("\n");
        printf("************************************\n");
        printf("\tDEBUG MODE: ACTIVE\n");
        printf("************************************\n");

        break;
    case 2:
        printf("\nInvalid arguments, stoping program...\n\n");

        exit(0);
        break;
    default:
        break;
    }

        int choice = 0;
        printf("\nSystem Recorder v1.0\n\n");

    do
    {
        printf("--Main menu--\n\n");
        printf("[1]\tAdd new record\n");
        printf("[2]\tModify record\n");
        printf("[3]\tPrint record\n");
        printf("[4]\tPrint database\n");
        printf("[5]\tDelte record\n");
        printf("[6]\tExit\n\n");

        printf("Enter a number to make a selection: ");
        scanf("%i", (int*)&choice);
        printf("\n");

        int  bYear   = 0;
        int  account = 0;
        char load[100];
        char fullName[25];
        char address[80] = {'\0'};


        switch (choice)
        {
            case 1:
                printf("Add new record\n\n");
                printf("Enter your account number: \n" );
                scanf("%i", &account);
                scanf("%c",load);

                printf(" \n" );
                printf("Enter your first and last name: \n" );
                fgets(fullName,25,stdin);
                fullName[strlen(fullName) - 1] = '\0';
                printf(" \n" );

                printf("Enter your birth year: \n" );
                scanf("%i", &bYear);
                scanf("%c",load);

                printf(" \n" );
                printf("Enter your address as follows:\n" );
                printf("Street Number\n" );
                printf("Street Name\n" );
                printf("Apartment Number\n" );
                printf("Press enter twice when done\n" );
                getfield(address,80);

                addRecord (&start, account, fullName, address, bYear);

                choice = 0;
                break;
            case 2:
                printf("Modify record\n\n");
                modifyRecord (start, account, fullName);

                choice = 0;
                break;
            case 3:
                printf("Print record\n\n");
                printRecord (start, account);

                choice = 0;
                break;
            case 4:
                printf("Print database\n\n");
                printAllRecords (start);

                choice = 0;
                break;
            case 5:
                printf("Delete record\n\n");
                deleteRecord (&start, account);
                choice = 0;
                break;
            case 6:
                printf("Exiting program...\n\n");

                exit(0);
                break;
            default:
                printf("Invalid entry, stopping program...\n\n");

                choice = 0;
                exit(0);
                break;
        }
    } while(choice == 0);
}
