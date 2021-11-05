package functions;

import java.util.ArrayList;

import lfaeds.*;

public class Parser {

	AST 
	parse(String exampleCode) {
		ArrayList<String> subExpressions = splitExpressionAsSubExpressions(exampleCode);
		
		// num
		if(subExpressions.size() == 1 && isNumeric(subExpressions.get(0))) {
			return new Num(subExpressions.get(0));
		}
		// add
		if(subExpressions.get(0).equals("+")) {	
			return new Add(parse(subExpressions.get(1)),parse(subExpressions.get(2)));
		}
		// sub
		if(subExpressions.get(0).equals("-")) {	
			return new Sub(parse(subExpressions.get(1)),parse(subExpressions.get(2)));
		}
		// symbol
		if(subExpressions.size() == 1 && !subExpressions.get(0).equals("with")) {
			return new Symbol(subExpressions.get(0));
		}
		// with
		if(subExpressions.get(0).equals("with")) {
			String[] divided = subExpressions.get(1).split(" ", 2);
			String idtf = divided[0].substring(1);
			String value = divided[1].substring(0, divided[1].length()-1);

			Fun fun = new Fun(idtf, parse(subExpressions.get(2)));			
			return new App(fun, parse(value));
		}
		// fun
		if(subExpressions.get(0).equals("fun")) {		
			String param = subExpressions.get(1).substring(1,subExpressions.get(1).length()-1);
			return new Fun(param, parse(subExpressions.get(2)));
		}
		// dsfun
		if(subExpressions.get(0).equals("dsfun")) {
			String param = subExpressions.get(1).substring(1,subExpressions.get(1).length()-1);
			return new DsFun(param, parse(subExpressions.get(2)));
		}		
		
		// app
		if(subExpressions.get(0).startsWith("{") || subExpressions.size() == 2) { 
			return new App(parse(subExpressions.get(0)),parse(subExpressions.get(1)));
		}	
		
		return null;
	}

	private ArrayList<String> splitExpressionAsSubExpressions(String exampleCode) {

		// deal with brackets first.
		if((exampleCode.startsWith("{") && !exampleCode.endsWith("}"))
				|| (!exampleCode.startsWith("{") && exampleCode.endsWith("}"))) {
			System.out.println("Syntax error");
			System.exit(0);
		}
		if(exampleCode.startsWith("{"))
			exampleCode = exampleCode.substring(1, exampleCode.length()-1);

		return getSubExpressions(exampleCode);
	}

	
	private ArrayList<String> getSubExpressions(String exampleCode) {
		
		ArrayList<String> sexpressions = new ArrayList<String>();
		int openingParenthesisCount = 0;
		
		String strBuffer = "";
		for(int i=0; i < exampleCode.length()  ;i++) {
			if(i==0 && (i==0 && exampleCode.charAt(i) == '{')) {
				strBuffer = strBuffer + exampleCode.charAt(i);
				if(exampleCode.charAt(i) == '{') {
					openingParenthesisCount++;						
				}
				continue;
			}
			else if(exampleCode.charAt(i)==' ' && openingParenthesisCount==0){
				// buffer is ready to be a subexpression
				if(!strBuffer.isEmpty()) {
					sexpressions.add(strBuffer);
					strBuffer = ""; // Ready to start a new buffer
				}
				continue;
			} else {
				if(exampleCode.charAt(i)=='{' && openingParenthesisCount==0){
					openingParenthesisCount++;
					// Ready to start a new buffer
					strBuffer = "" + exampleCode.charAt(i);
					continue;
				} else if(exampleCode.charAt(i)=='{') {
					openingParenthesisCount++;
					strBuffer = strBuffer + exampleCode.charAt(i);
					continue;
				} else if(exampleCode.charAt(i)=='}' && openingParenthesisCount>0) {		
					openingParenthesisCount--;
					strBuffer = strBuffer + exampleCode.charAt(i);
					continue;
				} else if(exampleCode.charAt(i)=='}') {
					// buffer is ready to be a subexpression
					openingParenthesisCount--;
					sexpressions.add(strBuffer);
					continue;
				
				}
			}
			strBuffer = strBuffer + exampleCode.charAt(i);
		}
		
		sexpressions.add(strBuffer);

		return sexpressions;
	}

	public static boolean isNumeric(String str)
	{
		return str.matches("-?\\d+(\\.\\d+)?");  //match a number with optional '-' and decimal.
	}

}
