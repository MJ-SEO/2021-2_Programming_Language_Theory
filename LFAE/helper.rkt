
;[constract] strict: LFAE-Value -> LFAE-Value
;pupose: Laziness

(define (strict v)
  (type-case LFAE-Value v
    [exprV (expr ds v-box)
           (if (not (unbox v-box))
               (local [(define v (strict (interp expr ds)))]
                 (begin (set-box! v-box v)
                        v))
               (unbox v-box))]
    [else v]))

;[constract] lookup: symbol DefrdSub -> number
;[purpose] return number of specific symbol(identifier)
(define (lookup name ds)
  (type-case DefrdSub ds
             [mtSub () (error 'lookup "free identifier")]
             [aSub (i v saved) (if (symbol=? i name)
                                   (strict v)
                                 (lookup name saved))]
             )
  )

;[constract] num-op: (number number -> number) -> (LFAE LFAE -> LFAE)

(define (num-op op)
  (lambda (x y)
    (numV (op (numV-n (strict x))
              (numV-n (strict y))))))
(define num+ (num-op +))
(define num- (num-op -))

;runner

(define (run sexp ds)
  (interp (parse sexp) ds))
