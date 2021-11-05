package lfaeds;

public class App extends AST{
	AST fundef = new AST();
	AST arg = new AST();
	
	public App(AST fundef, AST arg) {
		this.fundef = fundef;
		this.arg = arg;
	}
	
	public AST getFundef() {
		return fundef;
	}

	public AST getArg() {
		return arg;
	}

	public String getASTCode() {
		return "(app " + fundef.getASTCode() + " " + arg.getASTCode() + ")";
	}
}
