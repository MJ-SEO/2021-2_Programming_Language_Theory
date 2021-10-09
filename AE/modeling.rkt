#lang plai

(define-type AE
  [num (n number?)]
  [add (lhs AE?) (rhs AE?)]
  [sub (lhs AE?) (rhs AE?)]
)

(add (num 1) (num 2))

(define ae1 (add (sub (num 2) (num 1)) (num 3)))
(sub? ae1)
(add-lhs ae1)
(add-rhs ae1)
