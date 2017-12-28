;--------------------------------------------------------
;
;	file: hw1_ex1.asm
;
;	description: take two characters and return them in statment
;
;--------------------------------------------------------


%include "asm_io.inc"

segment .data

	;message used to print final statment
	msg1	db	"First '1' was entered and then '2' was entered",0

segment .text
	global asm_main
asm_main:

	;set-up
	enter	0,0
	pusha

	;move the address of the label msg1 into the register ebx
	mov	ebx, msg1

	;add 7 to the value stored in ebx
	;i.e. move the pointer to number 1 in msg1
	add	ebx, 7

	;take user input
	call 	read_char

	;move the value stored in the register al to the address stored in ebx
	mov	[ebx], al

	;read in extra trash character
	call	read_char

	;take user input
	call	read_char

	;add 25 to the value stored in ebx
	;i.e. move the pointer to number 2 in msg1
	add	ebx, 25

	;move the value stored in the register al to the address stored in ebx
	mov	[ebx], al

	;read in trash character
	call	read_char

	;subtract 25 to the value stored in ebx
	;i.e. move the pointer to the beginning of msg1
	sub	ebx, 32

	;move the contents of the register ebx into the register eax
	mov	eax, ebx

	;print the conents of eax
	;i.e. msg1
	call	print_string

	;print new line
	call	print_nl

	;cleanup
	popa
	mov	eax, 0
	leave
	ret

