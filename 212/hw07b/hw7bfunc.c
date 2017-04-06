/*****************************************************************
//
// HOMEWORK: hw7b
//
// CLASS: ICS 212
//
// FILE: hw7bmain.c
//
// DESCRIPTION: This file contains the functions for hw7b.
//
//****************************************************************/

#include "hw7bfunc.h"

extern struct tcpheader response;

/*****************************************************************
//
// Function name: readfile
//
// DESCRIPTION: A function to read a tcp header in a .bin file
//
// Parameters: char file[]: name of the file to be read
//
// Return value: always 1
//
//****************************************************************/

int readfile(char filename[])
{
	FILE * infile = fopen(filename, "r");
	response  = *((struct tcpheader *) malloc(sizeof(struct tcpheader)));

	unsigned char inputArray[20];
	unsigned short int tempInt;
	unsigned char tempChar;
	unsigned char tempChar2;
	unsigned long int tempLong;

	fread(&inputArray, 20, 1, infile);

	tempInt = inputArray[0];
	tempInt = tempInt << 8;
	tempInt = tempInt | inputArray[1];
	response.srcport = tempInt;

	tempInt = inputArray[2];
	tempInt = tempInt << 8;
	tempInt = tempInt | inputArray[3];
	response.destport = tempInt;

	tempLong = inputArray[4];
	tempLong = tempLong << 8;
	tempLong = tempLong | inputArray[5];
	tempLong = tempLong << 8;
	tempLong = tempLong | inputArray[6];
	tempLong = tempLong << 8;
	tempLong = tempLong | inputArray[7];
	response.seqnum = tempLong;

	tempLong = inputArray[8];
	tempLong = tempLong << 8;
	tempLong = tempLong | inputArray[9];
	tempLong = tempLong << 8;
	tempLong = tempLong | inputArray[10];
	tempLong = tempLong << 8;
	tempLong = tempLong | inputArray[11];
	response.acknum = tempLong;

	tempInt = inputArray[12];
	tempInt = tempInt >> 4;
	response.dataOffset = tempInt;

	tempChar  = inputArray[12];
	tempChar  = tempChar << 4;
	tempChar  = tempChar >> 2;
	tempChar2 = inputArray[13];
	tempChar2 = tempChar2 >> 6;
	tempChar  = tempChar | tempChar2;
	response.reserved = tempChar;

	tempChar = inputArray[13];
	tempChar = tempChar << 2;
	tempChar = tempChar >> 2;
	response.control = tempChar;

	tempInt = inputArray[14];
	tempInt = tempInt << 8;
	tempInt = tempInt | inputArray[15];
	response.window = tempInt;

	tempInt = inputArray[16];
	tempInt = tempInt << 8;
	tempInt = tempInt | inputArray[17];
	response.checksum = tempInt;

	tempInt = inputArray[18];
	tempInt = tempInt << 8;
	tempInt = tempInt | inputArray[19];
	response.urgpointer = tempInt;

	return 1;
}

/*****************************************************************
//
// Function name: writefile
//
// DESCRIPTION: A function to write a tcp header to a .bin file
//
// Parameters: char filename[]: the file to be written to
//
// Return value: always 1
//
//****************************************************************/

int writefile(char filename[])
{
	FILE * outFile;
	unsigned char tempChar;
	unsigned char tempChar2;
	unsigned short int tempInt;
	unsigned long int tempLong;

	tempInt             = response.srcport;
	response.srcport    = response.destport;
	response.destport   = tempInt;
	response.window     = 0;
	response.acknum     = response.seqnum;
	response.seqnum++;
	response.checksum   = 0xffff;
	response.urgpointer = 0;
	response.reserved   = 0x0;

	if ((response.control & 0x2) == 0x2)
	{
		response.control = response.control | 0x10;
	}

	outFile = fopen(filename, "w");

	tempInt  = response.srcport;
	tempInt  = tempInt >> 8;
	tempChar = tempInt;
	fwrite(&tempChar, 1, 1, outFile);

	tempInt  = response.srcport;
	tempInt  = tempInt << 8;
	tempInt  = tempInt >> 8;
	tempChar = tempInt;
	fwrite(&tempChar, 1, 1, outFile);

	tempInt  = response.destport;
	tempInt  = tempInt >> 8;
	tempChar = tempInt;
	fwrite(&tempChar, 1, 1, outFile);

	tempInt  = response.destport;
	tempInt  = tempInt << 8;
	tempInt  = tempInt >> 8;
	tempChar = tempInt;
	fwrite(&tempChar, 1, 1, outFile);

	tempLong = response.seqnum;
	tempLong = tempLong >> 24;
	tempChar = tempLong;
	fwrite(&tempChar, 1, 1, outFile);

	tempLong = response.seqnum;
	tempLong = tempLong << 8;
	tempLong = tempLong >> 24;
	tempChar = tempLong;
	fwrite(&tempChar, 1, 1, outFile);

	tempLong = response.seqnum;
	tempLong = tempLong << 16;
	tempLong = tempLong >> 24;
	tempChar = tempLong;
	fwrite(&tempChar, 1, 1, outFile);

	tempLong = response.seqnum;
	tempLong = tempLong << 24;
	tempLong = tempLong >> 24;
	tempChar = tempLong;
	fwrite(&tempChar, 1, 1, outFile);

	tempLong = response.acknum;
	tempLong = tempLong >> 24;
	tempChar = tempLong;
	fwrite(&tempChar, 1, 1, outFile);

	tempLong = response.acknum;
	tempLong = tempLong << 8;
	tempLong = tempLong >> 24;
	tempChar = tempLong;
	fwrite(&tempChar, 1, 1, outFile);

	tempLong = response.acknum;
	tempLong = tempLong << 16;
	tempLong = tempLong >> 24;
	tempChar = tempLong;
	fwrite(&tempChar, 1, 1, outFile);

	tempLong = response.acknum;
	tempLong = tempLong << 24;
	tempLong = tempLong >> 24;
	tempChar = tempLong;
	fwrite(&tempChar, 1, 1, outFile);

	tempChar  = response.dataOffset;
	tempChar  = tempChar << 4;
	tempChar2 = response.reserved;
	tempChar2 = tempChar2 >> 2;
	tempChar  = tempChar | tempChar2;
	fwrite(&tempChar, 1, 1, outFile);

	tempChar = response.reserved;
	tempChar =- tempChar << 6;
	tempChar = tempChar | response.control;
	fwrite(&tempChar, 1, 1, outFile);

	tempInt  = response.window;
	tempInt  = tempInt >> 8;
	tempChar = tempInt;
	fwrite(&tempChar, 1, 1, outFile);

	tempInt  = response.window;
	tempInt  = tempInt << 8;
	tempInt  = tempInt >> 8;
	tempChar = tempInt;
	fwrite(&tempChar, 1, 1, outFile);

	tempInt  = response.checksum;
	tempInt  = tempInt >> 8;
	tempChar = tempInt;
	fwrite(&tempChar, 1, 1, outFile);

	tempInt  = response.checksum;
	tempInt  = tempInt << 8;
	tempInt  = tempInt >> 8;
	tempChar = tempInt;
	fwrite(&tempChar, 1, 1, outFile);

	tempInt  = response.urgpointer;
	tempInt  = tempInt >> 8;
	tempChar = tempInt;
	fwrite(&tempChar, 1, 1, outFile);

	tempInt  = response.urgpointer;
	tempInt  = tempInt << 8;
	tempInt  = tempInt >> 8;
	tempChar = tempInt;
	fwrite(&tempChar, 1, 1, outFile);

	fclose(outFile);

	return 1;
}

/*****************************************************************
//
// Function name: printheader
//
// DESCRIPTION: A function to print a tcp header strut
//
// Parameters: N/A
//
// Return value: always 1
//
//****************************************************************/

int printheader()
{
	printf("Source Port:\t\t%u\n",           response.srcport);
	printf("Destination Port:\t%u\n",        response.destport);
	printf("Sequence Number:\t%lu\n",        response.seqnum);
	printf("Acknowledgement Number:\t%lu\n", response.acknum);
	printf("Data Offset:\t\t%u\n",           response.dataOffset);
	printf("Reserved bits:\t\t%u\n",         response.reserved);

	if ((response.control & 0x20) == 0x20)
	{
		printf("URGON:\t\t\tON\n");
	}
	else
	{
		printf("URGON:\t\t\tOFF\n");
	}

	if ((response.control & 0x10) == 0x10)
	{
		printf("ACK:\t\t\tON\n");
	}
	else
	{
		printf("ACK:\t\t\tOFF\n");
	}

	if ((response.control & 0x8) == 0x8)
	{
		printf("PSH:\t\t\tON\n");
	}
	else
	{
		printf("PSH:\t\t\tOFF\n");
	}

	if ((response.control & 0x4) == 0x4)
	{
		printf("RST:\t\t\tON\n");
	}
	else
	{
		printf("RST:\t\t\tOFF\n");
	}

	if ((response.control & 0x2) == 0x2)
	{
		printf("SYN:\t\t\tON\n");
	}
	else
	{
		printf("SYN:\t\t\tOFF\n");
	}

	if ((response.control & 0x1) == 0x1)
	{
		printf("FIN:\t\t\tON\n");
	}
	else
	{
		printf("FIN:\t\t\tOFF\n");
	}

	printf("Window Number:\t\t%u\n",       response.window);
	printf("Checksum Number:\t%x\n",       response.checksum);
	printf("Urgent Pointer Number:\t%u\n", response.urgpointer);

	return 1;
}
