;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Course: ICS313 Assignment: assg 02

;;; func: my-finder
;;; params:
;;;	numer: number to be found
;;;	my-list: list to be searched from
(defun my-finder (*number* *my-list*)
"Recursive function that will look for an item in its input list. If the item
 is there, return it. Otherwise return nil."

	(cond
		;; check if param2 is a list
		((not (listp *my-list*))
			(format t "param2 must be a list")
			()
		)

		;; item not found or given an empty list
		((eq () *my-list*)
			(format t "item not found")
			()
		)

		;; first item in list doesn't match, so recure
		((not (equalp *number* (car *my-list*)))
			(my-finder *number* (cdr *my-list*))
		)

		;; first item must match, so return it
		(t *number*)
	)
)

;;; func: eat-last
;;; params:
;;;	my-list: list to remove last item from
(defun eat-last (*my-list*)
"Recursive function that returns a the same as the input, except the last item
is removed"
	(cond
		;; check if param1 is a list
		((not (listp *my-list*))
			(format t "param must be a list")
				()
		)

		;; check if list is empty
		((eq () *my-list*)
			(format t "empty list")
			()
		)

		;; one item base case
		((eq 1 (length *my-list*))
			()
		)

		;; make new list using cons, car for first item, and recurse
		;; with cdr of the rest of the list
		(t
			(cons
				(car *my-list*) (eat-last(cdr *my-list*))
			)
		)
	)
)


;;; func: symbols-only
;;; params:
;;;	my-list: list to remove last item from
(defun symbols-only(*my-list*)
"Recursive function that returns a list with only the symbols in the list"
	(cond
		;; check if param is a list
		((not (listp *my-list*))
			(format t "param must be a list")
			()
		)

		;; empty list base case
		((eq () *my-list*)
			()
		)

		;; if the first item is a symbol, add to list with cons and
		;; recurse with cdr, else just recurse
		(t	(if (symbolp (car *my-list*))
				(cons
					(car *my-list*) (symbols-only (cdr *my-list*)))
				(symbols-only (cdr *my-list*))
			)
		)
	)
)

;;; func: matchp
;;; param:
;;;	item1: item to compare to
;;;	item2: item to be compared against
(defun matchp(*item1* *item2*)
"Function that takes two parameters and returns their value if equivalent"
	(if (equalp *item1* *item2*)
		*item1*
		(format t "no match")
	)
)
