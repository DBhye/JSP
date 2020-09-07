package com.koreait.matzip.user;

import javax.servlet.http.HttpServletRequest;
import com.koreait.matzip.Const;
import com.koreait.matzip.ViewRef;

public class UserController {
	// 0	/ 1		/ 2
	//		/user/login
	public String login (HttpServletRequest request) {
			request.setAttribute(Const.TITLE,"로그인");
			request.setAttribute(Const.VIEW, "user/login");
			return ViewRef.TEMP_DEFAULT;
	}
	//requestm.setAttribute(Const.TEMPLATE,null) 이렇게 쓰면 템플릿 안쓰겠다는 뜻이다.
	public String join(HttpServletRequest request) {
		request.setAttribute(Const.TITLE, "회원가입");
		request.setAttribute(Const.VIEW, "user/join");
		return ViewRef.TEMP_DEFAULT;
	}
	
	public String joinProc(HttpServletRequest request) {
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		String nm = request.getParameter("nm");
		
		return "redirect:/user/loing";
	}
}
