#lang plai

; Problem 1
; Solved by myserlf: Y
; Time taken: about 5 mins
; [contract] dollar->won: number -> number
; [purpose] To convert dollar to won.
; [test] (test(dollar->won 1) 1162)
;        (test(dollar->won 5) 5810)

(define (dollar->won dollar) (* dollar 1162))
(test(dollar->won 1) 1162)
(test(dollar->won 5) 5810)

; Problem 2
; Solved by myserlf: Y
; Time taken: about 5 mins
; [contract] digit_sum: number number number -> number
; [purpose] To sum three integer.
; [test] (test(digit_sum 1 2 3) 6)
;        (test(digit_sum 58 1027 2214) 3299)

(define (digit_sum num1 num2 num3) (+ num1 num2 num3))
(test(digit_sum 1 2 3) 6)
(test(digit_sum 58 1027 2214) 3299)

; Problem 3
; Solved by myserlf: Y
; Time taken: about 10 mins
; [contract] inchworm-travel: number number -> number
; [purpose] To get distance an inchworm can travel in givien time in centimeters                                 .
; [test] (test(inchworm-travel 3 1) 7.62)
;        (test(inchworm-travel 10 24) 609.6)

(define (inchworm-travel speed hours) (*(* speed hours) 2.54))
(test(inchworm-travel 3 1) 7.62)
(test(inchworm-travel 10 24) 609.6)

; Problem 4
; Solved by myserlf: Y
; Time taken: about 10 mins
; [contract] is-odd?: number -> boolean
; [purpose] To determine whether the given number is odd or not.
; [test] (test(is-odd? 0) #f)
;        (test(is-odd? 13) #t)

(define (is-odd? num) (= (modulo num 2) 1))
(test(is-odd? 0) #f)
(test(is-odd? 13) #t)

; Problem 5
; Solved by myserlf: Y
; Time taken: about 30 mins
; [contract] my-factorial: number -> number
; [purpose] To get the factorial value of given number.

; [contract] combination: number number -> number
; [purpose] To get the number of combinations that can be there.
; [test] (test(combination 4 0) 1)
;        (test(combination 10 3) 120)


(define (my-factorial num)
  (cond
      [(<= num 1) 1]
      [else (* num (my-factorial (- num 1)))]
))

(test (my-factorial 0) 1)
(test (my-factorial 4) 24)

(define (combination n_elem_set n_elem_subset)
  (/(my-factorial n_elem_set)(* (my-factorial (- n_elem_set n_elem_subset))(my-factorial n_elem_subset))))

(test(combination 4 0) 1)
(test(combination 10 3) 120)
(test(combination 12 8) 495)


; Problem 6-a
; Solved by myserlf: Y
; Time taken: about 10 minute
; [contract] Type Definition "PERSON"
;            - Professor has courses and projects (both number)
;            - UndergraduateStudent has courses (number)
;            - GraduateStudent has courses and paper (both number)
; [purpose] Define "PERSON" type

(define-type PERSON
  [Professor (courses number?)
             (projects number?)]
  [UndergraduateStudent (courses number?)]
  [GraduateStudent (courses number?)
                   (papers number?)]
  )

(define myProfessor (Professor 3 15));
(define myUndergraduateStudent (UndergraduateStudent 6));
(define myGraduateStudent (GraduateStudent 2 4));
(define myGraduateStudent2 (GraduateStudent 3 1));

; Problem 6-b
; Solved by myserlf: Y
; Time taken: about 15 mins
; [contract] have-courses: PERSON -> number
; [purpose] To get the number of courses taken or taught for the given PERSON
; [test] (test(have-courses myProfessor) 3)
;        (test(have-courses myUndergraduateStudent) 6)
;        (test(have-courses myGraduateStudent) 2)

(define (have-courses person)
  (type-case PERSON person
    [Professor (c p) c]
    [UndergraduateStudent (c) c]
    [GraduateStudent (c p) c]
    )
  )
     
(test(have-courses myProfessor) 3)
(test(have-courses myUndergraduateStudent) 6)
(test(have-courses myGraduateStudent) 2)
  

; Problem 6-c
; Solved by myserlf: Y
; Time taken: about 30 mins
; [contract] ready-to-graduate: PERSON -> boolean
; [purpose] Check whether the PERSON is able to graduate or not
; [test] (test(ready-to-graduate myProfessor) #f)
;        (test(ready-to-graduate myGraduateStudent) #t)
;        (test(ready-to-graduate myGraduateStudent) #f)


(define (ready-to-graduate person)
  (type-case PERSON person
    [Professor (c p) false]
    [UndergraduateStudent (c) false]
    [GraduateStudent (c p)
      (cond
        [(>= p 3) true]
        [else false]
        )]
    )
 )

(test(ready-to-graduate myProfessor) #f)
(test(ready-to-graduate myGraduateStudent) #t)
(test(ready-to-graduate myGraduateStudent2) #f)

; Problem 7
; Solved by myserlf: Y
; Time taken: about 70 mins
; [contract] convert-name: symbol -> symbol
; [purpose] To translate a alphabet to the specific name. 

; [contract] name-alphabet : list -> list
; [purpose] To translate a alphabet list to specific name list starting with the alphabet character. 
; [test] (test(name-alphabet '(a b n)) '(alice unnamed unnamed))
;        (test (name-alphabet '(a c j k)) '(alice cherry jc kate))
;        (test (name-alphabet '(w x y z)) '(unnamed unnamed unnamed unnamed))

(define (convert-name alpha)
  (cond
    [(symbol=? alpha 'a) 'alice]
    [(symbol=? alpha 'c) 'cherry]
    [(symbol=? alpha 'j) 'jc]
    [(symbol=? alpha 'k) 'kate]
    [else 'unnamed]
    )
  )

(define (name-alphabet lst)
  (cond
    [(empty? lst) empty]
    [else (cons (convert-name(first lst))
                (name-alphabet(rest lst)))]
    )
  )

(test (name-alphabet '(a b n)) '(alice unnamed unnamed))
(test (name-alphabet '(a c j k)) '(alice cherry jc kate))
(test (name-alphabet '(w x y z)) '(unnamed unnamed unnamed unnamed))

; Problem 8
; Solved by myserlf: Y
; Time taken: about 40 mins
; [contract] update-name : symbol symbol list -> list
; [purpose] Check whether the PERSON is able to graduate or not
; [test] (test(update-name 'cherry 'claire (cons 'jc (cons 'cherry (cons 'kate empty))))'(jc claire kate))
;        (test(ready-to-graduate myGraduateStudent) #t)
;        (test(ready-to-graduate myGraduateStudent) #f)


(define (old_to_new old inp new)
  (cond
    [(equal? old inp) new]
    [else inp]
    )
  )

(define (update-name old new lst)
  (cond
    [(empty? lst) empty]
    [else (cons (old_to_new old (first lst) new)
                (update-name old new (rest lst)))]
    )
  )

(test(update-name 'cherry 'claire (cons 'jc (cons 'cherry (cons 'kate empty))))'(jc claire kate))
(test(update-name 'jc 'mj (cons 'jc (cons 'alice (cons 'john empty)))) '(mj alice john))
(test(update-name 'dog 'cat (cons 'lion (cons 'dog (cons 'sparrow empty))))'(lion cat sparrow))
(test(update-name 'dog 'cat (list 'lion 'dog 'sparrow)) '(lion cat sparrow))
