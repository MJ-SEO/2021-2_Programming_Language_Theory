package others;

import lfaeds.*;

public class DynamicV extends LFAEDSValue{
	String param = "";
	AST body = new AST();

	public DynamicV(String param, AST body) {
		this.param = param;
		this.body = body;
	}
	
	public String getDparam() {
		return param;
	}
	
	public AST getDbody() {
		return body;
	}
	
	public String getASTCode() {
		return "(dynamicV '" + this.param + " " + body.getASTCode() + ")";
	}
}

