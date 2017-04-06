#!/bin/sh
exec clisp <<EOF

(load "hw3b.lisp")

(look)
(pickup 'whiskey)
(pickup 'bucket)
(walk 'west)
(pickup 'frog)
(pickup 'chain)
(walk 'east)
(walk 'east)
(pickup 'necklace)
(look)
(walk 'west)
(walk 'upstairs)
(walk 'downstairs)
(inventory)
