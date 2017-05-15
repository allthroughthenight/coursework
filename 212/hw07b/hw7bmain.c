/*****************************************************************
//
// FILE: hw7bmain.c
//
// DESCRIPTION: This file contains the driver and functions for hw7b.
//
//****************************************************************/

#include "hw7bfunc.h"

struct tcpheader * response;

int main(int argc, char * argv[]){

	char test[]  = "test.bin";
	char test1[] = "test1.bin";
	char test2[] = "test2.bin";

	printf("*************************************\n");
	readfile(test);
	printf("---test.bin Header---\n");
	printheader();

	printf("---Response---\n");
	writefile("testresponse.bin");
	readfile("testresponse.bin");
	printheader();

	printf("*************************************\n");
	readfile(test1);
	printf("---test1.bin Header---\n");
	printheader();

	printf("---Response---\n");
	writefile("test1response.bin");
	readfile("test1response.bin");
	printheader();

	printf("*************************************\n");
	readfile(test2);
	printf("---test2.bin Header---\n");
	printheader();

	printf("---Response---\n");
	writefile("test2response.bin");
	readfile("test2response.bin");
	printheader();

	return 0;
}
