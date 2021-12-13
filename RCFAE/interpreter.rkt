#lang pial

;[constract] interp : RCFAE DefrdSub -> RCFAE-Value
;[purpose] To convert RCFAE with DefrdSub into RCFAE-Value

(define (interp rcfae ds)
  (type-case RCFAE rcfae
    [num (n) (numV n)]
    [add (l r) (num+ (interp l ds) (interp r ds))]
    [sub (l r) (num- (interp l ds) (interp r ds))]
    [id (s) (lookup s ds)]
    [fun (p b) (closureV p b ds)]
    [app (f a) (local
                 [(define f-val(interp f ds))
                  (define a-val(interp a ds))]
                 (interp (closureV-body f-val)
                         (aSub (closureV-param f-val)
                               a-val
                               (closureV-ds f-val))))]
    [if0 (test-expr then-expr else-expr)
         (if (numzero? (interp test-expr ds))
             (interp then-expr ds)
             (interp else-expr ds))]
    [rec (f fun-expr fst-call)
         (local [(define value-holder (box(numV 198)))
                 (define new-ds (aRecSub f value-holder ds))]
           (begin
             (set-box! value-holder (interp fun-expr new-ds))
             (interp fst-call new-ds)))]
    )
)
