/*****************************************************************
//
// HOMEWORK: hw3
//
// CLASS: ICS 212
//
// FILE: record.h
//
// DESCRIPTION: This file contains the struct defenition of record for hw3
//
//****************************************************************/

struct record
{
    int                accountno;
    char               name[25];
    char               address[80];
    int                yearofbirth;
    struct record *    next;
};
