#!/bin/sh
exec clisp <<EOF

(load "hw3a.lisp")

;;;;;;;;;;; fib test

'(---------------fib test)

'(fib 1)
(fib 1)

'(fib 10)
(fib 10)

'(fib '(5))
(fib '(5))

'(fib "foo")
(fib "foo")

;;;;;;;;;;; fib-r test

'(---------------fib-r test)

'(fib-r 1)
(fib-r 1)

'(fib-r 10)
(fib-r 10)

'(fib-r '(5))
(fib-r '(5))

'(fib-r "foo")
(fib-r "foo")

;;;;;;;;;;; remove-number test

'(---------------remove-number test)

'(remove-number '("foo" bar 5 6 7))
(remove-number '("foo" bar 5 6 7))

'(remove-number '(4 5 "foo" bar 5 6 7))
(remove-number '(4 5 "foo" bar 5 6 7))

'(remove-number '(4 5 6))
(remove-number '(4 5 6))

;;;;;;;;;;; remove-numberr test

'(---------------remove-numberr test)
'(not implemented)

;;;;;;;;;;;; lcm-2 test

'(---------------lcm-2 test)

'(lcm-2 9 3)
(lcm-2 9 3)

'(lcm-2 -9 3)
(lcm-2 -9 3)

'(lcm-2 "foo" 9)
(lcm-2 "foo" 9)

'(lcm-2 () 8)
(lcm-2 () 8)

;;;;;;;;;;;; lcm-2r test

'(---------------lcm-2r test)
'(not implemented)

;'(lcm-2r 9 3)
;(lcm-2r 9 3)
;
;'(lcm-2r -9 3)
;(lcm-2r -9 3)
;
;'(lcm-2r "foo" 9)
;(lcm-2r "foo" 9)
;
;'(lcm-2r () 8)
;(lcm-2r () 8)

;;;;;;;;;;;; gcd-2 test

'(---------------gcd-2 test)

'(gcd-2 5 10)
(gcd-2 5 10)

'(gcd-2r -5 10)
(gcd-2r -5 10)

'(gcd-2 () 100)
(gcd-2 () 100)

'(gcd-2 "foo" 4)
(gcd-2 "foo" 4)

;;;;;;;;;;; gcd2-r test
'(---------------gcd-2r test)

'(gcd-2r 5 10)
(gcd-2r 5 10)

'(gcd-2r -5 10)
(gcd-2r -5 10)

'(gcd-2r () 100)
(gcd-2r () 100)

'(gcd-2r "foo" 4)
(gcd-2r "foo" 4)

EOF
