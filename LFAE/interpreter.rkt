#lang pial

;[constract] interp : LFAE DefrdSub -> LFAE-Value
;[purpose] To convert LFAE with DefrdSub into LFAE-Value

(define (interp lfae ds)
  (type-case LFAE lfae
    [num (n) (numV n)]
    [add (l r) (num+ (interp l ds) (interp r ds))]
    [sub (l r) (num- (interp l ds) (interp r ds))]
    [id (s) (lookup s ds)]
    [fun (p b) (closureV p b ds)]
    [app (f a) (local
                 [(define f-val(strict (interp f ds)))
                  (define a-val(exprV a ds (box #f)))]
                 (interp (closureV-body f-val)
                         (aSub (closureV-param f-val)
                               a-val
                               (closureV-ds f-val))))]
    )
)
