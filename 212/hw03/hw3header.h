/*****************************************************************
//
// FILE: hw3header.c
//
// DESCRIPTION: This file contains fucntions prototypes for hw3
//
//****************************************************************/

#include "record.h"

int  addRecord      (struct record **, int, char[],char[],int);
int  printRecord    (struct record *,  int);
int  modifyRecord   (struct record *,  int, char[]);
int  deleteRecord   (struct record **, int);
void printAllRecords(struct record *);
void getfield(char[], int);
