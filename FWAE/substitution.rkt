#lang pial

;; [constract] subst: FWAE symbol FWAE -> FWAE
;; [purpose] to substitute second argument with third argument in first argument,
; as per the rules of substitution; the resulting expression contains
; no free instances of the second argument

(define (subst exp idtf val)
  (type-case FWAE exp
	     [num (n) exp]
	     [add (l r) (add (subst l idtf val) (subst r idtf val))]
	     [sub (l r) (sub (subst l idtf val) (subst r idtf val))]
	     [with (i v e) (with i (subst v idtf val)
				 (if (symbol=? i idtf)
				   e
				   (subst e idtf val)))]
	     ;   [id (s) (if (symbol=? s idtf) val exp)]
	     [id (s) (cond [(equal? s idtf) val]
			   [else exp])]
	     [app (f arg) (app (subst f idtf val)
			       (subst arg idtf val))]
	     [fun (id body) (if (equal? idtf id)
			      exp
			      (fun id (subst body idtf val)))]
	     )
  )

(subst (num 5) 'x 10)
(test (subst (add (num 5)(id 'x)) 'x (num 10)) (add (num 5)(num 10)))
(test (subst (add (id 'x)(id 'y)) 'x (num 10)) (add (num 10)(id 'y)))
(interp (with 'x (num 5) (add (num 1) (with 'y (id 'x) (id 'y)))))
(subst (with 'x (num 5) (add (id 'x)(id 'y))) 'y (num 5))
(subst (with 'x (num 5) (add (id 'x)(id 'x))) 'x (num 5))
