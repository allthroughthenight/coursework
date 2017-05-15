;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-

(defparameter *nodes*
	'(
		(living-room
			(you are in the living-room. a wizard is snoring loudly on the couch.))
		(garden
			(you are in a beautiful garden. there is a well in front of you.))
		(attic
			(you are in the attic. there is a giant welding torch in the corner.))
		(garage
			(you are in the garage. there is a place where you test the magic))
		(salon
			(you are in the salon. all of your books are stored here))
	)
)

;; list location nodes
(defun describe-location (location nodes)
	(cadr
		(assoc location nodes)
	)
)


(defparameter *edges*
	'(
		(living-room
			(garden west door)
			(attic upstairs ladder)
			(salon east door)
		)
		(garden
			(living-room east door)
			(garage north door)
		)
		(attic
			(living-room downstairs ladder)
		)
		(garage
			(garden south door)
		)
		(salon
			(living-room west door)
		)
	)
)

(defun describe-path (edge)
	`(there is a ,(caddr edge) going ,(cadr edge) from here.)
)

(defun describe-paths (location edges)
	(apply #'append
		(mapcar #'describe-path
			(cdr
				(assoc location edges)
			)
		)
	)
)

(defparameter *objects*
	'(
		 whiskey
		 bucket
		 frog
		 chain
		 enchanted_tomb
		 enchanted_ring
		 puzzle_piece_1
		 puzzle_piece_2
		 puzzle_piece_3
		 puzzle_piece_4
	)
)

;;object location
(defparameter *object-locations*
	'(
		(whiskey living-room)
		(bucket living-room)
		(chain garden)
		(frog garden)
		(enchanted_tomb salon)
		(enchanted_ring garage)
		(puzzle_piece_1 garage)
		(puzzle_piece_2 salon)
		(puzzle_piece_3 living-room)
		(puzzle_piece_4 garden)
	)
)

(defun objects-at (loc objs obj-loc)
	(labels ((is-at (obj)
		(eq
			(cadr
				(assoc obj obj-loc)
				) loc)
		))
		(remove-if-not #'is-at objs)
	)
)

(defun describe-objects (loc objs obj-loc)
	(labels
		((describe-obj (obj)
			`(you see a ,obj on the floor.)
		))
		(apply #'append
			(mapcar #'describe-obj (objects-at loc objs obj-loc))
		)
	)
)

(defparameter *location* 'living-room)

(defun look ()
	(append
		(describe-location *location* *nodes*)
		(describe-paths *location* *edges*)
		(describe-objects *location* *objects* *object-locations*)
	)
)

(defun walk (direction)
	(labels
		((correct-way (edge)
			(eq (cadr edge) direction)
		))
		(let
			((next
				(find-if #'correct-way
						(cdr (assoc *location* *edges*))
				)
			))
			(if next
				(progn
					(setf *location* (car next))
					(look)
				)
				'(you cannot go that way.)
			)
		)
	)
)

(defun pickup (object)
	(cond
		(
			(member object
				(objects-at *location* *objects* *object-locations*)
			)
				(push
					(list object 'body) *object-locations*
				)
				`(you are now carrying the ,object))
		(t
			'(you cannot get that.)
		)
	)
)


(defun inventory ()
	(cons
		'items-
			(objects-at 'body *objects* *object-locations*)
	)
)

(defun have (object)
	(member object
		(cdr (inventory))
	)
)

(defun game-repl ()
	(let
		((cmd (game-read)))
		(unless (eq (car cmd) 'quit)
			(game-print (game-eval cmd))
			(game-repl)
		)
	)
)

(defun game-read ()
	(let
		((cmd
			(read-from-string
				(concatenate 'string "(" (read-line) ")")
			)
		))
		(flet
			((quote-it (x)
				(list 'quote x)
			))
			(cons
				(car cmd)
				(mapcar #'quote-it (cdr cmd))
			)
		)
	)
)

(defparameter *allowed-commands* '(look walk pickup inventory))


(defun game-eval (sexp)
	(if (member (car sexp) *allowed-commands*)
		(eval sexp)
		'(i do not know that command.)
	)
)

(defun tweak-text (lst caps lit)
	(when lst
		(let ((item (car lst))
			(rest (cdr lst)))
			(cond
				((eql item #\space)
					(cons
						item
						(tweak-text rest caps lit)
					)
				)
				((member item '(#\! #\? #\.))
					(cons
						item
						(tweak-text rest t lit)
					)
				)
				((eql item #\")
					(tweak-text rest caps (not lit))
				)
				(lit
					(cons
						item
						(tweak-text rest nil lit)
					)
				)
				(caps
					(cons
						(char-upcase item)
						(tweak-text rest nil lit)
					)
				)
				(t
					(cons
						(char-downcase item)
						(tweak-text rest nil nil)
					)
				)
			)
		)
	)
)

(defun game-print (lst)
	(princ
		(coerce (tweak-text (coerce (string-trim "() " (prin1-to-string lst)) 'list) t nil) 'string)
	)
	(fresh-line)
)
