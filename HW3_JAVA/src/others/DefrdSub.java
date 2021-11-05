package others;

import lfaeds.*;

public class DefrdSub extends AST{
	
	public String getASTCode() {
		String astCode = "";
		
		if(this instanceof MtSub) {
			astCode = ((MtSub)this).getASTCode();	
		}
		
		if(this instanceof ASub) {
			astCode = ((ASub)this).getASTCode();	
		}
		
		return astCode;
	}
	
}

