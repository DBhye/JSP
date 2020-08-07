package com.koreait.board;

import java.io.IOException;
import java.util.List;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.board.db.BoardDAO;
import com.koreait.board.db.DbCon;
import com.koreait.board.vo.BoardVO;
import com.koreait.board.common.Utils;


@WebServlet("/boardDetail")
public class BoardDetailSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//화면 띄우는 담당은 jsp!!
		//로직 담당은 서블릿!!
		//boardvo에서 바로 i_board를 파라미터로 보내지 않고 getparameter로 보내는 이유는 수정이 유연해지기 때문이다.
		String strI_board =request.getParameter("i_board");
		int i_board = Utils.parseStrToInt(strI_board,0);
		
		if(i_board == 0) {
			response.sendRedirect("/boardList");
			return;
		}
		
		BoardVO param = new BoardVO();
		param.setI_board(i_board);
		
		BoardVO data = BoardDAO.selBoard(param);
		request.setAttribute("data", data);
		
		String jsp ="/WEB-INF/view/boardDetail.jsp";
	request.getRequestDispatcher(jsp).forward(request,response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

}
