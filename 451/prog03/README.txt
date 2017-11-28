Program 3:
Enhance the C client/server program to do the following; Once the connection is established, you are going send data from the client to the server and back simulating a TCP handshake. For example, send a TCP header of 20 bytes and your data on the real TCP connection with a SYN flag set. The server should respond back with SYN_ACK and the client should complete the 3-way handshake.

You will need the following fields in the “fake” TCP header:
1. Source TCP port number – Use a C function call to get this
2. Destination TCP port number – The real port you are connecting to
3. Sequence number – Create a random Initial Sequence Number
4. Acknowledgment number - You should use the appropriate value
5. TCP data offset - Make it all zeros for now
6. Reserved data – Make it all zeros for now
7. Control flags – flags should be set correctly for the 3-way handshake using bitwise operators
8. Window size – Use a reasonable default value from the RFC
9. TCP checksum – Make it all ffffs for now
10. Urgent pointer – Make it all zeros

To Run:
$ make
