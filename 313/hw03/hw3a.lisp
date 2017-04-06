;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Course: ICS313 Assignment: assg 03

;;; func: fib
;;; params:
;;;	num: sequence number to compute
(defun fib (*num*)
"non-recursive nth fibonacci number function"
	(cond
		;; input integer check
		((integerp *num*)

		 	;; positive value check
			(check-type *num* (integer 0 *))

			;; repeat loop for 'num' number of times
			(loop repeat (+ *num* 1)

				;; set fib1 to 0
			 	for *fib1* = 0

				;; set fib2 to 1
				then *fib2* and *fib2* = 1

				;; add fib2 to fib1
				then (+ *fib1* *fib2*)

				;; return fib1
				finally (return *fib1*)
			)
		)
		;; params not ints then print error and return NIL
		(t
			(format t "params must be an integers")
			()
		)
	)
)

;;; func: fib-r
;;; params:
;;;	num sequence number to compute
(defun fib-r (*num*)
"recursive nth fibonacci number function"
	(cond
		;; input integer check
		((integerp *num*)

			;; positive value check
			(check-type *num* (integer 0 *))
			(if (< *num* 2) *num*
				(+
					(fib-r (1- *num*))
					(fib-r (- *num* 2))
				)
			)
		)
		;; params not ints then print error and return NIL
		(t
			(format t "params must be an integers")
			()
		)
	)
)

;;; func: lcm-2
;;; params:
;;;	num1: number one
;;;	num2: number two
(defun lcm-2 (*num1* *num2*)
"non-recursive function to find the least common multiple of two numbers"
	(cond
		;; input integer check
		((and (integerp *num1*)(integerp *num2*))
		 	;; divide the multiple of the numbers by their gcd
			(/
				;; absolute value check
				(abs
					(* *num1* *num2*)
				)
				(gcd-2 *num1* *num2*)
			)
		)
		;; params not ints then print error and return NIL
		(t
			(format t "params must be an integers")
			()
		)
	)
)

;;; func: remove-number
;;; params:
;;;	llist: list to remove numbers from
(defun remove-number (*llist*)
"non-recursive function that removes numbers from a list"
	(setq *llist* (cons 'temp *llist*))
	(delete-if #'numberp *llist*)
	(setq *llist* (cdr *llist*))
	*llist*
)

;;; func: gcd-2
;;; params:
;;;	num1: number one
;;;	num2: number two
(defun gcd-2 (*num1* *num2*)
"non-recursive function to find greatest common divisor of two numbers"
	;; local param to store mod value
	(defparameter *temp* 0)
	(cond
		;; input integer check
		((and (integerp *num1*)(integerp *num2*))
			;; while num2 is not zero i.e. gcd not found
			(loop while (eql () (zerop *num2*))
				do
					;; temp is num1
					(setq *temp* *num1*)
					;; num1 is num2
					(setq *num1* *num2*)
					;; num2 is the mod temp and num2
					(setq *num2* (mod *temp* *num2*))
			)
			;; return num1
			*num1*
		)
		;; params not ints then print error and return NIL
		(t
			(format t "params must be an integers")
			()
		)
	)
)

;;; func: gcd-2r
;;; params:
;;;	num1: number one
;;;	num2: number two
(defun gcd-2r (*num1* *num2*)
"recursive function to find greatest common divisor of two numbers"
	(cond
		;; input integer check
		((and (integerp *num1*)(integerp *num2*))
			;; if num2 is zero i.e. no new gcd found, return it
			;; else recurse
			(if (zerop *num2*)
				*num1*
				(gcd-2r *num2* (mod *num1* *num2*))
			)
		)
		;; params not ints then print error and return NIL
		(t
			(format t "params must be an integers")
			()
		)
	)
)
