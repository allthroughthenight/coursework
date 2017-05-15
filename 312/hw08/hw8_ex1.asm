; Solution for Programming Assignment #7

%include "asm_io.inc"

segment .bss
	Array	resd	10

segment .data
        list_msg        db      "List:    ",0


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

	; Print message
	mov	eax, list_msg
	call	print_string

	; Call function printArray
	push	dword 10
	push	Array
	call	printArray
	add	esp, 8

	popa				; cleanup
	mov	eax, 0			; cleanup
	leave				; cleanup
	ret				; cleanup

%include "hw8_functions.asm"

