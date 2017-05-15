;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-

;function that prints student ID, course number, and assignment number
(defun id (course assignment)
	(if
		(and (integerp course)(integerp assignment))
			(progn
				(princ "Name: ")(princ +ID+)(terpri)
				(princ "Course: ICS ")(princ course)(terpri)
				(princ "Assignment: ")(princ assignment)
			)
	)
)

(defparameter *magic-amulet* nil)

;; declare rooms nodes and descriptions
(defparameter *nodes*
	'(
		(great-hall
			(you are in the great-hall. a zombie shambles around.))
		(cemetary
			(you are in a creepy cemetary. A zombie shambles around. there is a spring full of holy water in front of you. the sky is gloomy.))
		(workshop
			(you are in the workshop. there is a rope tying machine in the corner.))
		(garage
			(you are in the garage. there is a place where you can test magic.));;addition room
		(salon
			(you are in the salon. books are stored here.));; addtion room
		(shrine-room
			(you are in the shrine-room. you can do magic things here.));; addtion room
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
		(great-hall
			(cemetary west door)
			(workshop upstairs ladder)
			(salon east door)
			(shrine-room south door)
		)
		(cemetary
				(great-hall east door)
				(garage north door)
		)
		(workshop
			(great-hall downstairs ladder)
		)
		(garage
			(cemetary south door)
		)
		(salon
			(great-hall west door)
		)
		(shrine-room
			(great-hall north door)
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
		arrows
		carafe
		cursed-bracelete
		rope
		magic-tomb
		magic-wand
		magic-key
		magic-lock
		magic-amulet
	)
)

;; define object locations
(defparameter *object-locations*
	'(
		(arrows great-hall)
		(carafe great-hall)
		(rope cemetary)
		(cursed-bracelete cemetary)
		(magic-tomb salon)
		(magic-wand garage)
		(magic-key garage)
		(magic-lock salon)
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
(defparameter *location* 'great-hall)

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
(defparameter *allowed-commands* '(look walk pickup inventory help h ? intro mission))

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

;; define rope-tied
(defparameter *rope-tied* nil)

;; what to do when welding the rope to the carafe
(game-action tie rope carafe workshop
	(if (and (have 'carafe) (not *rope-tied*))
		(progn
			(setf *rope-tied* 't)
			'(the rope is now securely tied to the carafe.)
		)
		'(you do not have a carafe.)
	)
)

;; define carafe-filled
(defparameter *carafe-filled* nil)

;; get holy-water at the spring in the cemetary
(game-action dunk carafe spring cemetary
	(if *rope-tied*
		(progn
			(setf *carafe-filled* 't)
			'(the carafe is now full of holy-water)
		)
		'(the holy-water level is too low to reach.)
	)
)

;; splash holy-water on the zombie in the great-hall
(game-action splash carafe zombie great-hall
	(cond
		((not *carafe-filled*)
			'(the carafe has nothing in it.)
		)
		((have 'cursed-bracelete)
			'(the zombie sees that you stole the cursed-bracelete. it fills with rage and attacks - you lose! the end.)
		)
		(t
			'(you throw the holy water onto the zombie and watch it collapse. but then it suddenly rises again.)
		)
	)
)

;; cast a spell on the zombie in the cemetary
(game-action cast magic-wand zombie cemetary
	(cond
		((have 'cursed-bracelete)
			'(the zombie sees that you stole the cursed-bracelete. it fills with rage and attacks - you lose! the end.)
		)
		((and (have 'magic-wand) (have 'magic-tomb))
		      '(you cast a magic missle at the zombie and watch it collapse. but then it suddenly rises again.)
		)
		(t
			'(you need a magic-wand and magic-tomb to cast a spell)
		)
	)
)

;; shoot the zombie on the porch
(game-action shoot bow zombie porch
	(cond
		((have 'cursed-bracelete)
			'(the zombie sees that you stole the cursed-bracelete. it fills with rage and attacks - you lose! the end.)
		)
		((and (have 'bow) (have 'arrows))
			'(you load the bow fire at the zombie and watch it collapse. but then it suddenly rises again.)
		)
		(t
			'(you need a bow and arrows to shoot)
		)
	)
)

;; create magic amulet
(game-action compound magic-key magic-lock shrine-room
	(cond
		((have 'magic-lock)
			(setq *objects*
				(remove 'magic-lock *objects*)
			)
			(setq *objects*
				(remove 'magic-key *objects*)
			)
			(pushnew 'magic-amulet *objects*)
			(pushnew '(magic-amulet shrine-room) *object-locations*)
			(pickup 'magic-amulet)
			'(you have created a magic-amulet.)
		)
		(t'
			(you do not have a magic-lock.)
		)
	)
)

;; call super wizard
(game-action call magic-amulet sky cemetary
	(if (have 'magic-amulet)
		'(a super wizard appers in the sky. with one wave of his hand all the zombies dissapear - you win!)
		'(you do not have the magic-amulet)
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

(defun mission()
"explain the end goal of the game"
	'(you cant defeat zombies with mortal weapons. you need to summon the super wizard to destory all of them. remember that actions need an object and subject)
)

(defun intro()
"provide a quick intro to the game"
	'(You wake up in a large house. Your breathing echos hauntingly through the great hall. As you get familiar with your surroundings a constant moaning can be heard all around. You see a zombie shambling around but youre unsure what to do. You see a few items lying around and other locations. You might not know how you got here but youll find your way out for sure.)
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
