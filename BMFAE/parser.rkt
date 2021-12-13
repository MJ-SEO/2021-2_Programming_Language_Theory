#lang pial

;[constract] parse : sexp -> BMFAE
;[purpose] To convert s-expression of into BMFAE

(define (parse sexp)
  (match sexp
    [(? number?) (num sexp)]
    [(list '+ l r) (add (parse l) (parse r))]
    [(list '- l r) (sub (parse l) (parse r))]
    [(list 'with (list i v) e) (app (fun i (parse e)) (parse v))]

    [(? symbol?) (id sexp)]
    [(list 'newbox v) (newbox (parse v))]
    [(list 'setbox bn v) (setbox (parse bn) (parse v))]
    [(list 'openbox v) (openbox (parse v))]
    [(list 'seqn ex1 ex2) (seqn (parse ex1) (parse ex2))]

    [(list 'fun (list p) b) (fun p (parse b))]
    [(list f a) (app (parse f) (parse a))]
    [(list 'setvar n v) (setvar n (parse v))]
    [else (error 'parse "bad stntax: ~a" sexp)]
    )
  )
