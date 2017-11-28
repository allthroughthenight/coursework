#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <time.h>

int main()
{
	int cli_size;
	int connect_socket_file_descriptor;
	int on_connect;
	int listen_socket_file_descriptor;
	time_t raw_time;
	struct sockaddr_in sever_address;
	struct sockaddr_in cli_addr;
	struct tm * system_time;

	// get raw system time
	time(&raw_time);

	// parse raw system time to human readable time struct
	system_time = localtime(&raw_time);

	// set size of response
	cli_size = sizeof(cli_addr);

	// make a new socket
	listen_socket_file_descriptor = socket(AF_INET, SOCK_STREAM, 0);

	// set address to listen on all interfaces with an IPv4 address
	// formatted as a unsigned long integer
	sever_address.sin_addr.s_addr = INADDR_ANY;

	// set port number
	sever_address.sin_port = htons(8080);

	// attempt to bind socket to file descriptor, else print error and exit
	if (bind(listen_socket_file_descriptor, (struct sockaddr *) &sever_address, sizeof(sever_address)) < 0)
	{
		perror("");
		exit(1);
	}

	/**************************/
	/* Current State: CLOSED  */
	/* Event: passive open    */
	/* New State: LISTEN      */
	/**************************/
	listen(listen_socket_file_descriptor,1);

	connect_socket_file_descriptor = accept(listen_socket_file_descriptor, (struct sockaddr *) &cli_addr, &cli_size);

	/*************************************************/
	/* Current State: LISTEN                         */
	/* Event: Receive SYN, send SYN,ACK, receive ACK */
	/* New State: ESTABLISHED                        */
	/*************************************************/
	on_connect = write(connect_socket_file_descriptor, asctime(system_time), (8*sizeof(system_time)));

	/***********************************************/
	/* Current State: ESTABLISHED                  */
	/* Event: Send FIN, receive FIN, ACK, send ACK */
	/* New State: CLOSED                           */
	/***********************************************/

	return 0;
}
