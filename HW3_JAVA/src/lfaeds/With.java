package lfaeds;

public class With extends AST{
	String idtf = "";
	AST expr = new AST();
	AST value = new AST();

	public With(String idtf, AST value, AST body) {
		this.idtf = idtf;
		this.value = value;
		this.expr = body;
	}

	public String getID() {
		return idtf;
	}
	
	public AST getValue() {
		return value;
	}

	public AST getexpr() {
		return expr;
	}
	
	public String getASTCode() {
		return "(app (fun '" + this.idtf + " " + expr.getASTCode() + ")" + " " + value.getASTCode() + ")";
	}
}

