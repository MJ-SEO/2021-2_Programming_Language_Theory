#lang pial

;; [constract] parse : sexp -> AE (sub expression into AE)
;; [purpose] To convert s-expression of into AEs in abstract syntax

(define (parse sexp)
  (match sexp
    [(? number?) (num sexp)] 
    [(list '+ l r) (add (parse l) (parse r))]
    [(list '- l r) (sub (parse l) (parse r))]
    [(list 'with (list i v) e) (with i (parse v) (parse e))]
    [(? symbol?) (id sexp)]
    [else (error 'parse "bad stntax: ~a" sexp)]
    )
  )
