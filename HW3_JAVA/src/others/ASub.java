package others;

public class ASub extends DefrdSub{
	String name;
	LFAEDSValue value = new LFAEDSValue();	
	DefrdSub ds = new DefrdSub();
	
	public ASub(String name, LFAEDSValue value, DefrdSub ds) {
		this.name = name;
		this.value = value;
		this.ds = ds;
	}
	
	public String getName() {
		return name;
	}
	
	public LFAEDSValue getValue() {
		return value;
	}
	
	public DefrdSub getDS() {
		return ds;
	}

	public String getASTCode() {
		return "(aSub '" + this.name + " " + value.getASTCode() + " " + ds.getASTCode() +")";
	}
}

