/****************************************************************
//
// HOMEWORK:    hw9
//
// CLASS:       ICS 212
//
// FILE:        cat.cpp
//
// DESCRIPTION: Cat child class
//
//****************************************************************/

#include <string>
#include <iostream>
#include "cat.h"
using namespace std;

/*****************************************************************
//
// Function name: Catt()
//
// DESCRIPTION: Cat constructor
//
// Parameters: N/A
//
// Return values: N/A
//
//****************************************************************/

Cat::Cat(){
    numLegs = 4;
    sound = "meow";
}

/*****************************************************************
//
// Function name: displaydata(void)
//
// DESCRIPTION: Displays the data of the given cat
//
// Parameters: N/A
//
// Return values: N/A
//
//****************************************************************/

void Cat::displaydata(void){
  cout << "The Cat says "<< sound<<"\n";
  cout << "The Cat has "<< numLegs <<" legs"<< "\n";
}
