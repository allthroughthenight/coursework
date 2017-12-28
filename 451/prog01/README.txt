Program 1:
This is a programming assignment in Java. Write a simple HTTP server application in Java. The server will just print the date and time when it receives a request and close the connection after that. You can use one of the Java socket classes.

Submit: Source code and sample output
1. Create the Java code and compile it.
2. Run it on your own machine with a  port number specificed in the command line. For example, in a Command window, type: java DaytimeServer 25000. If a service is already running on the port you choose, you will get a BindException or a similar exception.
3. In another window, use Telnet as the client program by typing a command telnet localhost 25000 . This will test that the Server application is working. Now write a simple HTTP client in Java which will connect to the Java server and print the date and time and then close the connection.
4. Now test using the Java client by typing: java DayTimeClient 25000. If you run it on your own machine, you can use port 80. On UHUnix use ports
higher than 25000.

How to Run:
$ ./run.sh <desired-port-number>
