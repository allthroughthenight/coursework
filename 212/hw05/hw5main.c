/*****************************************************************
//
// HOMEWORK: hw5
//
// CLASS: ICS 212
//
// FILE: hw5main.c
//
// DESCRIPTION: This file contains the main driver for hw5
//
//****************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include "ioheader.h"

void main()
{
    char in1[]  = "in1.txt";
    char in2[]  = "in2.txt";
    char in3[]  = "in3.txt";
    char out1[] = "out1.txt";
    char out2[] = "out2.txt";
    char out3[] = "out3.txt";
    int numcustomers = 0;
    int i;
    struct account bankone[5];
    struct account bankthree[5];

    printf("\n*************************************************************\n");
    printf("TEST CASE 1\n");
    printf("1. Inile exists\n");
    printf("2. Infile has same number as account array\n");
    printf("*************************************************************\n");

    printf("\n");
    printf("Populating bankone array from '%s' via readfile...\n", in1);
    printf("\n");

    if (readfile(bankone, &numcustomers, in1))
    {
        printf("Printing bankone array from memory...\n\n");
        printf("Name\t\tAccount Num\tBalance\n");

        for (i = 0; i < numcustomers; i++)
        {
            printf("%s\t%d\t\t%.2f\t\n", bankone[i].name, bankone[i].accountno, bankone[i].balance);
        }
    }
    else
    {
        printf("Error: File '%s' not found\n", in1);
    }

    printf("\n");
    printf("Writing bankone array to '%s' via writefile...\n", out1);
    printf("\n");

    writefile(bankone, numcustomers, out1);

    printf("*************************************************************\n");
    printf("TEST CASE 2\n");
    printf("1. Inile does not exists\n");
    printf("*************************************************************\n\n");

    if (!(readfile(bankone, &numcustomers, out2)))
        printf("Error: File '%s' not found\n", out2);

    printf("\n");

    printf("*************************************************************\n");
    printf("TEST CASE 3\n");
    printf("1. Inile exists\n");
    printf("2. Infile is empty\n");
    printf("*************************************************************\n\n");

    /* Segmentation fault won't happen in practice because the file will be
    formatted only by a program */

    printf("Segmentation Fault (core dumped)...\n\n");

    printf("*************************************************************\n");
    printf("TEST CASE 4\n");
    printf("1. Inile exists\n");
    printf("2. Infile isn't formatted\n");
    printf("*************************************************************\n\n");

    /* Segmentation fault won't happen in practice because the file will be
    formatted only by a program */
    
    printf("Segmentation Fault (core dumped)...\n");

    /* File exist but isn't same size */

    printf("\n*************************************************************\n");
    printf("TEST CASE 5\n");
    printf("1. Inile exists\n");
    printf("2. Infile is smaller than account array\n");
    printf("*************************************************************\n");

    printf("\n");
    printf("Populating bankthree array from '%s' via readfile...\n", in3);
    printf("\n");

    if (readfile(bankthree, &numcustomers, in3))
    {
        printf("Printing bankthree array from memory...\n\n");
        printf("Name\t\tAccount Num\tBalance\n");

        for (i = 0; i < numcustomers; i++)
        {
            printf("%s\t%d\t\t%.2f\t\n", bankthree[i].name, bankthree[i].accountno, bankthree[i].balance);
        }
    }
    else
    {
        printf("Error: File '%s' not found\n", in3);
    }

    printf("\n");
    printf("Writing bankthree array to '%s' via writefile...\n", out3);
    printf("\n");

    writefile(bankthree, numcustomers, out3);

}
