#lang pial

;[constract] parse : sexp -> FAE (sub expression into FAE)
;[purpose] To convert s-expression of into FAE

(define (parse sexp) 
  (match sexp
	 [(? number?) (num sexp)] 
	 [(list '+ l r) (add (parse l) (parse r))]
	 [(list '- l r) (sub (parse l) (parse r))]
	 [(list 'with (list i v) e) (app (fun i (parse e) (parse v)))]
	 [(? symbol?) (id sexp)]
	 [(list 'fun (list p) b) (fun p (parse b))]
	 [(list f a) (app (parse f)(parse a))]
	 [else (error 'parse "bad syntax: ~a" sexp)]
	 )
  )

(test (parse '{{fun {x}{+ x 1}} 10})(app (fun 'x (add (id 'x)(num 1))) (num 10)))
(test (parse '3) (num 3))
(test (parse '{+ 3 4}) (add (num 3) (num 4)))
(test (parse '{+ {+ 4 3} {- 4 3}}) (add (add (num  4) (num 3)) (sub (num 4) (num 3))))
(test (parse '{with {x 5}{+ 8 2}}) (with 'x (num 5) (add (num 8)(num 2))))
(test (parse '{{fun {x} {+ 8 2}} 5}) (app (fun 'x (add (num 8)(num 2))) (num 5)))
