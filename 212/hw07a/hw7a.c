/*****************************************************************
//
// FILE: hw7a.c
//
// DESCRIPTION: This file contains the driver and functions for hw7a.
//
//****************************************************************/

#include <stdio.h>
#include <math.h>

int costofpainting(double);

void main()
{
    printf("Paint Calcuelator v1.0\n");

    printf("Distance: 0\tCost: $%i\n",     costofpainting(0));
    printf("Distance: 1\tCost: $%i\n",     costofpainting(1));
    printf("Distance: 2\tCost: $%i\n",     costofpainting(2));
    printf("Distance: 3\tCost: $%i\n",     costofpainting(3));
    printf("Distance: 4\tCost: $%i\n",     costofpainting(4));
    printf("Distance: 0.001\tCost: $%i\n", costofpainting(0.001));
    printf("Distance: 1.1\tCost: $%i\n",   costofpainting(1.1));
    printf("Distance: 2.22\tCost: $%i\n",  costofpainting(2.22));
    printf("Distance: 3.333\tCost: $%i\n", costofpainting(3.333));
    printf("Distance: 50\tCost: $%i\n",    costofpainting(50));
    printf("Distance: 100\tCost: $%i\n",   costofpainting(100));
    printf("Distance: 99999\tCost: $%i\n", costofpainting(99999));

}


/*****************************************************************
//
// Function name: costofpainting
//
// DESCRIPTION: A recursive method to compute the cost of painting a road
//
// Parameters: double lenth: length of road to compute cost of
//
// Return value: cost of painting
//
//****************************************************************/

int costofpainting(double length)
{
    int cost = 0;

    if (length <= 0)
    {
        cost = 0;
    }
    else
    {
        if (length > 2)
        {
            return cost = 100 + 200 + costofpainting(length/3);
        }
        else
        {
            return 200;
        }
    }
    return cost;
}
