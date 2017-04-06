#!/bin/sh
exec clisp <<EOF
(load "prj01.lisp")
(id 313 1)
;; game start
(create-object gun salon)
(create-location porch You are on the porch. There is a cat sleeping in the shade.)
(create-path living-room porch door north south)
(game-repl)
look
pickup bucket
walk west
pickup chain
pickup frog
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
splash bucket wizard
EOF
