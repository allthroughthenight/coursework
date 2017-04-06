#!/bin/sh
exec clisp <<EOF
(load "hw5.lisp")
;; game start
(create-object gun salon)
(create-location porch You are on the porch. There is a cat sleeping in the shade.)
(create-path living-room porch door north south)
(game-repl)
look
pickup whiskey
pickup bucket
walk north
walk south
walk east
pickup magic_lock
pickup magic_tomb
pickup gun
walk west
walk west
pickup chain
walk north
pickup magic_wand
pickup magic_key
walk south
walk east
walk upstairs
weld chain bucket
walk downstairs
walk west
dunk bucket well
walk east
walk south
compound magic_key magic_lock
walk north
walk west
call magic_amulet sky
walk east
splash bucket wizard
EOF
