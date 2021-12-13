  #lang plai

(define-type BMFAE-Value
  [numV (n number?)]
  [closureV (param symbol?)(body BMFAE?)(ds DefrdSub?)]
  [boxV (address integer?)]
  )

(define-type Value*Store
  [v*s (value BMFAE-Value?)(store Store?)]
  )

(define-type DefrdSub
             [mtSub]
             [aSub (name symbol?)(address integer?)(ds DefrdSub?)]
       )

(define-type Store
  [mtSto]
  [aSto (address integer?)(value BMFAE-Value?)(rest Store?)]
  )

(define-type BMFAE
  [num (n number?)]
  [add (lhs BMFAE?) (rhs BMFAE?)]
  [sub (lhs BMFAE?) (rhs BMFAE?)]
  [id (id symbol?)]
  [fun (param symbol?)(body BMFAE?)]
  [setvar (name symbol?) (v BMFAE?)] ; Added
  [app (ftn BMFAE?)(arg BMFAE?)]
  [newbox (v BMFAE?)]
  [setbox (bn BMFAE?)(v BMFAE?)]
  [openbox (v BMFAE?)]
  [seqn (ex1 BMFAE?)(ex2 BMFAE?)]
  )
