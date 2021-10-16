#lang plai

(define-type DefrdSub
	     [mtSub]
	     [aSub (name symbol?)(value number?)(saved DefrdSub?)])

(define-type FWAE
	     [num (n number?)]
	     [add (lhs FWAE?) (rhs FWAE?)]
	     [sub (lhs FWAE?) (rhs FWAE?)]
	     [with (name symbol?) (named-expr FWAE?) (body FWAE?)] ; idtf, value, expression
	     [id (id symbol?)]
	     [fun (param symbol?)(body FWAE?)]	; function definition
	     [app (ftn FWAE?)(arg FWAE?)]	; function call (fundef)(arg)
	     )

(fun 'x (add (id 'x)(id 'x)))
(app (fun 'x (add (id 'x)(id 'x))) (num 10))

