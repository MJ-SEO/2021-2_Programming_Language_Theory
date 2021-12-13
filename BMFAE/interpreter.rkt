#lang pial

;[constract] interp : BMFAE DefrdSub Store-> Value*Store
;[purpose] To convert BMFAE with DefrdSub into BMFAE-Value

(define (interp expr ds st)
  (type-case BMFAE expr
    [num (n) (v*s (numV n) st)]
    [add (l r) (interp-two l r ds st (lambda (v1 v2 st1) (v*s (num+ v1 v2) st)))]
    [sub (l r) (interp-two l r ds st (lambda (v1 v2 st1) (v*s (num- v1 v2) st)))]
    [id (s) (v*s (store-lookup (lookup s ds) st) st)]
    [fun (p b) (v*s (closureV p b ds) st)]
    [app (f a) (interp-two f a ds st (lambda (f-value a-value st1)
                                             (local ([define new-address (malloc st1)])
                                               (interp (closureV-body f-value)
                                                       (aSub (closureV-param f-value)
                                                             new-address
                                                             (closureV-ds f-value))
                                                       (aSto new-address
                                                             a-value
                                                             st1)))))]
;    [app (f a)  (type-case Value*Store (interp f ds st)
;                           [v*s (f-value f-store)
;                                   (type-case Value*Store (interp a ds f-store)
;                                       [v*s (a-value a-store)
;                                               (local ([define new-address (malloc a-store)])
;                                                      (interp (closureV-body f-value)
;                                                                   (aSub (closureV-param f-value)
;                                                                               new-address
;                                                                               (closureV-ds f-value))
;                                                                  (aSto new-address
;                                                                            a-value
;                                                                             a-store)))])])]
    [newbox (val)
            (type-case Value*Store (interp val ds st)
              [v*s (vl st1)
                   (local [(define a (malloc st1))]
                     (v*s (boxV a)
                          (aSto a vl st1)))])]
    [setbox (bx-expr val-expr)
            (interp-two bx-expr val-expr ds st (lambda (bx-val val st1)
                                                       (v*s val
                                                       (aSto (boxV-address bx-val)
                                                             val
                                                             st1))))]
    [openbox (bx-expr)
             (type-case Value*Store (interp bx-expr ds st)
              [v*s (bx-val st1)
                     (v*s (store-lookup(boxV-address bx-val)
                                       st1) st1)])]

    [seqn (a b) (interp-two a b ds st (lambda (v1 v2 st1) (v*s v2 st1)))]
    [setvar (id val-expr) (local [(define a (lookup id ds))]
                            (type-case Value*Store (interp val-expr ds st)
                              [v*s (val st)
                                   (v*s val
                                        (aSto a
                                              val
                                              st))]))]
    )
)
