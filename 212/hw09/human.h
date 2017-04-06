/****************************************************************
//
// HOMEWORK:    hw9
//
// CLASS:       ICS 212
//
// FILE:        human.h
//
// DESCRIPTION: Human child class header
//
//****************************************************************/

#ifndef HUMAN_H
#define HUMAN_H

#include "animal.h"

class Human: public Animal {
   public:
      Human();
      void setSound();
      void setLegs();
      void displaydata(void);
};

#endif
