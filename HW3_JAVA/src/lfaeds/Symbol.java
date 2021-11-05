package lfaeds;

public class Symbol extends AST{
	String Symbol = " ";
	
	public Symbol(String Symbol){
		this.Symbol = Symbol;
	}
	
	public String getSymbol() {		// for interp
		return Symbol;
	}
	
	public String getASTCode() {	// for parser
		return "(id '" + Symbol +")";
	}
}

