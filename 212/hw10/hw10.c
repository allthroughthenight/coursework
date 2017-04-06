/****************************************************************
//
// HOMEWORK:    hw10
//
// CLASS:       ICS 212
//
// FILE:        hw10.c
//
// DESCRIPTION: hw10 C functions
//
//****************************************************************/

#include <jni.h>
#include <stdio.h>
#include "main.h"

JNIEXPORT float JNICALL Java_main_convertFtoC(JNIEnv *env, jobject thisObj, int fTemp)
{
	return ((fTemp - 32) * (5.0 / 9.0));
}


JNIEXPORT int JNICALL Java_main_roundUp(JNIEnv *env, jobject thisObj, int input)
{
	int remainder;
	remainder = input % 5;
	int five = 5;
	return (input + (five - remainder));
}





