package com.koreait.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.board.common.Utils;
import com.koreait.board.common.Utils;
import com.koreait.board.db.BoardDAO;
import com.koreait.board.vo.BoardVO;

@WebServlet("/boardMod")
public class boardMod extends HttpServlet {
	private static final long serialVersionUID = 1L;
   


	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		 String strI_board = request.getParameter("i_board");
	       
	       int i_board = Utils.parseStrToInt(strI_board);
	       if(i_board == 0) {
	    	   response.sendRedirect("boardList");
	    	   return;
	       }
	       BoardVO param = new BoardVO();
	       param.setI_board(i_board);
	       request.setAttribute("data",BoardDAO.selBoard(param));
	       
	       String jsp = "/WEB-INF/view/boardRegmod.jsp";
	       request.getRequestDispatcher(jsp).forward(request, response);
	}
		

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strI_board = request.getParameter("i_board");
		String title =request.getParameter("title");
		String ctnt = request.getParameter("ctnt");

		
		BoardVO param = new BoardVO();
		param.setI_board(Utils.parseStrToInt(strI_board));
		param.setTitle(title);
		param.setCtnt(ctnt);
		
		
		int result = BoardDAO.upDate(param);
		if(result == 1) {
			response.sendRedirect("/boardDetail?i_board="+strI_board);
		}
		else
			request.setAttribute("msg", "에러가 발생하였습니다.");
		}
			
	}


