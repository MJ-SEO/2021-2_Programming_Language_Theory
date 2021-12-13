;[constract] lookup: symbol DefrdSub -> number
;[purpose] return number of specific symbol(identifier)

(define (lookup name ds)
  (type-case DefrdSub ds
             [mtSub () (error 'lookup "free identifier")]
             [aSub (i v saved) (if (symbol=? i name)
                                    v
                                 (lookup name saved))]
             )
  )

;[constract] num-op: (number number -> number) -> (RCFAE RCFAE -> RCFAE)

(define (num-op op)
  (lambda (x y)
    (numV (op (numV-n x)
              (numV-n y)))))
(define num+ (num-op +))
(define num- (num-op -))

;runner

(define (run sexp ds)
  (interp (parse sexp) ds))
