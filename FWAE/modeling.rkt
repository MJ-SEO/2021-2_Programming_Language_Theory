#lang plai

(define-type DefrdSub
	     [mtSub]
	     [aSub (name symbol?)(value number?)(saved DefrdSub?)])

(define-type FunDef
	     [fundef (fun-name symbol?)
		     (arg-name symbol?)
		     (body F1WAE?)])

(define-type F1WAE
	     [num (n number?)]
	     [add (lhs F1WAE?) (rhs F1WAE?)]
	     [sub (lhs F1WAE?) (rhs F1WAE?)]
	     [with (name symbol?) (named-expr F1WAE?) (body F1WAE?)]
	     [id (id symbol?)]
	     [app (ftn symbol?)(arg F1WAE?)]
	     )

(add (num 1) (num 2))

(fundef 'identify 'x (id 'x))
(app 'idenfity (num 8))
