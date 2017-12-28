SERVER=server
CLIENT=client
GCC=gcc
FLAGS=-w -o

goal: $(CLIENT) $(SERVER)

$(CLIENT): $(CLIENT).c
	$(GCC) $(FLAGS) $(CLIENT) $(CLIENT).c

$(SERVER): $(SERVER).c
	$(GCC) $(FLAGS) $(SERVER) $(SERVER).c

clean:
	rm $(SERVER) $(CLIENT)
