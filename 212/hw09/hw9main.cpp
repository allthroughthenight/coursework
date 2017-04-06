/****************************************************************
//
// HOMEWORK:    hw9
//
// CLASS:       ICS 212
//
// FILE:        hw9main.cpp
//
// DESCRIPTION: Main driver method
//
//****************************************************************/

#include <iostream>
#include "animal.h"
#include "human.h"
#include "dog.h"
#include "cat.h"
#include <vector>
#include <map>

using namespace std;

int main(int argc, char *argv[]){

      Dog   dog1;
      Dog   dog2;
      Human human1;
      Human human2;
      Cat   cat1;
      Cat   cat2;

      int iterator = 0;
      Animal * animal1 = &dog1;
      Animal * animal2 = &dog2;
      Animal * animal3 = &human1;
      Animal * animal4 = &human2;
      Animal * animal5 = &cat1;
      Animal * animal6 = &cat2;

      vector<Animal*> animal_vector;

      animal_vector.push_back(animal1);
      animal_vector.push_back(animal2);
      animal_vector.push_back(animal3);

      map<char, Animal*> animal_map;

      animal_map['D'] = animal4;
      animal_map['H'] = animal5;
      animal_map['C'] = animal6;

      dog1.displayanimaldata(animal1);
      human1.displayanimaldata(animal3);
      cat1.displayanimaldata(animal5);


}
