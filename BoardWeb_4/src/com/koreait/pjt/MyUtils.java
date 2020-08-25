package com.koreait.pjt;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.vo.UserVO;
//똑같은 이름의 메소드 여러개 만듦 : 오버로딩
//오버라이딩? 상속관계에서 사용 부모가 정의해놓은 메소드를 자식이 다시 선언할때
//응집도는 높게, 결합도는 낮게 코드를 짜야한다!
//(인터페이스덕분에 다른 오라클이 아닌 다른 데이터베이스로 넘어올때 유연해진다.)

public class MyUtils {
	public static int parseStrToInt(String str) {
		return parseStrToInt(str, 0);
	}
	
	public static int parseStrToInt(String str, int defNo) {
		try {
			return Integer.parseInt(str);
		} catch(Exception e) {
			return defNo;
		}
	}
	
	public static UserVO getLoginUser(HttpServletRequest request) {
		HttpSession hs = request.getSession();
		return (UserVO)hs.getAttribute(Const.LOGIN_USER);
	}
	
	//return true:로그인이 안됨!, false: 로그인 된 상태
	public static boolean isLogout(HttpServletRequest request) throws IOException {		
		if(null == getLoginUser(request)) {
			return true;			
		}
		return false;
	}
	
	public static String encryptString(String str) {
		String sha = "";

	       try{
	          MessageDigest sh = MessageDigest.getInstance("SHA-256");
	          sh.update(str.getBytes());
	          byte byteData[] = sh.digest();
	          
	          
	          StringBuffer sb = new StringBuffer();
	          for(int i = 0 ; i < byteData.length ; i++){
	              sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
	          }

	          sha = sb.toString();

	      }catch(NoSuchAlgorithmException e){
	          //e.printStackTrace();
	          System.out.println("Encrypt Error - NoSuchAlgorithmException");
	          sha = null;
	      }

	      return sha;
	}
}