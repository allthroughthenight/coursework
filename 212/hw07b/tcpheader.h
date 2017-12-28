/*****************************************************************
//
// FILE: tcpheader.h
//
// DESCRIPTION: This file contains the the struct for a tcpheader.
//
//****************************************************************/

struct tcpheader{
	unsigned short int srcport;
	unsigned short int destport;
	unsigned long  int seqnum;
	unsigned long  int acknum;
	unsigned char      control;
	unsigned char      reserved;
	unsigned char      dataOffset;
	unsigned short int window;
	unsigned short int checksum;
	unsigned short int urgpointer;
};
