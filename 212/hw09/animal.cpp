/****************************************************************
//
// FILE:        animal.cpp
//
// DESCRIPTION: Animal parent class
//
//****************************************************************/

#include "animal.h"
#include <iostream>

Animal::Animal()
{
   sound = "Animal Noises";
   numLegs = 0;
}

void Animal::displayanimaldata(Animal * a)
{
   a->displaydata();
}
