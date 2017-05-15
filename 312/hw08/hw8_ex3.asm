; Solution for Programming Assignment #7

%include "asm_io.inc"

segment .data
        list_msg        db      10, "Original list: ",0
	mapreduce_msg 	db    	"  Mapped list:   ", 0
	reduced_msg	db	"  Reduced value: ", 0

	msg1		db	10, "* Using mapReduce to tag and count odd values: ",10,0
	msg2		db	10, "* Using mapReduce to select multiples of 3 and find their max: ",10,0
	
	

segment .bss
	OriginalArray		resd	10
	Array			resd	10
	Accumulator		resd 	1

segment .text
        global  asm_main
	

asm_main:
	enter	0,0			; setup
	pusha				; setup


	;;
	;;  Getting the input array
	;;

	; Call function inputArray
	push 	dword 10
	push	OriginalArray
	call	inputArray
	add	esp, 8

	;;
	;; Printing the array
	;;

	; Call function printArray
	mov	eax, list_msg
	call	print_string
	push	dword 10
	push	OriginalArray
	call	printArray
	add	esp, 8

	;; 
	;; Tagging even numbers and counting them
	;;

	; Print message
	mov	eax, msg1
	call	print_string

	;; Copying into a new array so as not to overwrite it
	push	Array
	push	OriginalArray
	call	copyArray
	add 	esp, 8

	; Call function mapReduce
	push	Accumulator
	push	sum
	push	is_even
	push	dword 10
	push	Array
	call	mapReduce
	add	esp, 20

	; Call function printArray
	mov	eax, mapreduce_msg
	call	print_string
	push	dword 10
	push	Array
	call	printArray
	add	esp, 8
	
	; Print the accumulator
	mov	eax, reduced_msg
	call	print_string
	mov	eax, [Accumulator]
	call	print_int
	call	print_nl

	;; 
	;; Tagging multiples of 3 and finding the maximum
	;;

	; Print message
	mov	eax, msg2
	call	print_string

	; Copying into a new array so as not to overwrite it
	push	Array
	push	OriginalArray
	call	copyArray
	add 	esp, 8

	; Call function mapReduce
	push	Accumulator
	push	max
	push	is_multiple_of_3
	push	dword 10
	push	Array
	call	mapReduce
	add	esp, 20

	; Call function printArray
	mov	eax, mapreduce_msg
	call	print_string
	push	dword 10
	push	Array
	call	printArray
	add	esp, 8
	
	; Print the accumulator
	mov	eax, reduced_msg
	call	print_string
	mov	eax, [Accumulator]
	call	print_int
	call	print_nl


	popa				; cleanup
	mov	eax, 0			; cleanup
	leave				; cleanup
	ret				; cleanup


;; is_even function

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
		
;; sum function

sum:	
	push	ebp
	mov	ebp, esp
	mov	eax, [ebp+8]
 	add	eax, [ebp+12]
	pop	ebp
	ret
		
;; is_multiple_of_3 function

is_multiple_of_3:
	push	ebp
	mov	ebp, esp
	push	ebx
	push	edx
	push 	ecx

	mov	edx, 0
	mov	eax, [ebp+8]
	mov	ecx, 3
	idiv	ecx
	mov	eax, 0
	cmp	edx, 0
	jnz	not_a_multiple_of_3
	mov	eax, [ebp+8]
not_a_multiple_of_3:

	pop	ecx
	pop	edx
	pop	ebx
	pop	ebp
	ret
		
;; max function

max:	
	push	ebp
	mov	ebp, esp

	mov	eax, [ebp+8]
 	cmp	eax, [ebp+12]
	jnl	not_max
	mov	eax, [ebp+12]
not_max:

	pop	ebp
	ret
		

;; copy array function
copyArray:
	push ebp
	mov  ebp, esp
	pusha

	; Copy the array
	mov	ecx, 10
	mov	eax, [ebp+8]
	mov	ebx, [ebp+12]
copyloop:
	mov	edx, [eax]
	mov	[ebx], edx	
	add	eax, 4
	add 	ebx, 4
	loop	copyloop

	popa
	pop ebp
	ret


%include "hw8_functions.asm"
