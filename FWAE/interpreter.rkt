#lang pial

;[constract] num-op: (number number -> number) -> (FWAE FWAE -> FWAE)

(define (num-op op)
    (lambda (x y) 
          (num (op (num-n x)(num-n y)))))
(define num+ (num-op +))
(define num- (num-op -))

;[constract] interp : FWAE -> FWAE
;[purpose] To convert FWAE into FWAE, No Deferred Substitution

(define (interp fwae)
  (type-case FWAE fwae
	     [num (n) fwae]
	     [add (l r) (num+ (interp l) (interp r))]
	     [sub (l r) (num- (interp l) (interp r))]
	     [with (i v e) (interp (subst e i (interp v)))]
	     [id (s) (error 'interp "free identifier")]
	     [fun (p b) fwae]
	     [app (f a) (local
			  [(define ftn(interp f))]
			  (interp (subst(fun-body ftn)
				    	(fun-param ftn)
				    	(interp a))))]  ;; body, param, value
	     )
  )

(test (interp (parse '3) empty (mtSub)) 3)
(test (interp (parse '{+ 3 4}) empty (mtSub)) 7)
(test (interp (with 'x (num 5) (add (id 'x)(id 'x))) empty (mtSub)) 10)
(test (interp (parse '{+ 1 2}) empty (mtSub)) 3)
(test (interp (add (num 1)(num 2)) empty (mtSub)) 3)
(test (interp (add (num 1)(num 1))(list(fundef 'f 'x (add(id 'x)(num 3)))) (mtSub))2)

(test (interp (app 'f (num 1))(list(fundef 'f 'x (add(id 'x)(num 3))))(mtSub))4)
(test (interp (parse '{f 1})(list(fundef 'f 'x (add(id 'x)(num 3))))(mtSub))4)
(test (interp (parse '{f 1})(list(parse-fd '{deffun (f x){+ x 3}}))(mtSub)) 4)

(test (interp (app 'f (num 10))(list(fundef 'f 'x (sub (num 20)(app 'twice (id 'x))))
				 (fundef 'twice 'y (add (id 'y)(id 'y))))(mtSub))0)
