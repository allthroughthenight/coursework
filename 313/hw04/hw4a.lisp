;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Course: ICS313 Assignment: assg 04a

;; declare *small* global variable
(defparameter *small* 1)

;; declare *big* global variable
(defparameter *big* 100)

;; declare *count* global variable
(defparameter *count* 0)

;;; func: guess-my-number
;;; params: none
(defun guess-my-number ()
"guesses the number the user is thinking by binary search via bit shifting"
	;; add *big* and *small* then shift the binary value right by 1 to half it
	(ash (+ *small* *big*) -1)
)

;;; func: smaller
;;; params: none
(defun smaller ()
"reduce the *small* guessing bound and make a new guess"

	;; use guess-my-number to get the latest *big* value, decrement by 1
	;; and set *big* to the value
	(setf *big*
		(1- (guess-my-number))
	)

	;; call guess-my-number again to half *big*
	(guess-my-number)
)

;;; func: bigger
;;; params: none
(defun bigger ()
"reduce the *big* guessing bound and make a new guess"

	;; use guess-my-number to get the latest *small* value, decrement by 1
	;; and set *small* to the value
	(setf *small*
		(1+ (guess-my-number))
	)

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

;;; func: play-game
;;; params: none
(defun play-game()
"call main-menu function and reset interface"
	(main-menu 0)
)

;;; func: main-menu
;;; params: none
(defun main-menu (p)
"used to display main game menu and prompt user"

	;; if p is zero then print the current guess number
	(if (eql p 0)
		(format t "The current guess is ~D~%" (guess-my-number))
	)      ;;if p = 0 then print the current guess number

	(princ "Enter \"X\" to exit, \"C\" if the number is correct,  \"H\" if N is higher, \"L\" if the number is lower, or \"R\" to restart: ")

	;; declare user input
	(defparameter *input* 'x)

	;; variable *input* is set to the user's input
	(setq *input* (read))

	;; game input loop
	(cond

		;; guess is correct, print message and rest variables
		((eql *input* 'c)
			(format t "You took ~D guesses to find ~D.~%" *count* (guess-my-number))
			(princ "Lets play again")(terpri)(terpri)
			(start-over)
			(main-menu 0)
		)

		;; exit game, print message and quit by not calling main-menu
		((equalp *input* 'x)
			(format t "Thank you for playing the game!~%")
		)

		;; guess is too low, call bigger
		((equalp *input* 'h)
			(+ *count* 1)
			(bigger)
			(main-menu 0)
		)                    ;;if user inputs h/H then count++, call (bigger) and call (main-menu)

		;; guess is too high, call smaller
		((equalp *input* 'l)
			(+ *count* 1)
			(smaller)
			(main-menu 0)
		)                   ;;if user inputs l/L then count++, call (smaller) and call (main-menu)

		;; restart option, call start-over and main-menu
 		((equalp *input* 'r)
			(setf *count* 0)
			(start-over)
			(main-menu 0)
		)

		;; invalid input, print message and main-menu
		(t
			(princ "That is not a valid choice,")
			(terpri)
			(main-menu 1)
		)
	)
)
