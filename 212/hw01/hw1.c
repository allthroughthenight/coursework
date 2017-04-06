/****************************************************************
//
// HOMEWORK:    hw1
//
// CLASS:       ICS 212
//
// FILE:        hw1.c
//
// DESCRIPTION: Driver and user-interface functions for Homework 1
//
//****************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void tempIn();
void printTemp(int);
float convertFtoC(int);

main()
{
   printf("\n");
   printf("Tempurature convertion table v1.0\n");
   printf("\n");
   tempIn();
}

/*****************************************************************
//
// Function name: tempIn
//
// DESCRIPTION: A userinterface function to obtains the Fahrenheit value of from the user
//
// Parameters: N/A
//
// Return values: void
//
//****************************************************************/

/* Excersise 1: User input */

void tempIn()
{
   int answer;
   int temp;

   do
   {
      printf("Please enter a maxmimum tempurature in Fahrenheit (F): \n");
      scanf("%d", &temp);

      if (temp >0)
      {
         printTemp(temp);
         answer = 1;
      }
      else
      {
         printf("Only numerical values greater than 0 are allowed\n");
         answer = 0;
      }
   } while (answer != 1);
}

/*****************************************************************
//
// Function name: convertFtoC
//
// DESCRIPTION: A function to convert a given Fahrenheit value to Celcius
//
// Parameters: tempF (int): contains the value to be converted
//
// Return value: C (float): the converted value
//
//****************************************************************/

/* Excersise 1: conversion function */

float convertFtoC(int tempF)
{
   float C = (tempF - 32) * (0.55556);
   return C;
}

/*****************************************************************
//
// Function name: printTemp
//
// DESCRIPTION: A function to print out a table of Fahrenheit and Celcius values in multiples of 5
//
// Parameters: tempIn (int): contains the value to be printed in Fahrenheit
//
// Return value: void
//
//****************************************************************/

/* Excersise 1: Formatted Table */

void printTemp(int tempIn)
{
   int  tempRange = tempIn;
   int  multOf5   = tempIn % 5;

   if(multOf5 != 0)
   {
      tempRange = (tempRange - multOf5) + 5;
   }

   printf("Temperature in F\tTemperature in C\n");
   int i;
   int startTemp = 0;

   for (i = 0; i < 1 + (tempRange / 5); i++)
   {
      printf("        %8d \t        %8.2f\n", startTemp, convertFtoC( startTemp));
      startTemp += 5;
   }
}
