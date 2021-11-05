package functions;

import lfaeds.*;
import others.*;

public class Lookup {
	
	public static LFAEDSValue
	lookup(String name, DefrdSub ds) {		
		
		if(ds instanceof MtSub) {		// For Free identifier
			System.out.println("Free identifier");	
			System.exit(1);
		}	
		
		if(ds instanceof ASub) {		// Lookup DS recursively
			ASub asub = (ASub)ds;			
			if(asub.getName().equals(name)) {
				Interpreter interp = new Interpreter();
				return interp.strict(asub.getValue());
			}
			else {
				return lookup(name, asub.getDS());
			}
		}
		
		return null;
	}
}
