package lfaeds;

public class DsFun extends AST{
	String param = "";
	AST body = new AST();
	
	public DsFun(String param, AST body) {
		this.param = param;
		this.body = body;
	}
	
	public String getParam() {
		return param;
	}

	public AST getFbody() {
		return body;
	}

	public String getASTCode() {
		return "(dsfun '" + this.param + " " + body.getASTCode() + ")";
	}
}

