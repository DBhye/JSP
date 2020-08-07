package com.koreait.board.common;

public class Utils {
	public static int parseStrToInt (String str, int n) {
		try {
			return Integer.parseInt(str);
		} catch(Exception e) {
			return n;
		}
	}
}
