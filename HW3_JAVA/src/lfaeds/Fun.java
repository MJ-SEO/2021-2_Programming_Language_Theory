package lfaeds;

public class Fun extends AST{
	String param = "";
	AST body = new AST();
	
	public Fun(String param, AST body) {
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
		return "(fun '" + this.param + " " + body.getASTCode() + ")";
	}
}

