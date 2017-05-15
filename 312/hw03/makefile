EX1=hw3_ex1
EX2=hw3_ex2
CC=gcc
CFLAGS=-m32
ASM=nasm
ASMFLAGS=-f elf

all: $(EX1) $(EX2)

$(EX1): $(EX1).o driver.o asm_io.o
	$(CC) $(CFLAGS) $(EX1).o driver.o asm_io.o -o $(EX1)

$(EX1).o: $(EX1).asm
	$(ASM) $(ASMFLAGS) $(EX1).asm -o $(EX1).o

$(EX2): $(EX2).o driver.o asm_io.o
	$(CC) $(CFLAGS) $(EX2).o driver.o asm_io.o -o $(EX2)

$(EX2).o: $(EX2).asm
	$(ASM) $(ASMFLAGS) $(EX2).asm -o $(EX2).o

asm_io.o: asm_io.asm
	$(ASM) $(ASMFLAGS) -d ELF_TYPE asm_io.asm -o asm_io.o

driver.o: driver.c
	$(CC) $(CFLAGS) -c driver.c -o driver.o

clean:
	/bin/rm -f *.o $(EX1) $(EX2)

