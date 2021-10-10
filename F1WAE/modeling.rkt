#lang plai

(define-type WAE
	     [num (n number?)]
	     [add (lhs WAE?) (rhs WAE?)]
	     [sub (lhs WAE?) (rhs WAE?)]
	     [with (name symbol?) (named-expr WAE?) (body WAE?)]
	     [id (id symbol?)]
	     )

(add (num 1) (num 2))

(define ae1 (add (sub (num 2) (num 1)) (num 3)))
(sub? ae1)
(add-lhs ae1)
(add-rhs ae1)
