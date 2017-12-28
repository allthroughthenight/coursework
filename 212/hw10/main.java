/****************************************************************
//
// FILE:        main.java
//
// DESCRIPTION: main driver java method
//
//****************************************************************/

import java.util.Scanner;


public class main
{
public static native int roundUp(int num);
public static native float convertFtoC(int fTemp);

    public static void main(String[] args)
    {
        System.loadLibrary("A10");
        Scanner keybd = new Scanner(System.in);
	int maxTemp = -1;
	while (maxTemp < 0)
	{
            System.out.print("Please enter a temperature to convert: ");
            maxTemp = keybd.nextInt();
	    if (maxTemp < 0)
	    {
                System.out.println("Temperature input must be greater than 0, please try again.");
	    }
	    keybd.nextLine();
	}
        if (maxTemp % 5 != 0)
        {
            maxTemp = roundUp(maxTemp);
        }
        printTable(maxTemp);

    }

    public static void printTable(int fTemp)
    {
        int fiveIncrement = 0;
	float convertedFloat = 0;
        System.out.println("Temperature in F\tTemperature in C");
        while (fiveIncrement <= fTemp)
        {
	    convertedFloat = convertFtoC(fiveIncrement);
            System.out.format("%.2f \t\t%.2f\n", (float) fiveIncrement, convertedFloat);
            fiveIncrement += 5;
        }
    }
}
