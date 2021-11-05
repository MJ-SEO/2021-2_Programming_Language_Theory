package others;

import lfaeds.*;

public class ExprV extends LFAEDSValue{
	AST exprV = new AST();
	DefrdSub ds = new DefrdSub();
	LFAEDSValue value = new LFAEDSValue();
	
	public ExprV(AST expr, DefrdSub ds, LFAEDSValue value) {
		this.exprV = expr;
		this.ds = ds;
		this.value = value;
	}
	
	public AST getExpr() {
		return exprV;
	}
	
	public DefrdSub getDS() {
		return ds;
	}
	
	public LFAEDSValue getValue() {
		return value;
	}

	public String getASTCode() {
		return "(exprV " +  exprV.getASTCode() + " " + ds.getASTCode() + " " + value.getASTCode() + ")";
	}
}

