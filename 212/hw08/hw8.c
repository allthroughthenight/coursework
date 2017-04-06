/****************************************************************
//
// HOMEWORK:    hw8
//
// CLASS:       ICS 212
//
// INSTRUCTOR:  Ravi Narayan
//
// DATE:        Janurary 24, 2016
//
// FILE:        hw8.c
//
// DESCRIPTION: Driver and user-interface functions for Homework 8
//
//****************************************************************/

#include <stdlib.h>
#include <math.h>
#include <iostream>

using namespace std;

void  tempIn();
void  printTemp(int);
float convertFtoC(int);

main()
{
   cout << "\n";
   cout << "Tempurature convertion table v1.0\n";
   cout << "\n";
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
      cout << "Please enter a maxmimum tempurature in Fahrenheit (F): \n";
      cin >> temp;

      if (temp >0)
      {
         printTemp(temp);
         answer = 1;
      }
      else
      {
         cout << "Only numerical values greater than 0 are allowed\n";
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
    float a = 5;
    float b = 9;
    float C = (tempF - 32) * (a / b);
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
   int tempRange = tempIn;
   int multOf5   = tempIn % 5;

   if(multOf5 != 0)
   {
      tempRange = (tempRange - multOf5) + 5;
   }

   cout << "Temperature in F\tTemperature in C\n";
   int i;
   int startTemp = 0;

   for (i = 0; i < 1 + (tempRange / 5); i++)
   {
      cout.width(15);
      cout << "     " << startTemp << "\t\t  " << floor(convertFtoC(startTemp)*100)/100 << "\n";
      startTemp += 5;
      int n = -77;
   }
}
