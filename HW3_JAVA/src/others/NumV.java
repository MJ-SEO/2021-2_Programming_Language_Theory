package others;

public class NumV extends LFAEDSValue{
	String num = "0";
	
	public NumV(String num){
		this.num = num;
	}
	
	public String getStrNum() {
		return num;
	}
	
	public String getASTCode() {
		return "(numV " + num +")";
	}
}

