#lang plai

; [constract] lookup: symbol DefrdSub -> address
; [purpose] return number of specific symbol(identifier)
(define (lookup name ds)
  (type-case DefrdSub ds
             [mtSub () (error 'lookup "free identifier")]
             [aSub (i adr saved) (if (symbol=? i name)
                                   adr
                                 (lookup name saved))]
    )
  )

; store-lookup address Store -> BFAE-Value
(define (store-lookup address sto)
  (type-case Store sto
             [mtSto () (error 'store-lookup "No value at address")]
             [aSto (location value rest-store)
                   (if (= location address)
                         value
                       (store-lookup address rest-store))]
    )
  )

; malloc: Store -> Integer

(define (malloc st)
  (+ 1 (max-address st))
  )

; max-address: Store -> Integer

(define (max-address st)
  (type-case Store st
    [mtSto () 0]
    [aSto (n v st)
          (max n (max-address st))])
  )

; interp-two : BFAE BFAE DefrdSub Store -> Value*Store

(define (interp-two expr1 expr2 ds st handle)
  (type-case Value*Store (interp expr1 ds st)
    [v*s (val1 st2)
         (type-case Value*Store (interp expr2 ds st2)
           [v*s (val2 st3)
                (handle val1 val2 st3)])])
  )

;[constract] num-op: (number number -> number) -> (BFAE BFAE -> BFAE)

(define (num-op op)
  (lambda (x y) 
    (numV (op (numV-n x)
              (numV-n y)))))
(define num+ (num-op +))
(define num- (num-op -))


(define (run sexp ds st)
  (interp (parse sexp) ds st))
