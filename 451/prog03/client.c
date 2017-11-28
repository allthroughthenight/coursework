#include <netdb.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include "functions.c"

int main(int argc, char *argv[])
{
	int n;
	int portno;
	int sockfd;
	unsigned char tcp_header[20];
	struct sockaddr_in serv_addr;
	struct hostent *server;

	srand(time(NULL));   // should only be called once
	int r = rand();      // returns a pseudo-random integer between 0 and RAND_MAXkkj

	if (argc < 3) {
		fprintf(stderr,"usage %s hostname port\n", argv[0]);
		exit(0);
	}

	portno = atoi(argv[2]);
	sockfd = socket(AF_INET, SOCK_STREAM, 0);

	if (sockfd < 0)
	{
		error("ERROR opening socket");
	}

	server = gethostbyname(argv[1]);

	if (server == NULL) {
		fprintf(stderr,"ERROR, no such host\n");
		exit(0);
	}

	bzero((char *) &serv_addr, sizeof(serv_addr));
	serv_addr.sin_family = AF_INET;

	bcopy((char *)server->h_addr, (char *)&serv_addr.sin_addr.s_addr, server->h_length);
	serv_addr.sin_port = htons(portno);

	if (connect(sockfd,(struct sockaddr *)&serv_addr,sizeof(serv_addr)) < 0)
	{
		error("ERROR connecting");
	}

	// source port
	tcp_header[0] = 1;

	// destination port
	tcp_header[2] = portno;

	// sequence number
	tcp_header[4] = r;

	// acknowledgement number
	tcp_header[8] = 0x00000000;

	// header length, reserve bits, and flags
	tcp_header[12] = 0x00;

	// flags
	tcp_header[13] = 0x02;

	// window size, default 0x4470. source: https://tinyurl.com/zy4qxyh
	tcp_header[14] = 0x4470;

	// checksum and urgent pointer
	tcp_header[16] = 0xffffffff;

	while(1)
	{

		printf("\n**Client**\n");

		printf("\n---Sent SYN---\n");
		printf("Source Port: %d\n", tcp_header[0], tcp_header[1]);
		printf("Destination Port: %d\n", tcp_header[2], tcp_header[3]);
		printf("Sequence Number: %d\n",tcp_header[4], tcp_header[7]);
		printf("Acknoledgement Numer: %d\n",tcp_header[8],tcp_header[11]);
		printf("Offset and Reserve: %x\n",tcp_header[12]);
		printf("Flags: %x\n",tcp_header[13]);
		printf("Window Size: %d\n",tcp_header[14],tcp_header[15]);
		printf("Checksum and Urgent: 0x%x\n",tcp_header[16],tcp_header[20]);

		// send syn
		n = write(sockfd,tcp_header,sizeof(tcp_header));

		/**************************/
		/* Current State: CLOSED  */
		/* Event: active open     */
		/* New State: SYN_SENT    */
		/**************************/

		if (n < 0)
		{
			error("ERROR writing to socket");
		}

		// listen for syn ack
		n = read(sockfd,tcp_header,20);

		if (n < 0)
		{
			error("ERROR reading from socket");
		}


		printf("\n---Recived SYN ACK---\n");
		printf("Source Port: %d\n", tcp_header[0], tcp_header[1]);
		printf("Destination Port: %d\n", tcp_header[2], tcp_header[3]);
		printf("Sequence Number: %d\n",tcp_header[4], tcp_header[7]);
		printf("Acknoledgement Numer: %d\n",tcp_header[8],tcp_header[11]);
		printf("Offset and Reserve: %x\n",tcp_header[12]);
		printf("Flags: %x\n",tcp_header[13]);
		printf("Window Size: %d\n",tcp_header[14],tcp_header[15]);
		printf("Checksum and Urgent: %d\n",tcp_header[16],tcp_header[20]);

		// unset syn ack
		tcp_header[13] = tcp_header[13] & 0xed;

		// set ack
		tcp_header[13] = tcp_header[13] ^ 0x10;

		n = write(sockfd,tcp_header,sizeof(tcp_header));

		printf("\n---Sent SYN---\n");
		printf("Source Port: %d\n", tcp_header[0], tcp_header[1]);
		printf("Destination Port: %d\n", tcp_header[2], tcp_header[3]);
		printf("Sequence Number: %d\n",tcp_header[4], tcp_header[7]);
		printf("Acknoledgement Numer: %d\n",tcp_header[8],tcp_header[11]);
		printf("Offset and Reserve: %x\n",tcp_header[12]);
		printf("Flags: %x\n",tcp_header[13]);
		printf("Window Size: %d\n",tcp_header[14],tcp_header[15]);
		printf("Checksum and Urgent: %x\n",tcp_header[16],tcp_header[20]);

		/**************************************/
		/* Current State: SYN_SENT            */
		/* Event: receive SYN + ACK, send ACK */
		/* New State: ESTABLISHED             */
		/**************************************/

		if (n < 0)
		{
			error("ERROR writing to socket");
		}

		n = read(sockfd,tcp_header,20);

		if (n < 0)
		{
			error("ERROR reading from socket");
		}

		printf("\n\n**Connection Established**\n\n");
}

return 0;

}
