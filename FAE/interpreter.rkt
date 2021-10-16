#lang pial

;[constract] num-op: (number number -> number) -> (FAE FAE -> FAE)

(define (num-op op)
  (lambda (x y) 
    (num (op (num-n x)(num-n y)))))
(define num+ (num-op +))
(define num- (num-op -))


;[constract] lookup: symbol DefrdSub -> number
;[purpose] return number of specific symbol(identifier)
(define (lookup name ds)
  (type-case DefrdSub ds
	     [mtSub () (error 'lookup "free identifier")]
	     [aSub (i v saved) (if (symbol=? i name) v
				 (lookup name saved))]
	     )
  )

;[constract] interp : FAE DefrdSub -> FAE-Value
;[purpose] To convert FAE with DefrdSub into FAE-Value

(define (interp fae ds)
  (type-case FAE fae
	     [num (n) (numV n)]
	     [add (l r) (num+ (interp l ds) (interp r ds))]
	     [sub (l r) (num- (interp l ds) (interp r ds))]
	     [id (s) (lookup s ds)]
	     [fun (p b) (closureV p b ds)]
	     [app (f a) (local
			  [(define f-val(interp f ds))
			   (define a-val(interp a ds))]
			  (interp (closureV-body f-val)
				  (aSub (closureV-param f-val)
					a-val
					(closureV-ds f-val))))] 
	     )
  )

(interp (num 10) (mtSub))
(test (interp (parse '{with {y 10} {fun {x} {+ y x}}}) (mtSub))
      (closureV 'x (add (id 'y)(id 'x)) (aSub 'y(numV 10)(mtSub))))


