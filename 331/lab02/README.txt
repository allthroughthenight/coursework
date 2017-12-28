Task 2:

Write a MIPS program that calculates the first 12 Fibonacci numbers and stores them to memory addresses 0x10010000 to 0x1001002C.(specify addresses as “byte addresses”, which are “word addresses” * 4).

Task 3:

Follow the slides 47-54 from the file “00_DLX_InstructionSetArch_Harris.pdf” and learn how to implement for and while loops in MIPS.

a) Write a DLX program that implements insertion sort according to the following pseudo code:

for i ← 1 to (length(A)-1)
	x ← A[i]
	j ← i
	while(j <>0) and (A[j-1] > x)
		A[j] ← A[j-1]
		j ← j -1
	A[j] ← x
for the 15 Memory locations with byte addresses 0x10010000 to 0x10010038 (A[0] = M[<0x100010000>], and length(A) = 15).

b) Demonstrate the operation of your program for the memory locations 0x10010000 to 0x10010038being initialized to:
M[0x10010000] = 0x00000010
M[0x10010004] = 0x00000016
M[0x10010008] = 0x00000013
M[0x1001000C] = 0x0000001A
M[0x10010010] = 0x0000001F
M[0x10010014] = 0x0000001C
M[0x10010018] = 0x0000001B
M[0x1001001C] = 0x00000014
M[0x10010020] = 0x00000019
M[0x10010024] = 0x00000017
M[0x10010028] = 0x0000001E
M[0x1001002C] = 0x00000011
M[0x10010030] = 0x0000001D
M[0x10010034] = 0x00000015
M[0x10010038] = 0x00000018
