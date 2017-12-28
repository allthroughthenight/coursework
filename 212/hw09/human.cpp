/****************************************************************
//
// FILE:        human.ccp
//
// DESCRIPTION: Human child class
//
//****************************************************************/

#include <string>
#include <iostream>
#include "human.h"

using namespace std;

/*****************************************************************
//
// Function name: Human()
//
// DESCRIPTION: Human constructor
//
// Parameters: N/A
//
//****************************************************************/

Human::Human(){
    numLegs = 2;
    sound = "hello";
}

/*****************************************************************
//
// Function name: displaydata(void)
//
// DESCRIPTION: Display the data of the given human
//
// Parameters: N/A
//
// Return values: N/A
//
//****************************************************************/

void Human::displaydata(void){
    cout << "The Human says "<< sound << "\n";
    cout << "The Human has " << numLegs << " legs\n";
}
