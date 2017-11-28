#! /bin/bash

make
./server &
sleep 3
telnet 127.0.0.1 8080
make clean
