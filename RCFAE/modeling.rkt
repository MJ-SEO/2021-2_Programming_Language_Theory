#lang plai

(define-type RCFAE-Value
  [numV (n number?)]
  [closureV (param symbol?)(body RCFAE?)(ds DefrdSub?)]
;  [exprV (expr RCFAE?)(ds DefrdSub?)(value (box/c (or/c false RCFAE-Value?)))] ; No need in RCFAE, It is for Laizness
  )

(define-type DefrdSub
             [mtSub]
             [aSub (name symbol?)(value RCFAE-Value?)(ds DefrdSub?)]
             [aRecSub (name symbol?)(value-box (box/c RCFAE-Value?))(ds DefrdSub?)] ; Added
  )

(define-type RCFAE
  [num (n number?)]
  [add (lhs RCFAE?) (rhs RCFAE?)]
  [sub (lhs RCFAE?) (rhs RCFAE?)]
  [id (id symbol?)]
  [fun (param symbol?)(body RCFAE?)]
  [app (ftn RCFAE?)(arg RCFAE?)]
  [if0 (test-expr RCFAE?)(then-expre RCFAE?)(else-expr RCFAE?)] ; Added
  [rec (name symbol?)(named-expr RCFAE?)(fst-call RCFAE?)]      ; Added
)
