#include <arpa/inet.h>
#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include "functions.c"

char* file_arr;
char* filename;
char* server;
FILE* file;
int numread;
int port;
int rcvd;
int sent;
int sockfd;
long filesize;

char ack[1];
char data[1501];
int seq_counter = 1;
float bytes_sent = 0;

struct sockaddr_in sin;

int main (int argc, char ** argv)
{

	port = 20000;
	server = "127.0.0.1";
	filename = argv[1];

	if (argc < 2)
	{
		printf("ERROR: Usage <prog> <path-to-file>");
		exit(1);
	}

	// set up
	filesize = file_size(filename);
	file_arr = malloc(filesize);
	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
	socklen_t sin_len = sizeof (sin);
	socklen_t * sin_lenp = &sin_len;
	sin.sin_family = AF_INET;
	inet_aton(server, &(sin.sin_addr));
	sin.sin_port = htons (port);
	file = fopen(filename,"r");

	while(!feof(file))
	{
		printf("\n");
		data[0] = (char) (((int) '0') + (seq_counter % 2));
		numread = fread
				(
					data + 1,
					sizeof(char),
					1500,
					file
				);

		printf("Sending KBs: %.1f - %.1f\n", bytes_sent, bytes_sent + 1.5);
		sent = sendto(sockfd,
				data,
				numread + 1,
				0,
				(struct sockaddr *) &sin,
				sin_len);

		rcvd = recvfrom(sockfd,
				ack,
				sizeof(ack),
				0,
				(struct sockaddr *) &sin,
				sin_lenp);
		printf("Received ACK for sequence #: %.0f\n",  bytes_sent + 1.5);

		seq_counter++;
		bytes_sent += 1.5;
		//sleep(1);
	}

	printf
	(
	 	"\n--------------------------\n"
		"Transfer complete\n"
		"File size: %.1f KBs\n"
		"Packets sent: %d\n"
	 	"--------------------------\n",
		bytes_sent,
		seq_counter
	);
}
