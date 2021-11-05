package functions;

import lfaeds.AST;
import lfaeds.Add;
import lfaeds.Num;
import lfaeds.Symbol;
import others.*;

public class Main {
	
	static boolean onlyParser = false; // for -p option
	
	public static void main(String[] args) {
		String exampleCode = "";	
		
		if(args.length == 1) {			// Only Result
			exampleCode = args[0];	
		}
		else if (args.length == 2 && args[0].equals("-p")) {		// Only Parser
			onlyParser = true;
		    exampleCode = args[1];	
		}
		else {
			System.out.println("Usage <-p>? <LFAEDS>");
			System.exit(1);
		}

		// Parser
		Parser parser = new Parser();
		AST ast = parser.parse(exampleCode);
		
		if(ast == null)
			System.out.println("Syntax Error!");
		
		if(onlyParser) {	
			System.out.println(ast.getASTCode());	// Print Abstract Code
		}
		else {			
			Interpreter interpreter = new Interpreter();
			DefrdSub mtSub = new MtSub();
			
			LFAEDSValue result = interpreter.interp(ast, mtSub);

			System.out.println(result.getASTCode());	// Print Result
		}
	}
}

//For AE
//String exampleCode = "{+ 2 {- 15 {+ 4 5}}}"	; // (numV 8)
//String exampleCode = "{+ {+ 2 4} {- 18 {+ 10 5}}}"; // (numV 9)
//String exampleCode = "{+ {+ 2 {+ 0 0}} {- 4 {+ 2 2}}}"; // (numV 2)
//String exampleCode = "{+ 22 {- 19 3}}"; // (numV 38)
//

//For WAE
//String exampleCode = "{with {x {+ 1 2}} {+ x {- 2 x}}}"; // (numV 2)
//String exampleCode = "{+ x 2}";	// Free identifier
//String exampleCode = "{with {x 5} {+ 8 2}}"; // (numV 10)
//String exampleCode = "{with {y 3} {+ 2 {{fun {f} {+ f y}} 2}}}"; // (numV 7)


//For FAE
//String exampleCode = "{with {x 3} {with {f {fun {y} {+ x y}}} {with {x 5} {f 4}}}}"; 	// (numV 7)    
//String exampleCode = "{with {f {fun {y} {+ x y}}} {with {x 5} {f 4}}}"; 	// Free Identifier
//String exampleCode = "{with {double {fun {y} {+ y y}}} {with {x 5} {double 10}}}";		// (numV 20)    
//String exampleCode = "{with {add5 {fun {y} {+ 5 y}}} {add5 20}}";		// (numV 25)	    

//For LAFE
//String exampleCode = "{{fun {x} {x {+ 4 5}}} {fun {x} 0}}";		// (numV 0)   
//String exampleCode = "{{fun {x} 0} {+ 1 {fun {y} 2}}}"; 	// (numV 0)
//String exampleCode = "{{fun {x} {+ x x}} {+ 1 {{fun {y} 2} 1}}}";	// (numV 6) 
//String exampleCode = "{{fun {f} {f 1}} {fun {x} {+ x 1}}}";		// (numV 2)
//String exampleCode = "{with {y 10} {fun {x} {+ y x}}}";    // (closureV 'x (add (id 'y) (id 'x)) (aSub 'y (exprV (num 10) (mtSub)(numV 0)) (mtSub)))

//For LAFEDS
//String exampleCode = "{with {f {fun {y} {+ x y}}} {with {x 5} {f 4}}}";	// Free identifier
//String exampleCode = "{with {f {dsfun {y} {+ x y}}} {with {x 3} {f 4}}}"; // (numV 7)
//String exampleCode = "{with {x 3} {with {f {fun {y} {+ x y}}} {with {x 5} {f 4}}}}"; // (numV 7)
//String exampleCode = "{with {x 3} {with {f {dsfun {y} {+ x y}}} {with {x 5} {f 4}}}}"; // (numV 9)

