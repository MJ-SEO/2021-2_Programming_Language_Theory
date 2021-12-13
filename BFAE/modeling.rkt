#lang plai

(define-type BFAE-Value
  [numV (n number?)]
  [closureV (param symbol?)(body BFAE?)(ds DefrdSub?)]
; [exprV (expr BFAE?)(ds DefrdSub?)(value (box/c (or/c false BFAE-Value?)))] ; No need in BFAE
  [boxV (address integer?)]  ; Added
  )

(define-type Value*Store
  [v*s (value BFAE-Value?)(store Store?)]
  )

(define-type DefrdSub
             [mtSub]
             [aSub (name symbol?)(address integer?)(ds DefrdSub?)]
       )

(define-type Store   ; it refers a present memory
  [mtSto]
  [aSto (address integer?)(value BFAE-Value?)(rest Store?)]
  )

; BFAE = FAE + Boxes
(define-type BFAE
  [num (n number?)]
  [add (lhs BFAE?) (rhs BFAE?)]
  [sub (lhs BFAE?) (rhs BFAE?)]
  [id (id symbol?)]
  [fun (param symbol?)(body BFAE?)]
  [app (ftn BFAE?)(arg BFAE?)]
  [newbox (v BFAE?)]             ; Added
  [setbox (bn BFAE?)(v BFAE?)]   ; Added
  [openbox (v BFAE?)]            ; Added
  [seqn (ex1 BFAE?)(ex2 BFAE?)]  ; Added
  )
