#!/bin/bash

SERVER="httpServer"
CLIENT="httpClient"
PORT_NUMBER=$1

# compile java files
javac $SERVER.java $CLIENT.java

# start server
java $SERVER $PORT_NUMBER &

# save server pid to kill later
SERVER_PID=$!

# run client
java $CLIENT $PORT_NUMBER

# clean up class files
rm *.class

# kill server
kill $SERVER_PID
