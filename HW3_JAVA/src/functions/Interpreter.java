package functions;

import lfaeds.*;
import others.*;

public class Interpreter {

	private LFAEDSValue 	// Function for ADD
	numPlus(LFAEDSValue a, LFAEDSValue b) {  
		String add = "" + 
				(Integer.parseInt(((NumV)(strict(a))).getStrNum()) + (Integer.parseInt(((NumV)strict(b)).getStrNum())));		
		NumV num = new NumV(add);				

		return num;
	}

	private LFAEDSValue 	// Function for SUB
	numMinus(LFAEDSValue a, LFAEDSValue b) {
		String sub = "" + 
				(Integer.parseInt(((NumV)(strict(a))).getStrNum()) - (Integer.parseInt(((NumV)strict(b)).getStrNum())));		
		NumV num = new NumV(sub);	

		return num;
	}
	
	public LFAEDSValue 			// Strict Function
	strict(LFAEDSValue value) {					
		if(value instanceof ExprV) {
			ExprV expr = (ExprV)value;		
			if(((NumV)expr.getValue()).getStrNum() == "0") {
				LFAEDSValue v = strict(interp(expr.getExpr(), expr.getDS())); 
				return v;
			}
			else {
				return expr.getValue();
			}
		}
		return value;
	}
	
	public LFAEDSValue interp(AST ast, DefrdSub ds) {
				
		if(ast instanceof Num) {		
			NumV num = new NumV(((Num)ast).getStrNum());	
			return num;
		}
		
		if(ast instanceof Add) {
			Add add = (Add)ast;
			return numPlus(interp(add.getLhs(), ds), interp(add.getRhs(), ds));
		}
		
		if(ast instanceof Sub) {
			Sub sub = (Sub)ast;		
			return numMinus(interp(sub.getLhs(), ds), interp(sub.getRhs(), ds));
		}
		
		if(ast instanceof Symbol) {
			Symbol id = (Symbol)ast;
			return Lookup.lookup(id.getSymbol(), ds);
		}
		
		if(ast instanceof Fun) {
			ClosureV fun = new ClosureV(((Fun)ast).getParam(), ((Fun)ast).getFbody() ,ds);
			return fun;  
		}
		
		if(ast instanceof DsFun) {
			DynamicV dsfun = new DynamicV(((DsFun)ast).getParam(), ((DsFun)ast).getFbody());
			return dsfun;
		}
		
		if(ast instanceof App) {
			App app = (App)ast;

			LFAEDSValue f_val = strict(interp(app.getFundef(), ds));	// define f-val
			
			NumV _false = new NumV("0");						// define a-val 
			ExprV expr = new ExprV(app.getArg(), ds, _false);
			LFAEDSValue a_val = expr;									
			
			if(f_val instanceof ClosureV) {		// for static scope (ClosureV)
				DefrdSub sCache = new ASub(((ClosureV)f_val).getCparam(), a_val, ((ClosureV)f_val).getCds());
				return interp(((ClosureV)f_val).getCbody(), sCache);	
			}
			else if (f_val instanceof DynamicV){ // for dynamic scope (DynamicV)
				DefrdSub dCache  = new ASub(((DynamicV)f_val).getDparam(), a_val, ds);
				return interp(((DynamicV)f_val).getDbody(), dCache);
			}
			else {
				System.out.println("App Error");
				System.exit(1);
			}
		}
		
		return null;
	}
}
