package com.koreait.pjt.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.UserDAO;
import com.koreait.pjt.vo.UserVO;

@WebServlet("/join")
public class joinSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// xml 인코딩 설정 --> post 타입일 때 한글 깨지지 말라고 해주는 것,
	// get방식일 때는 tomcat의 server.xml 파일에 uri 인코딩 설정 해줘야 안 깨짐
	// --> 실제로는 이놈이 서버의 인코딩 설정

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// get은 주로 화면을 띄울때 사용

		String fileNum = "join";
		ViewResolver.forward("user/join", request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 업무처리를 한다. 업데이트,수정,값넣기
		// 모든처리를 post방식으로 하는 프로젝트.
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		String encrypt_pw = MyUtils.encryptString(user_pw); //암호화
		String nm = request.getParameter("nm");
		String email = request.getParameter("email");

		UserVO param = new UserVO();
		param.setUser_id(user_id);
		param.setUser_pw(encrypt_pw);
		param.setNm(nm);
		param.setEmail(email);

		int result = UserDAO.insUser(param);
		System.out.println("result : " + result);

		if (result != 1) {
			// "에러가 발생하였습니다. 관리자에게 문의하십시오.
			request.setAttribute("msg", "에러가 발생하였습니다. 관리자에게 문의하십시오");
			request.setAttribute("data", param);

			doGet(request, response);
			return;
		}
		response.sendRedirect("/login");

	}
}
