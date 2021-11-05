package others;

import lfaeds.*;

public class LFAEDSValue extends AST{

	public String getASTCode(){
		String astCode="";
		
		if(this instanceof NumV) {
			astCode = ((NumV)this).getASTCode();
		}
		
		if(this instanceof ClosureV) {
			astCode = ((ClosureV)this).getASTCode();	
		}
		
		if(this instanceof DynamicV) {
			astCode = ((DynamicV)this).getASTCode();	
		}
		
		if(this instanceof ExprV) {
			astCode = ((ExprV)this).getASTCode();	
		}
				
		return astCode;
	}
	
}

