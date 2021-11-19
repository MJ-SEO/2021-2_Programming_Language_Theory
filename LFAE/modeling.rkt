#lang plai

(define-type LFAE-Value
	     [numV (n number?)]
	     [closureV (param symbol?)(body LFAE?)(ds DefrdSub?)]
	     [exprV (expr LFAE?)(ds DefrdSub?)(value (box/c (or/c false LFAE-Value?)))]
	     )

(define-type DefrdSub
	     [mtSub]
	     [aSub (name symbol?)(value LFAE-Value?)(ds DefrdSub?)])

(define-type LFAE
	     [num (n number?)]
	     [add (lhs LFAE?) (rhs LFAE?)]
	     [sub (lhs LFAE?) (rhs LFAE?)]
	     [id (id symbol?)]
	     [fun (param symbol?)(body LFAE?)]
	     [app (ftn LFAE?)(arg LFAE?)]
	     )
