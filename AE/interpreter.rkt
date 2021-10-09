#lang pial

; [constract] WAE -> number
; [purpose] To convert abstaction syntax into number

(define interp an-wae)
	(type-case AE an-wae
		   [num (n) n]
		   [add (l r) (+ (interp l) (interp r)]
		   [sub (l r) (- (interp l) (interp r)]
	)
)

(test (interp (parse '3)) 3)
(test (interp (parse '{+ 3 4})) 7)

