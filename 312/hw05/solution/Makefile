
PROGRAM1=hw5_ex1

CC=gcc
CFLAGS=-m32
ASM=nasm
ASMFLAGS=-f elf

# List of programs to build: program #1
default: $(PROGRAM1)

# linking program #1
$(PROGRAM1): $(PROGRAM1).o driver.o asm_io.o
	$(CC) $(CFLAGS) $(PROGRAM1).o driver.o asm_io.o -o $(PROGRAM1)

# compiling program #1
$(PROGRAM1).o: $(PROGRAM1).asm
	$(ASM) $(ASMFLAGS) $(PROGRAM1).asm -o $(PROGRAM1).o

# compiling asm_io.asm
asm_io.o: asm_io.asm
	$(ASM) $(ASMFLAGS) -d ELF_TYPE asm_io.asm -o asm_io.o

# compiling driver.c
driver.o: driver.c
	$(CC) $(CFLAGS) -c driver.c -o driver.o

# removing all object files and executables
clean:
	/bin/rm -f *.o $(PROGRAM1)
