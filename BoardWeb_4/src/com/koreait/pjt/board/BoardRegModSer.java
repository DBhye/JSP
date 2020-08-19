package com.koreait.pjt.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.db.*;
import com.koreait.pjt.Const;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.vo.*;

@WebServlet("/regmod")
public class BoardRegModSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
 

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession hs = request.getSession();
		if (null == hs.getAttribute(Const.LOGIN_USER)) {
			response.sendRedirect("/login");
			return;
		}
		ViewResolver.forward("board/regmod", request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession hs = request.getSession();
		UserVO vo = (UserVO)hs.getAttribute(Const.LOGIN_USER);
		int i_user = vo.getI_user();
		String title =request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		
		
		BoardVO param = new BoardVO();
		
		param.setTitle(title);
		param.setCtnt(ctnt);
		param.setI_user(i_user);
		
		
		int result = BoardDAO.insBoard(param);
		System.out.println("result : "+result);
		
		if(result != 1) {
	         String msg = "에러가 발생하였습니다. 문제가 계속 발생한다면 관리자에게 문의하십시오.";
	         
	         request.setAttribute("msg", msg);
	         request.setAttribute("data", param);
	         
	         doGet(request, response);
	         return;
	      }
		
		response.sendRedirect("/board/list");
	}
}
