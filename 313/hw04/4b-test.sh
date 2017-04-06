#!/bin/sh
exec clisp <<EOF

(load "hw4b.lisp")

;; living room

'(look)
(look)
'(pickup 'whiskey)
(pickup 'whiskey)
'(pickup 'bucket)
(pickup 'bucket)

;; garden

'(walk 'west)
(walk 'west)
'(pickup 'frog)
(pickup 'frog)
'(pickup 'chain)
(pickup 'chain)

;; garden

'(walk 'north)
(walk 'north)

'(pickup 'enchanted_ring)
(pickup 'enchanted_ring)

'(walk 'south)
(walk 'south)

;; salon

'(walk 'east)
(walk 'east)
'(walk 'east)
(walk 'east)
'(pickup 'enchanted_tomb)
(pickup 'enchanted_tomb)
'(look)
(look)

;; living room

'(walk 'west)
(walk 'west)
'(pickup 'puzzle_piece_3)
(pickup 'puzzle_piece_3)

;; attic

'(walk 'upstairs)
(walk 'upstairs)

;; living room

'(walk 'downstairs)
(walk 'downstairs)
'(inventory)
(inventory)
