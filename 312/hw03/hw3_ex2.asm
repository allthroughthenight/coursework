;--------------------------------------------------------
;
;	assg: 3
;
;	class: 312
;
;	file: hw1_ex2.asm
;
;	description: reverse the order of four capital
;	letters entered by a user, then print out the
;	ascii code of each character twice reduces by the
;	amount entered
;
;--------------------------------------------------------

%include "asm_io.inc"

segment .data			;DX directives

	;first prompt string
	msg1		db	"Enter a string with 4 upper case letters:",0

	;second promt string
	msg2		db	"Enter a integer between 1 and 30:",0

	;1st string to return
	msg3		db	"String #1:",0

	;2nd string to return
	msg4		db	"String #2:",0

	;1st char input
	char1		db	'a'

	;2nd char input
	char2		db	'b'

	;3rd char input
	char3		db	'c'

	;4th char input
	char4		db	'd'

segment	.bss

	;integer input
	integer1	resd	1

segment .text
	global asm_main
asm_main:

	;set up
	enter	0,0
	pusha
	_start:

	;move the address of the label msg1 to the register eax
	mov	eax, msg1

	;print msg1
	call	print_string

	;take user input
	call	read_char

	;move the contents of register al into the address stored in ebx
	mov	[ebx], al

	;move the contents of register al into the contents of the label char4
	mov	[char4], al

	;take user input
	call	read_char

	;add 1 to the contents of the register ebx
	;i.e. increment ebx by one
	add	ebx, 1

	;repeat lines 65 to 78
	;i.e. take user input and put into ebx
	mov 	[ebx], al
	mov	[char3], al
	call	read_char
	add	ebx, 1
	mov	[ebx], al
	mov	[char2], al
	call	read_char
	add	ebx, 1
	mov	[ebx], al
	mov	[char1], al

	;read trash charachter
	call	read_char

	;subtract 3 from the contents of the register ebx
	;i.e. subtract 3 from ebx to the start of the input characters
	sub	ebx, 3

	;print msg2
	mov	eax, msg2
	call	print_string

	;take user input
	call	read_int

	;move the contents of register eax into the contents of the label integer1
	;i.e. save the value to shift the input characters by
	mov	[integer1], eax

	;move the contents stored at the label char1 to the register eax
	mov	eax, [char1]

	;print register eax
	call	print_char

	;repeat lines 112 to 115
	;i.e. print the input character in reverse
	mov	eax, [char2]
	call	print_char
	mov	eax, [char3]
	call	print_char
	mov	eax, [char4]
	call	print_char
	call	print_nl

	;move the contents of the label char4 to the register eax
	mov	eax, [char4]

	;print eax
	;i.e.
	call    print_char
	call	print_char

	;move the contents of the label char3 to the register eax
	;and subtract it by the value stored in the label integer1
	;i.e decrement the input character by the input character
	mov	eax, [char3]
	sub	eax, [integer1]

	;print the contents of eax
	call	print_char
	call	print_char

	;repat lines 142 to 147
	mov	eax, [char2]
	sub	eax, [integer1]
	call	print_char
	call	print_char
	mov	eax, [char1]
	sub	eax, [integer1]
	call	print_char
	call	print_char

	;print new line
	call	print_nl

	;clean up
	popa
	mov	eax, 0
	leave
	ret

