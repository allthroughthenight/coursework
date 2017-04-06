;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Course: ICS313 Assignment: assg 01

;; declare *small* global variable
(defparameter *small* 1)

;; declare *big* global variable
(defparameter *big* 100)

;;; func: guess-my-number
;;; params: none
;;; guesses the number the user is thinking by binary search via bit shifting
(defun guess-my-number ()
"guesses the number the user is thinking by binary search via bit shifting"

	;; add *big* and *small* then shift the binary value right by 1 to half it
	(ash (+ *small* *big*) -1)
)

;;; func: smaller
;;; params: none
;;; reduce the *small* guessing bound and make a new guess
(defun smaller ()
"reduce the *small* guessing bound and make a new guess"

	;; use guess-my-number to get the latest *big* value, decrement by 1
	;; and set *big* to the value
	(setf *big* (1- (guess-my-number)))

	;; call guess-my-number again to half *big*
	(guess-my-number)
)

;;; func: bigger
;;; params: none
;;; reduce the *big* guessing bound and make a new guess
(defun bigger ()
"reduce the *big* guessing bound and make a new guess"

	;; use guess-my-number to get the latest *small* value, decrement by 1
	;; and set *small* to the value
	(setf *small* (1+ (guess-my-number)))

	;; call guess-my-number again to half *big*
	(guess-my-number)
)

;;; func: start-over
;;; params: none
;;; reset *small* and *big* global variable and start guessing again
(defun start-over ()
"reset *small* and *big* global variable and start guessign again"

	;; reset *small* and *big*
	(defparameter *small* 1)
	(defparameter *big* 100)

	;; call guess-my-number to start over
	(guess-my-number)
)
