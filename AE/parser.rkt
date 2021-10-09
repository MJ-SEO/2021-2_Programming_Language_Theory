#lang pial

; [constract] parse : sexp -> AE (sub expression into WAE)
; [purpose] To convert s-expression of into AEs in abstract syntax

(define (parse sexp)
  (match sexp
    [(? number?) (num sexp)] 
    [(list '+ l r) (add (parse l) (parse r))]
    [(list '- l r) (sub (parse l) (parse r))]
    [else (error 'parse "bad stntax: ~a" sexp)]
    )
 )

(test (parse '3) (num 3))
(test (parse '{+ 3 4}) (add (num 3) (num 4))
