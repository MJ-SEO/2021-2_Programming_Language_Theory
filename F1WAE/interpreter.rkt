#lang pial

;[constract] lookup: symbol DefrdSub -> number
;[purpose] return number of specific symbol(identifier) 

(define (lookup name ds)
  (type-case DefrdSub ds
	     [mtSub () (error 'lookup "free identifier")]
	     [aSub (i v saved) (if (symbol=? i name) v 
				 (lookup name saved))]
	     )
  )

;[contract] lookup-fundef: symbol list-of-fundef -> number
;[purpose] 

(define (lookup-fundef name fundefs)
  (cond
    [(empty? fundefs)
     (error 'lookip-fundef "unknown function")]
    [else
      (if (symbol=? name(fundef-fun-name(first fundefs)))
	(first fundefs)
	(lookup-fundef name (Rest fundefs)))]
    )
  )

;[constract] interp : F1WAE list-of-FuncDef DefrdSub -> number
;[purpose] To convert F1WAE with fundefs and DefrdSub into number

(define (interp f1wae fundefs ds)
  (type-case F1WAE f1wae
	     [num (n) n]
	     [add (l r) (+ (interp l fundefs ds) (interp r fundefs ds))]
	     [sub (l r) (- (interp l fundefs ds) (interp r fundefs ds))]
	     [with (i v e) (interp e fundefs (aSub i (interp v fundefs ds) ds))]
	     [id (s) (lookup s ds)]
	     [app (f a) (local
			  [(define a_fundef(lookup-fundef f fundefs))]
			  (interp(fundef-body a_fundef)
			    fundefs
			    (aSub(fundef-arg-name a_fundef)
			      (interp a fundefs ds)
			      (mtSub))))]
	     )
  )


(test (interp (parse '3) empty (mtSub)) 3)
(test (interp (parse '{+ 3 4}) empty (mtSub)) 7)
(test (interp (with 'x (num 5) (add (id 'x)(id 'x))) empty (mtSub)) 10)
(test (interp (parse '{+ 1 2}) empty (mtSub)) 3)
(test (interp (add (num 1)(num 2)) empty (mtSub)) 3)
(test (interp (add (num 1)(num 1))(list(fundef 'f 'x (add(id 'x)(num 3)))) (mtSub))2)

(test (interp (app 'f (num 1))(list(fundef 'f 'x (add(id 'x)(num 3))))(mtSub))4)
(test (interp (parse '{f 1})(list(fundef 'f 'x (add(id 'x)(num 3))))(mtSub))4)
(test (interp (parse '{f 1})(list(parse-fd '{deffun (f x){+ x 3}}))(mtSub)) 4)

(test (interp (app 'f (num 10))(list(fundef 'f 'x (sub (num 20)(app 'twice (id 'x))))
				 (fundef 'twice 'y (add (id 'y)(id 'y))))(mtSub))0)
