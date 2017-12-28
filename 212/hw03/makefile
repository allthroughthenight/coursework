hw3: hw3main.o hw3func.o hw3dbfunc.o
	gcc -o hw3 hw3main.o hw3func.o hw3dbfunc.o

hw3main.o: hw3main.c
	gcc -c hw3main.c

hw3func.o: hw3func.c 
	gcc -c hw3func.c

hw3dbfunc.o: hw3dbfunc.c
	gcc -c hw3dbfunc.c

clean:
		rm hw3main.o hw3dbfunc.o hw3func.o
