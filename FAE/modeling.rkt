#lang plai

(define-tyoe FAE-Value
	     [numV (n number?)]
	     [closureV (param symbol?) (body FAE?) (ds DefrdSub?)])

(define-type DefrdSub
	     [mtSub]
	     [aSub (name symbol?)(value FAE-Value?)(ds DefrdSub?)])

(define-type FAE
	     [num (n number?)]
	     [add (lhs FAE?) (rhs FAE?)]
	     [sub (lhs FAE?) (rhs FAE?)]
	     [id (id symbol?)]
	     [fun (param symbol?)(body FAE?)]	; function definition
	     [app (ftn FAE?)(arg FAE?)]	; function call (fundef)(arg)
	     )

(fun 'x (add (id 'x)(id 'x)))
(app (fun 'x (add (id 'x)(id 'x))) (num 10))

