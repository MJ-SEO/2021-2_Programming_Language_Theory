#lang pial

;; [constract] subst: F1WAE symbol number -> F1WAE
;; [purpose] to substitute second argument with third argument in first argument,
; as per the rules of substitution; the resulting expression contains
; no free instances of the second argument

(define (subst f1wae idtf val)
  (type-case F1WAE f1wae
	     [num (n) f1wae]
	     [add (l r) (add (subst l idtf val) (subst r idtf val))]
	     [sub (l r) (sub (subst l idtf val) (subst r idtf val))]
	     [with (i v e) (with i (subst v idtf val) (if (symbol=? i idtf)e(subst e idtf val)))]
	     [id (s) (if(symbol=? s idtf) (num val) f1wae)]
	     [app (f a) (app f (subst a idtf val))]
   )
)

(test (subst (num 5) 'x 10) (num 5))
(test (subst (add (num 1) (id 'x)) 'x 10) (add (num 1)(num 10)))
(test (subst (id 'y) 'x 10) (id 'y))
