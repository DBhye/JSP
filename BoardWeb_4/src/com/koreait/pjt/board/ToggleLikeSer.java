package com.koreait.pjt.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.*;

@WebServlet("/board/toggleLike")
public class ToggleLikeSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//선언부~~~~
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//호출부~~~~~~~(메소드 호출하면 stack)
		// i_user, i_board, yn_like 데리고 오기
		UserVO vo = MyUtils.getLoginUser(request);
		//session에서 데리고 온 친구
		int i_user = vo.getI_user();
		
		String strI_board = request.getParameter("i_board"); //키값
		String strYn_like = request.getParameter("yn_like"); //키값
		//argument(메소드 호출할때 정하는것 = 리턴되는 타입) / parameter(메소드 선언시 정하는것)
		int i_board = MyUtils.parseStrToInt(strI_board);
		int yn_like = MyUtils.parseStrToInt(strYn_like);
		//null인 경우 int로 받았을때 0으로 넘어온다.
		//getParameter에서 숫자를 제외한 다른 문자가 넘어오면 0으로 넘어온다.
		// 새 객체 BoardDomain에 값 넣기
		BoardDomain bd = new BoardDomain();
		bd.setI_user(i_user);
		bd.setI_board(i_board);
		bd.setYn_like(yn_like);
		//getAttribute는? setAttribute 했을때만
		// BoardDAO.toggleLike(도메인)
		BoardDAO.toggleLike(bd);
		
		// sendRedirect로 디테일페이지 보내기
		response.sendRedirect("/board/detail?i_board="+i_board);
	}

}
