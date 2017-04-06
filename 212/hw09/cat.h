/****************************************************************
//
// HOMEWORK:    hw9
//
// CLASS:       ICS 212
//
// FILE:        cat.h
//
// DESCRIPTION: Cat child class header
//
//****************************************************************/

#ifndef ASSASSIN_H
#define ASSASSIN_H

#include "animal.h"

class Cat: public Animal {
   public:
      Cat();
      void setSound();
      void setLegs();
      void displaydata(void);
};

#endif
