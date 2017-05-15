; Solution for Programming Assignment #7

%include "asm_io.inc"

segment .data
	msg_output db	"The number of unique values is: ",0
        list_msg        db      "List:    ",0
        mapped1_msg     db      "plusOne: ",0
        mapped2_msg     db      "isOdd:   ",0


segment .bss
	Array	resd	10

segment .text
        global  asm_main
	

asm_main:
	enter	0,0			; setup
	pusha				; setup

	; Call function inputArray
	push 	dword 10
	push	Array
	call	inputArray
	add	esp, 8

	; Call function printArray
	mov	eax, list_msg
	call	print_string
	push	dword 10
	push	Array
	call	printArray
	add	esp, 8

	; Call function map
	push	plus_one
	push	dword 10
	push	Array
	call	map
	add	esp, 12
	call	print_nl

	; Call function printArray
	mov	eax, mapped1_msg
	call	print_string
	push	dword 10
	push	Array
	call	printArray
	add	esp, 8

	; Call function map
	push	is_even
	push	dword 10
	push	Array
	call	map
	add	esp, 12
	call	print_nl

	; Call function printArray
	mov	eax, mapped2_msg
	call	print_string
	push	dword 10
	push	Array
	call	printArray
	add	esp, 8

	popa				; cleanup
	mov	eax, 0			; cleanup
	leave				; cleanup
	ret				; cleanup


plus_one:
	push	ebp
	mov	ebp, esp
	mov	eax, [ebp+8]
	inc	eax
	pop	ebp
	ret

is_even:
	push	ebp
	mov	ebp, esp
	push	ebx
	mov	eax, 0
	mov	ebx, [ebp+8]
	shr	ebx, 1
	adc	eax, 0 
	neg	eax
	inc	eax
	pop	ebx
	pop	ebp
	ret
		

%include "hw8_functions.asm"
