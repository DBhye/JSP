package com.koreait.pjt.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.Const;
import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.*;
import com.koreait.pjt.vo.*;


@WebServlet("/board/regmod") 
public class BoardRegModSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 화면 띄우는 용도(등록창/수정창)
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 if(request.getParameter("i_board") == null) { //수정
	         ViewResolver.forwardLoginChk("board/regmod", request, response);
	         return;
	      }

	 //jsp 에서 서블릿으로 해당 키값으로  값을 넣어주지않으면 서블릿에 값이 넘어오지 않는다.(getParameter는 문자열로 넘어옴)
		String strI_board = request.getParameter("i_board");
		int i_board = MyUtils.parseStrToInt(strI_board);
		BoardVO param= new BoardVO();
		param.setI_board(i_board);
	    BoardDomain data = BoardDAO.selBoard(param);
	     request.setAttribute("data", data);
	      
	      ViewResolver.forwardLoginChk("board/regmod", request, response); // viewresolver 파일명

	}

	// 처리 용도(DB에 등록/수정)실시
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String title = request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		String strI_board = request.getParameter("i_board");
		int i_board = MyUtils.parseStrToInt(strI_board);
		
		
		
		BoardVO param = new BoardVO();
		UserVO loginUser = MyUtils.getLoginUser(request);

		int result;

		param.setTitle(title);
		param.setCtnt(ctnt);
		param.setI_board(i_board);
		param.setI_user(loginUser.getI_user());
		
		if (i_board == 0) {
			result = BoardDAO.insBoard(param);
			response.sendRedirect("/board/list");
			
		} else {
			result = BoardDAO.upDate(param);
			response.sendRedirect("/board/detail?i_board="+i_board);
		}

		if (result != 1) {
			request.setAttribute("msg", "에러가 발생하였습니다.");
			
		}
		
		/*
		if("".equals(strI_board)) {//등록
			result = BoardDAO.insBoard(param);
			response.sendRedirect("/board/list");
		} else { //수정
			i_board = MyUtils.parseStrToInt(strI_board);
			param.setI_board(i_board);
			result = BoardDAO.upDate(param);
		}*/
		
	}
	
}