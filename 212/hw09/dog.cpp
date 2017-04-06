/****************************************************************
//
// HOMEWORK:    hw9
//
// CLASS:       ICS 212
//
// FILE:        dog.cpp
//
// DESCRIPTION: dog child class
//
//****************************************************************/

#include <string>
#include <iostream>
#include "dog.h"

using namespace std;

/*****************************************************************
//
// Function name: Dog()
//
// DESCRIPTION: Dog constructor
//
// Parameters: N/A
//
//****************************************************************/

Dog::Dog(){
    numLegs = 4;
    sound = "bark";
}

/*****************************************************************
//
// Function name: displaydata()
//
// DESCRIPTION: Displays the data of the given dog
//
// Parameters: N/A
//
// Return values: N/A
//
//****************************************************************/

void Dog::displaydata(void){
  cout << "The Dog says "<< sound <<"\n";
  cout << "The Dog has "<< numLegs <<" legs"<< "\n";
}
