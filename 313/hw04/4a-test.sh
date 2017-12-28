#!/bin/sh
exec clisp <<EOF

(load "hw4a.lisp")

'(play-game)
(play-game)
h
h
l
c
j
9
(foo)
"bar"
x
EOF
