# Implement AE(LFAEDS) Language with JAVA

## How to Compile and Run

### In Eclipse
File → Import → Existing Projects into Workspace → Next → Select archive file → Browse → Choose HW3_JAVA.zip → Finish
and Run on eclipse

### In Terminal
Move to src directory then:
Compile: $> javac functions/*.java lfaeds/*.java others/*.java
Run: $> java functions.Main [<option>? “<LFAEDS>”]  
Note: “ “ is mandatory

ex1) java functions.Main "{with {add5 {fun {y} {+ 5 y}}} {add5 20}}"
ex2)  java functions.Main -p  "{with {x 3} {with {f {dsfun {y} {+ x y}}} {with {x 5} {f 4}}}}"
<option.> ::= -p (execute only parser)
<LFAEDS.> = your concrete syntax of LFAEDS

## Package: functions(functions of LFAEDS)
Main.java: Start here (the 'main' method is in this class)
Parser.java: Parser
Interpreter.java: Interpreter
Lookup.java: Lookup Function for Interpreter
Package: lfaeds(Types of LFAEDS)
AST.java: Super type of LFAEDS
Num.java: Number type
Add.java: Addition type
Sub.java: Subtraction type
Symbol.java: ID type
With.java: With type
Fun.java: Function definition for static scope
DsFun.java: Function definition for dynamic scope
App.java: Function Application

## Package: others(Types of DefrdSub and LFAEDS-value)
DefrdSub.java: Deferred Substitution cache
ASub.java: Asub list
MtSub.java: Mtsub

## LFAEDSValue.java: Super type of LFAEDS-value
NumV.java: Num type for LFAEDS-value
ClosureV.java: Fun type with DefrdSub for support static scope in LAFEDS-value
DynamicV.java Fun type for support dynamic scope in LFAEDS- value
ExprV.java: ExprV tpye for laziness in LFAEDS-value

## LFAEDS: BNF
<LFAEDS.> :: = <num.>
                | {+ <LFAEDS.> <LFAEDS.>}
                | {- <LFAEDS.> <LFAEDS.>}
                | <id.>
                | {fun {<id.>} <LFAEDS.>}
                | {dsfun {<id.>} <LFAEDS.>}
                | <LFAEDS.> <LFAEDS.> }

##  Testcase

### For AE (Arithmetic Expression)
input: "{+ {+ 2 4} {- 18 {+ 10 5}}}";           output: (numV 9)

### For WAE (Arithmetic Expression with 'With')
input: "{with {x {+ 1 2}} {+ x {- 2 x}}}";              output: (numV 2)
input: "{+ x 2}";                                       output: Free identifier
input: "{with {y 3} {+ 2 {{fun {f} {+ f y}} 2}}}";      output: (numV 7)

### For FAE (Arithmetic Expression with First-Class Functions)
input: "{with {x 3} {with {f {fun {y} {+ x y}}} {with {x 5} {f 4}}}}";        output: (numV 7)
input: "{with {double {fun {y} {+ y y}}} {with {x 5} {double 10}}}";     output: (numV 20)
input: "{with {add5 {fun {y} {+ 5 y}}} {add5 20}}";                              output: (numV 25)

### For LFAE (FAE with Laziness)
input: "{{fun {x} {x {+ 4 5}}} {fun {x} 0}}";           output: (numV 0)
input: "{{fun {x} 0} {+ 1 {fun {y} 2}}}";               output: (numV 0)
input: "{{fun {x} {+ x x}} {+ 1 {{fun {y} 2} 1}}}";     output: (numV 6)
input: "{{fun {f} {f 1}} {fun {x} {+ x 1}}}";           output: (numV 2)

### For LFAEDS (LFAE with supporting Dynamic Scope)
input: "{with {f {fun {y} {+ x y}}} {with {x 5} {f 4}}}";                  output: Free identifier
input: "{with {f {dsfun {y} {+ x y}}} {with {x 3} {f 4}}}";                output: (numV 7)
input: "{with {x 3} {with {f {fun {y} {+ x y}}} {with {x 5} {f 4}}}}";     output: (numV 7)
input: "{with {x 3} {with {f {dsfun {y} {+ x y}}} {with {x 5} {f 4}}}}";  output: (numV 9)
