#!/bin/sh
exec clisp <<EOF
(load "game.lisp")
(id 313 6)
;; game start
(create-object musket salon)
(create-location porch You are on the porch. There is a cat sleeping in the shade.)
(create-path great-hall porch door north south)
(game-repl)

help
look
pickup carafe
walk west
pickup rope
pickup cursed-bracelete
walk north
pickup magic-wand
pickup magic-key
walk south
walk east
walk upstairs
tie rope carafe
walk downstairs
walk west
dunk carafe spring
walk east
splash carafe zombie
quit
EOF
