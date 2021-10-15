#lang pial

;[constract] parse-fd : sexp -> FunDef
;[purpose] To convert s-expression of into FunDef

(define (parse-fd sexp)
    (match sexp
	       [(list 'deffun (list f x)b) (fundef f x (parse b))]))

;[constract] parse : sexp -> WAE (sub expression into WAE)
;[purpose] To convert s-expression of into WAE

(define (parse sexp) 
  (match sexp
	 [(? number?) (num sexp)] 
	 [(list '+ l r) (add (parse l) (parse r))]
	 [(list '- l r) (sub (parse l) (parse r))]
	 [(list 'with (list i v) e) (with i (parse v) (parse e))]
	 [(? symbol?) (id sexp)]
	 [(list f a) (app f (parse a))]
	 [else (error 'parse "bad stntax: ~a" sexp)]
	 )
  )

(test (parse '3) (num 3))
(test (parse '{+ 3 4}) (add (num 3) (num 4)))
(test (parse '{- 4 3}) (sub (num 4) (num 3)))
(test (parse '{+ {+ 4 3} {- 4 3}}) (add (add (num 4) (num 3)) (sub (num 4) (num 3))))
(test (parse '{with {x 5}{+ 8 2}}) (with 'x(num 5) (add (num 8) (num 2))))

(test (parse-fd '{deffun {twice x} {+ x x}}) (fundef `twice 'x(add (id 'x)(id 'x))))
(test (parse '{twice 5}) (app 'twice (num 5)))
