/*****************************************************************
//
// HOMEWORK: hw3
//
// CLASS: ICS 212
//
// FILE: hw3header.c
//
// DESCRIPTION: This file contains fucntions prototypes for hw3
//
//****************************************************************/

#include "record.h"

class llist
{
  private:
    record *        start = NULL;
    char            filename[16];
    int             readfile();
    int             writefile();
    record *        reverse(record * );
    void            cleanup();

  public:
    llist();
    llist(char[]);
    ~llist();
    int addRecord (int, char[], char[], int);
    int printRecord (int);
    int modifyRecord (int, char[]);
    void printAll();
    int deleteRecord(int);
    void reverse();
    void getfield(char[], int);
};
