/****************************************************************
//
// FILE:        animal.h
//
// DESCRIPTION: Animal parent class header
//
//****************************************************************/

#ifndef ANIMAL_H
#define ANIMAL_H

#include <string>

using namespace std;

class Animal
{
   protected:
      string sound;
      unsigned int numLegs;

   public:
      Animal();
      void displayanimaldata(Animal *);
      virtual void displaydata()=0 ;
};

#endif
