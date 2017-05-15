;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-

;(setf tpl:*print-length* nil)
(defparameter *magic_amulet* nil)

;; declare rooms nodes and descriptions
(defparameter *nodes*
	'(
		(living-room
			(you are in the living-room. a wizard is snoring loudly on the couch.))
		(garden
			(you are in a beautiful garden.  there is a well in front of you.))
		(attic
			(you are in the attic. there is a giant welding torch in the corner.))
		(garage
			(you are in the garage. there is a place where you test the magic));;addition room
		(salon
			(you are in the salon. all of your books are stored here));; addtion room
		(shrine_room
			( you are in the shrine_room. you can do magic things here));; addtion room
	)
)

;;; func: describe-location
;;; params:
;;;	location: current loation
;;;	nodes: list of location nodes descriptions
(defun describe-location (location nodes)
"describe current location"
	(cadr
		(assoc location nodes)
	)
)

;; declare location node edges for ability to move from one to another
(defparameter *edges*
	'(
		(living-room
			(garden west door)
			(attic upstairs ladder)
			(salon east door)
			(shrine_room south door)
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
		(shrine_room
			(living-room north door)
		)
	)
)

;;; func: descrive-path
;;; params:
;;;	edge: edge to a different location node
(defun describe-path (edge)
"describe a path (i.e. node edge) to another location"
	`(there is a ,(caddr edge) going ,(cadr edge) from here.))


;;; func: descrive-paths
;;; params:
;;;	location: current location
;;;	edges: edges to a different location nodes
(defun describe-paths (location edges)
"describe all paths from curent location"
	(apply #'append
		(mapcar #'describe-path
			(cdr
				(assoc location edges)
			)
		)
	)
)

;; define a list of objects
(defparameter *objects*
	'(
		whiskey
		bucket
		frog
		chain
		magic_tomb
		magic_wand
		magic_key
		magic_lock
		magic_amulet
	)
)

;; define object locations
(defparameter *object-locations*
	'(
		(whiskey living-room)
		(bucket living-room)
		(chain garden)
		(frog garden)
		(magic_tomb salon)
		(magic_wand garage)
		(magic_key garage)
		(magic_lock salon)
	)
)


;;; func: objects-at
;;; params:
;;;	loc: current location
;;;	objs: list of all objects
;;;	obj-loc: objects at current location
(defun objects-at (loc objs obj-loc)
"list all object at current location"
	(labels ((is-at (obj)
		(eq
			(cadr
				(assoc obj obj-loc)
			) loc)
		))
		(remove-if-not #'is-at objs)
	)
)

;;; func: describe-objects
;;; params:
;;;	loc: current location
;;;	objs: list of all objects
;;;	obj-loc: objects at current location
(defun describe-objects (loc objs obj-loc)
"describe objects at current location"
	(labels
		((describe-obj (obj)
			`(you see a ,obj on the floor.)
		))
		(apply #'append
			(mapcar #'describe-obj (objects-at loc objs obj-loc))
		)
	)
)

;; set starting location to the living room
(defparameter *location* 'living-room)

;;; func: loook
;;; params: none
(defun look ()
"look around location (i.e. describe eveything)"
	(append
		(describe-location *location* *nodes*)
		(describe-paths *location* *edges*)
		(describe-objects *location* *objects* *object-locations*)
	)
)

;;; func: walk
;;; params:
;;;	direction: node edge to traverse
(defun walk (direction)
"travel down the edge of current location"
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

;;; func: pickup
;;; params:
;;;	object: object to add to inventory
(defun pickup (object)
"pick up an object at the current location"
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

;;; func: inventory
;;; params: none
(defun inventory ()
"list all items in the current inventory"
	(cons
		'items-
			(objects-at 'body *objects* *object-locations*)
	)
)

;;; func: have
;;; params:
;;;	object: object to check
(defun have (object)
"check if an item is in players inventory"
	(member object
		(cdr (inventory))
	)
)

;-----------------------------------------------------------------
;; ** custome game read-eval-print-loop **
;-----------------------------------------------------------------

;;; func: game-repl
;;; params: none
(defun game-repl ()
"custom game read-eval-print-loop"
	(let
		((cmd (game-read)))
		(unless (eq (car cmd) 'quit)
			(game-print (game-eval cmd))
			(game-repl)
		)
	)
)

;;; func: game-read
;;; params: none
(defun game-read ()
"read repl input from player"
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

;; define allowed commands
(defparameter *allowed-commands* '(look walk pickup inventory help h ?))

;;; func: game-eval
;;; params:
;;;	sexp: commend to execute
(defun game-eval (sexp)
"check if player input is an allowed command"
	(if (member (car sexp) *allowed-commands*)
		(eval sexp)
		'(i do not know that command.)
	)
)

;;; func: tweak-text
;;; params:
;;;	lst: list of text to print
;;;	caps: set to caps flag
;;;	lit: af fam ayy #100
(defun tweak-text (lst caps lit)
"selectivley capitalise select words"
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

;;; func: game-print
;;; params:
;;;	list: text to print
(defun game-print (lst)
"print relevant game information"
	(princ
		(coerce
			(tweak-text
				(coerce
					(string-trim "() "
						(prin1-to-string lst)) 'list) t nil) 'string)
	)
	(fresh-line)
)

;;; func: game-action
;;; params:
;;;	command: action to do
;;;	subject: what to do action on
;;;	obj: object to do action with
;;;	place: where to do action at
;;; optional:
;;;	body: put it down on me
(defmacro game-action (command subj obj place &body body)
	`(progn
		(defun ,command
			(subject object)
			(if
				(and (eq *location* ',place)
					(eq subject ',subj)
					(eq object ',obj)
					(have ',subj)
				) ,@body
				'(i cant ,command like that.)
			)
		)
		(pushnew ',command *allowed-commands*)
	)
)

;-----------------------------------------------------------------
;; ** special actions that change the players inventory based on their items and location **
;-----------------------------------------------------------------

;; define chain-welded
(defparameter *chain-welded* nil)

;; what to do when welding the chain to the bucket
(game-action weld chain bucket attic
	(if (and (have 'bucket) (not *chain-welded*))
		(progn
			(setf *chain-welded* 't)
			'(the chain is now securely welded to the bucket.)
		)
		'(you do not have a bucket.)
	)
)

;; define bucket-filled
(defparameter *bucket-filled* nil)

;; get water at the well i nthe garden
(game-action dunk bucket well garden
	(if *chain-welded*
		(progn
			(setf *bucket-filled* 't)
			'(the bucket is now full of water)
		)
		'(the water level is too low to reach.)
	)
)

;; splash water on the wizard in the living room
(game-action splash bucket wizard living-room
	(cond
		((not *bucket-filled*)
		'(the bucket has nothing in it.))
			(
				(have 'frog)
				'(the wizard awakens and sees that you stole his frog. he is so upset he banishes you to the netherworlds- you lose! the end.)
			)
		(t
			'(the wizard awakens from his slumber and greets you warmly. he hands you the magic low-carb donut- you win! the end.)
		)
	)
)

;; create magic amulet
(game-action compound magic_key magic_lock shrine_room
	(cond
		((have 'magic_lock)
			(setq *objects*
				(remove 'magic_lock *objects*)
			)
			(setq *objects*
				(remove 'magic_key *objects*)
			)
			(pushnew 'magic_amulet *objects*)
			(pushnew '(magic_amulet shrine_room) *object-locations*)
			(pickup 'magic_amulet)
			'(you have created a magic_amulet.)
		)
		(t'
			(you do not have a magic_lock.)
		)
	)
)

;; call super wizard
(game-action call magic_amulet sky garden
	(if (have 'magic_amulet)
		'(a super wizard appers in the sky)
		'(you do not have the magic_amulet)
	)
)

;-----------------------------------------------------------------
;; ** help functions for player **
;-----------------------------------------------------------------

;;; func: help
;;; params: none
(defun help()
"tell player allowed commands"
	`(you can use the following commands -> ,@*allowed-commands*)
)

;;; func: h
;;; params: none
(defun h()
"wrapper for help function"
	(help)
)

;;; func: ?
;;; params: none
(defun ?()
"wrapper for help function"
	(help)
)
;-----------------------------------------------------------------
;; ** macros to add to the gme using lisp repl **
;-----------------------------------------------------------------

;;; func: create-object
;;; params:
;;;	name: name of new object
;;;	place: where to put new object
(defmacro create-object (name place)
"add new objects at a set location"
	`(cond
		((and
			(not-object-member ',name)
			(null (not-node-member ',place))
		)
			(pushnew ',name *objects*)
			(pushnew '(,name ,place) *object-locations*))
		(t
			'(Object has already existed or the location does not exist)
		)
	)
)

;;; func: create-location
;;; params:
;;;	place: name of new place
;;;	place: where to put new object
;;; optional:
;;;	body: put it on me
(defmacro create-location (place &body body)
"add new location to the game"
	`(cond
		((not-node-member ',place)
			(pushnew '(,place (,@body)) *nodes*)
			(pushnew '(,place) *edges*)
			'(new location has been created)
		)
		(t
			'(The place has already existed.)
		)
	)
)

;;; func: create-path
;;; params:
;;;	place-1: name of place1 to connect
;;;	place-2: name of place2 to connect
;;;	path: what edge will be called
;;; optional:
;;;	dir1: cardinal direction from place1 to place2
;;;	dir2: cardinal direction from place2 to place1
(defmacro create-path (place1 place2 path &optional dir1 dir2)
"create a path (i.e. edge) to connect two loactions"
	`(cond
		((null ',dir1)
			'(Place enter direction of path of the ,place1)
		)
		((null ',dir2)
			'(Place enter direction of path of the ,place2)
		)
		((or
			(not-node-member ',place1) (not-node-member ',place2))
			'(one of the two location is not exist)
		)
		(t
			(cond
				((check-direction ',dir1 (cdr (assoc ',place1 *edges*)))
					'(,dir1 direction of the ,place1 has been connected to other location)
				)
				((check-direction ',dir2 (cdr (assoc ',place2 *edges*)))
					'(,dir2 direction of the ,place2 has been connected to other location)
				)

				(t
					(progn
						(pushnew
							'(,place2 ,dir1 ,path)
							(cdr (assoc ',place1 *edges*))
						)
						(pushnew
							'(,place1 ,dir2 ,path)
							(cdr (assoc ',place2 *edges*))
						)
					)
					'(the new path between ,place1 and ,place2 has been created.)
				)
			)
		)
	)
)

;;; func: not-object-member
;;; params:
;;;	name: object to check
(defun not-object-member (name)
"check if an object is correct"
	(if
		(list-member2 name *objects*) nil
		t
	)
)

;;; func: not-node-member
;;; params:
;;;	place: location to check
(defun not-node-member (place)
"check if a location node is correct"
	(if
		(list-member1 place *nodes*) nil
		t
	)
)

;;; func: list-member1
;;; params:
;;;	value: value to checc
;;;	list: list to check against
(defun list-member1 (value list)
"check if a location exists"
	(if
		(null list) nil
		(if
			(eql value (caar list)) t
			(list-member1 value (cdr list))
		)
	)
)

;;; func: not-object-member
;;; params:
;;;	name: object to check
(defun list-member2 (value list)
"the object in the inventory"
	(if
		(null list) nil
		(if
			(eql value (car list)) t
			(list-member2 value (cdr list))
		)
	)
)

;;; func: check-direction
;;; params:
;;;	dir: directiong to check
;;;	place-edge: projected edge to next node
(defun check-direction (dir place-edge)
"check direction of and edge to a location"
	(if
		(null place-edge) nil
		(if
			(eql dir (cadar place-edge)) t
			(check-direction dir (cdr place-edge))
		)
	)
)
