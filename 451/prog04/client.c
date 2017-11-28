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


char* file_name;
char* ip_addr;
FILE* fp;
int port_no;
int rcvd;
int seq;
int sockfd;

int seq_counter = 1;
float bytes_sent = 0;
char ack[1];
char data[1501];

struct sockaddr_in sin;
struct sockaddr * sock_addr;

int main (int argc, char ** argv) {

	port_no = 20000;
	ip_addr = "127.0.0.1";
	file_name = argv[1];

	if (argc < 2)
	{
		printf("ERROR: Usage <prog> <file-name>");
		exit(1);
	}

	// set up
	fp = fopen(file_name, "wb");
	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
	socklen_t sin_len = sizeof(sin);
	socklen_t * sin_lenp = &sin_len;
	sin.sin_family = AF_INET;
	inet_aton(ip_addr, &(sin.sin_addr));
	sin.sin_port = htons (port_no);
	sock_addr = (struct sockaddr *) (&sin);
	bind(sockfd, sock_addr, sizeof (sin));

	while (1)
	{
		printf("\n");
		rcvd = recvfrom
			(
				sockfd,
				data,
				sizeof(data),
				0,
				(struct sockaddr *) &sin,
				sin_lenp
			);

		printf("Received KBs: %.1f - %.1f\n", bytes_sent, bytes_sent + 1.5);
		seq = (int) (data[0]-'0');

		fwrite
			(
				data+1,
				sizeof(char),
				rcvd-1,
				fp
			);

		ack[0] = (char)(((int)'2')+(seq%2));

		sendto
			(
				sockfd,
				ack,
				sizeof(ack),
				0,
				(struct sockaddr *) &sin,
				sin_len
			);

		printf("Sent ACK for sequence #: %.0f\n", bytes_sent);

		if (rcvd < 1500)
		{
			break;
		}

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
