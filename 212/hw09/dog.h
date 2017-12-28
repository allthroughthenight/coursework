/****************************************************************
//
// FILE:        dog.h
//
// DESCRIPTION: Dog child class header
//
//****************************************************************/

#ifndef DOG_H
#define DOG_H

#include "animal.h"

class Dog: public Animal {
   public:
     Dog();
     void setSound();
     void setLegs();
     void displaydata(void);
};

#endif
