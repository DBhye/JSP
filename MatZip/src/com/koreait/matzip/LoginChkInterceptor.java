package com.koreait.matzip;

import javax.servlet.http.HttpServletRequest;

public class LoginChkInterceptor {
	
	
	public static String routerChk(HttpServletRequest request) {
		//null이 리턴되면 아무일 없음!! 그대로 동작한다~!!
		//문자열이 리턴되면 그 문자열로 sendRedirect 할것임
		//낚아채다, 잘못된 경로로 갔을 때 잡아주는 역할
		String[] chkUserUriArr = {"login", "loginProc", "join", "joinProc", "ajaxIdChk"};
		// 로그인되어있으면 login, join 접속 x
		// 로그인 안되어있으면 restaurant에 접근할수 없다!!
		// 로그인 안되어있음 접속할수있는 주소만 여기서 체크, 나머지 전부 로그인 되어 있어야함
		boolean isLogout = SecurityUtils.isLogout(request);
		String[] targetUri = request.getRequestURI().split("/");		
		if(targetUri.length < 3) { return null; }		
		if(isLogout) { //로그아웃 상태			
			if(targetUri[1].equals(ViewRef.URI_USER)) {
				for(String uri : chkUserUriArr) {
					if(uri.equals(targetUri[2])) {//만났다면 return null
						return null;
					}
				}
			}
			return "/user/login";			
		} else { //로그인 상태
			if(targetUri[1].equals(ViewRef.URI_USER)) {
				//로그인 됐는데 위의 주소들에 접속할 수 없다! 만나면 무조건 메인페이지로 돌려보냄
				for(String uri : chkUserUriArr) {
					if(uri.equals(targetUri[2])) {
						return "/restaurant/restMap";
					}
				}
			}
			return null;			
		}		
	}
}