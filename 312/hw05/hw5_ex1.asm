;--------------------------------------------------------
;
;	hw: 5
;
;	class: 312
;
;	file: hw5_ex1.asm
;
;	description: check that user input is between 0 and 95
;
;--------------------------------------------------------

%include "asm_io.inc"

segment .data
	start_prompt	db	"Enter the bin size: ",0
	valid_msg	db	"Valid bin size!", 0
	invalid_msg	db	"Invalid bin size, aborting!", 0
	min_bin		db	0
	max_bin		db	95

segment	.bss
	bin_size	resd	1			;

segment .text
	global asm_main

asm_main:
	; set up
	enter	0,0
	pusha


	; part 1

	; print prompt and take user input
	mov eax, start_prompt
	call print_string
	call read_int
	mov [bin_size], al

	;------------------------------
	; check user input

	; less than 0
	mov eax, 0
	cmp eax, [bin_size]
	jg invalid

	; greater than 95
	mov eax, 95
	cmp eax, [bin_size]
	jl invalid
	;------------------------------

	; valid input
	mov eax, valid_msg
	call print_string
	jmp exit

	;-----------------------------
	; invalid user input exit
invalid:
	mov eax, invalid_msg
	call print_string
	jmp exit
	;-----------------------------

exit:
	; clean up
	popa
	mov	eax, 0
	leave
	ret

