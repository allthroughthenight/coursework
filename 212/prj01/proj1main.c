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
#include "proj1header.h"

struct record * start = NULL;
int debug = 0;

void main(int argc, char * argv[])
{

    /* Check CLI arguments to set debug variable */
    if ((argc == 2) && ((strcmp(argv[1], "debug") == 0)))
    {
        debug = 1;
    }
    else if (argc >= 2)
    {
        debug = 2;
    }
    else
    {
        debug =0;
    }

    /* Check debug variable */
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
        printf("\nSystem Recorder v1.0.8\n\n");

    /* Main menu loop */
    do
    {
        int bYear = 0;
        char load[100];
        int account = 0;
        char fullName[25];
        char address[80] = {'\0'};
        int clear;

        printf("--Main menu--\n\n");
        printf("[1]\tAdd new record\n");
        printf("[2]\tModify record\n");
        printf("[3]\tPrint record\n");
        printf("[4]\tPrint database\n");
        printf("[5]\tDelte record\n");
        printf("[6]\tExit\n");
        printf("[7]\tClear screen\n\n");

        printf("Enter a number to make a selection: ");
        scanf("%i", (int*)&choice);
        printf("\n");

        /* User selection */
        switch (choice)
        {
            case 1:
                printf("Add new record\n\n");

                printf("Enter your account number:\n" );
                scanf("%i", &account);
                scanf("%c",load);
                printf("\n" );

                printf("Enter your first and last name:\n" );
                fgets(fullName, 25, stdin);
                fullName[strlen(fullName) - 1] = '\0';
                printf("\n" );

                printf("Enter your birth year:\n" );
                scanf("%i", &bYear);
                scanf("%c",load);

                printf("\n" );
                printf("Enter your address as follows:\n" );
                printf("Street Number\n" );
                printf("Street Name\n" );
                printf("Apartment Number\n" );
                printf("Press enter twice when done\n" );

                if (debug == 1)
                {
                    printf("************************************\n");
                    printf("Get field invoked\n");
                    printf("************************************\n\n");
                }

                getfield(address, 80);

                if (debug == 1)
                {
                    printf("************************************\n");
                    printf("Add record invoked\n");
                    printf("************************************\n\n");
                }

                addRecord (&start, account, fullName, address, bYear);
                choice = 0;
                break;
            case 2:
                printf("Modify record\n\n");

                printf("Enter account the number:\n");
                scanf("%i", &account);
                scanf("%c",load);

                printf("Enter your address as follows:\n" );
                printf("Street Number\n" );
                printf("Street Name\n" );
                printf("Apartment Number\n" );
                printf("Press enter twice when done\n" );

                getfield(address,80);

                if (debug == 1)
                {
                    printf("************************************\n");
                    printf("Get field invoked\n");
                    printf("************************************\n\n");
                }

                modifyRecord (start, account, address);

                if (debug == 1)
                {
                    printf("************************************\n");
                    printf("Modify record invoked\n");
                    printf("************************************\n\n");
                }

                choice = 0;
                break;
            case 3:
                printf("Print record\n\n");

                printf("Enter the account number:\n" );
                scanf("%i", &account);
                scanf("%c",load);

                printRecord (start, account);

                if (debug == 1)
                {
                    printf("************************************\n");
                    printf("Print record invoked\n");
                    printf("************************************\n\n");
                }

                choice = 0;
                break;
            case 4:
                printf("Print database\n\n");

                printAllRecords (start);

                if (debug == 1)
                {
                    printf("************************************\n");
                    printf("Print database invoked\n");
                    printf("************************************\n\n");
                }

                choice = 0;
                break;
            case 5:
                printf("Delete record\n\n");

                printf("Enter your account number:\n" );
                scanf("%i", &account);
                scanf("%c",load);

                deleteRecord (&start, account);

                if (debug == 1)
                {
                    printf("************************************\n");
                    printf("Delete record invoked\n");
                    printf("************************************\n\n");
                }

                choice = 0;
                break;
            case 6:
                exit(0);
                break;
            case 7:
                for (clear = 0; clear < 50; clear++ )
                    printf("\n");
                    
                choice = 0;
                break;
            default:
                printf("Invalid entry, stopping program...\n\n");

                choice = 0;
                exit(0);
                break;
        }
    } while(choice == 0);
}
