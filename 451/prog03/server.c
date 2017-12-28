#include <netdb.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <time.h>
#include "functions.c"

int main(int argc, char *argv[])
{
	int clilen;
	int n;
	int newsockfd;
	int portno;
	int sockfd;
	unsigned char tcp_header[20];
	//unsigned char tcp_header[20] =
	struct sockaddr_in cli_addr;
	struct sockaddr_in serv_addr;

	if (argc < 2) {
		fprintf(stderr,"ERROR, no port provided\n");
		exit(1);
	}

	sockfd = socket(AF_INET, SOCK_STREAM, 0);

	if (sockfd < 0)
	{
		error("ERROR opening socket");
	}

	bzero((char *) &serv_addr, sizeof(serv_addr));

	portno = atoi(argv[1]);

	serv_addr.sin_family = AF_INET;
	serv_addr.sin_addr.s_addr = INADDR_ANY;
	serv_addr.sin_port = htons(portno);


		if (bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0)
		{
			error("ERROR on binding");
		}

	while(1)
	{
		listen(sockfd,5);
		clilen = sizeof(cli_addr);
		newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, &clilen);

		if (newsockfd < 0)
		{
			error("ERROR on accept");
		}

		/**************************/
		/* Current State: CLOSED  */
		/* Event: passive open    */
		/* New State: LISTEN      */
		/**************************/

		// listen for syn
		n = read(newsockfd,tcp_header,20);

		if (n < 0)
		{
			error("ERROR reading from socket");
		}

		printf("\n**Server**\n");

		printf("\n---Received SYN---\n");
		printf("Source Port: %d\n", tcp_header[2], tcp_header[3]);
		printf("Destination Port: %d\n", tcp_header[0], tcp_header[1]);
		printf("Sequence Number: %d\n",tcp_header[4], tcp_header[7]);
		printf("Acknoledgement Numer: %d\n",tcp_header[8],tcp_header[11]);
		printf("Offset and Reserve: %x\n",tcp_header[12]);
		printf("Flags: %x\n",tcp_header[13]);
		printf("Window Size: %d\n",tcp_header[14],tcp_header[15]);
		printf("Checksum and Urgent: %d\n",tcp_header[16],tcp_header[20]);


		// increment sequence number
		tcp_header[4] += 1;

		// set syn ack
		tcp_header[13] = tcp_header[13] ^ 0x10;

		printf("\n---Sent SYN ACK---\n");
		printf("Source Port: %d\n", tcp_header[2], tcp_header[3]);
		printf("Destination Port: %d\n", tcp_header[0], tcp_header[1]);
		printf("Sequence Number: %d\n",tcp_header[4], tcp_header[7]);
		printf("Acknoledgement Numer: %d\n",tcp_header[8],tcp_header[11]);
		printf("Offset and Reserve: %x\n",tcp_header[12]);
		printf("Flags: %x\n",tcp_header[13]);
		printf("Window Size: %d\n",tcp_header[14],tcp_header[15]);
		printf("Checksum and Urgent: %d\n",tcp_header[16],tcp_header[20]);

		// send syn ack
		n = write(newsockfd,tcp_header,20);

		/**************************************/
		/* Current State: LISTEN              */
		/* Event: receive SYN, send SYN + ACK */
		/* New State: SYN_RVCD                */
		/**************************************/

		if (n < 0)
		{
			error("ERROR writing to socket");
		}

		if (newsockfd < 0)
		{
			error("ERROR on accept");
		}

		// listen for ack
		n = read(newsockfd,tcp_header,20);

		if (n < 0)
		{
			error("ERROR reading from socket");
		}

		printf("\n---Received ACK---\n");
		printf("Source Port: %d\n", tcp_header[2], tcp_header[3]);
		printf("Destination Port: %d\n", tcp_header[0], tcp_header[1]);
		printf("Sequence Number: %d\n",tcp_header[4], tcp_header[7]);
		printf("Acknoledgement Numer: %d\n",tcp_header[8],tcp_header[11]);
		printf("Offset and Reserve: %x\n",tcp_header[12]);
		printf("Flags: %x\n",tcp_header[13]);
		printf("Window Size: %d\n",tcp_header[14],tcp_header[15]);
		printf("Checksum and Urgent: %d\n",tcp_header[16],tcp_header[20]);

		// increment sequence number
		tcp_header[4] += 1;

		// send ack
		n = write(newsockfd,tcp_header,20);

		/***************************/
		/* Current State: SYN_RVCD */
		/* Event: receive ACK      */
		/* New State: ESTABLISHED  */
		/***************************/

		if (n < 0)
		{
			error("ERROR writing to socket");
		}

		printf("\n\n**Handshake Complete**\n\n");
	}

	return 0;
}
