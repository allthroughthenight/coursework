Program 4:
Enhance the C client/server Program  3  to do the following:
After the simulated TCP  connection is established, the service will open a jpg file of your choice, read it and send it in 1500 bytes chunks. The client will acknowledge each packet. The server will initiate the FIN after the last ACK is received. In addition to the requirements for the TCP handshake from Program 3, this version will  have the following enhancements:

+ Number every packet sent according to the sequence number of the first byte it  contains.
+ Store this packet in a transmission buffer.  Design a link ed list to do this.
+ When the ACK arrives remove the corresponding packet from the transmission  buffer.

Use the following fields for each data packet:
1. Source TCP port number
2. Destination TCP port number
3. Sequence number
4. Acknowledgment number
5. TCP data offset - Make it all zeros for now
6. Reserved data - Make it all zeros for now
7. Control flags - flags should be set correctly as needed
8. Window size - Use 1500
9. TCP checksum - Make it all Fs for now
10. Urgent pointer - Make it all zero

To Run:
$ ./sudo-make
