#!/bin/sh
exec clisp <<EOF

;; preable
(load "game.lisp")
(id 313 6)

;; add location, object, and path
(create-location porch You are on the porch. A zombie shambles around. There is a cat sleeping in the shade.)
(create-object bow porch)
(create-path great-hall porch door outside inside)

;; game start
(game-repl)

intro
mission
help
look
pickup carafe
pickup arrows
walk outside
pickup bow
shoot bow zombie
walk inside
walk east
pickup magic-tomb
pickup magic-lock
walk west
walk west
pickup rope
walk north
pickup magic-wand
pickup magic-key
walk south
cast magic-wand magic-tomb
walk east
walk upstairs
tie rope carafe
walk downstairs
walk west
dunk carafe spring
walk east
splash carafe zombie
walk south
compound magic-key magic-lock
walk north
walk west
inventory
call magic-amulet sky
quit
EOF
