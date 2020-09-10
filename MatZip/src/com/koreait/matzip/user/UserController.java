package com.koreait.matzip.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.koreait.matzip.Const;
import com.koreait.matzip.ViewRef;
import com.koreait.matzip.vo.UserVO;

public class UserController {
	private UserService service;

	public UserController() {
		service = new UserService();
	}

	// /user/login
	public String login(HttpServletRequest request) {
		String error = request.getParameter("error");

		if (error != null) {
			switch (error) {
			case "2":
				request.setAttribute("msg", "아이디를 확인해 주세요.");
				break;
			case "3":
				request.setAttribute("msg", "비밀번호를 확인해 주세요.");
				break;
			}
		}

		request.setAttribute(Const.TITLE, "로그인");
		request.setAttribute(Const.VIEW, "user/login");
		return ViewRef.TEMP_DEFAULT;
	}

	public String loginProc(HttpServletRequest request) { 
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");

		UserVO param = new UserVO();
		param.setUser_id(user_id);
		param.setUser_pw(user_pw);

		int result = service.login(param);

		if (result == 1) {//로그인 성공하면 로그인이 유지되도록 세션에 넘겨준다.
			HttpSession hs = request.getSession();
			hs.setAttribute(Const.LOGIN_USER, param);
			//로그인 한사람의 정보를 여기에 담는다.
			//바구니에 모든 값을 넣어서 하나로 넘겨준다.
			return "redirect:/restaurant/restMap";
		} else {
			return "redirect:/user/login?error=" + result;
		}

	}

	public String join(HttpServletRequest request) {
		request.setAttribute(Const.TITLE, "회원가입");
		request.setAttribute(Const.VIEW, "user/join");
		return ViewRef.TEMP_DEFAULT;
	}

	public String joinProc(HttpServletRequest request) {
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw"); // 암호화
		String nm = request.getParameter("nm");

		UserVO param = new UserVO();
		param.setUser_id(user_id);
		param.setUser_pw(user_pw);
		param.setNm(nm);
		//클래스 객체화한다 =레퍼런스 변수(타입이 맞아야만 값이 들어간다!!)
		//전역변수 = 멤버필드
		//생성자! 객체가 생성될 때 딱 한번쓴다!
		//레퍼런스 변수에는 객체의 주솟값이 저장된다.
		//객체지향 언어? 현실세계를 반영한다.
		//메소드? 객체가 가지고 있는 동사!, 멤버메소드
		int result = service.join(param);

		return "redirect:/user/login";
	}
	
	public String ajaxIdChk(HttpServletRequest request) {
		String user_id = request.getParameter("user_id");
		UserVO param = new UserVO();
		param.setUser_id(user_id);
		param.setUser_pw("");
		
		int result = service.login(param);
		
		return String.format("ajax:{\"result\": %s}", result);
	}
	public String logout(HttpServletRequest request) {
		HttpSession hs = request.getSession();
		hs.invalidate(); // 
		return "redirect:/user/login";
	}
}