#lang pial

;[constract] interp : WAE -> number
;[purpose] To convert WAE into number

(define (interp wae)
    (type-case WAE wae
	           [num (n) n]
		       [add (l r) (+ (interp l) (interp r))]
		           [sub (l r) (- (interp l) (interp r))]
			       [with (i v e) (interp (subst e i (interp v)))]
			           [id (s) (error 'interp "free identifier")]
				       )
    )

(test (interp (parse '3)) 3)
(test (interp (parse '{+ 3 4})) 7)
(test (interp (parse '{+ {- 3 4} 7})) 6)
(test (interp (with 'x (num 5) (add (id 'x)(id 'x)))) 10)
