package others;

import lfaeds.*;

public class ClosureV extends LFAEDSValue{
	String param = "";
	AST body = new AST();
	DefrdSub ds = new DefrdSub();
	
	public ClosureV(String param, AST body, DefrdSub ds) {
		this.param = param;
		this.body = body;
		this.ds = ds;
	}
	
	public String getCparam() {
		return param;
	}
	
	public AST getCbody() {
		return body;
	}
	
	public DefrdSub getCds() {
		return ds;
	}

	public String getASTCode() {
		return "(closureV '" + this.param + " " + body.getASTCode() + " " + ds.getASTCode() + ")";
	}
}

