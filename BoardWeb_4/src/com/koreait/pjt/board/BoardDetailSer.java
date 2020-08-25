  
package com.koreait.pjt.board;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;

@WebServlet("/board/detail")
public class BoardDetailSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserVO loginUser = MyUtils.getLoginUser(request);		
		if(loginUser == null) {
			response.sendRedirect("/login");
			return;
		}
		//조회수를 올려주세요!!
		
		String strI_board = request.getParameter("i_board"); 
		int i_board = MyUtils.parseStrToInt(strI_board);
			//어플리케이션 - 세션 - 리퀘스트 - 페이지컨텍스트 (생명주기가 긴것이 우선정렬)
		 // 어플리케이션의 생명주기? 서버 생성되고 닫힐때까지!
		//getAttribute의 파라미터는 object 타입이므로 integer로 int값으로 변경
		
		ServletContext application = getServletContext(); //어플리케이션 내장객체 /getServletContext()는 부모인 HttpServlet으로부터 상속받은 메소드
		Integer readI_user =(Integer)application.getAttribute("read_" + strI_board); //키값
		//조회수 없을 때는 null값이다 or 마지막으로 읽은 사람(pk값)과 로그인 유저의 pk값이 같지않으면 중괄호 실행
		if(readI_user==null || readI_user !=loginUser.getI_user()) {
		BoardDAO.addHits(i_board);
		application.setAttribute("read_"+strI_board, loginUser.getI_user());
		} 
		
		BoardVO param = new BoardVO();
		param.setI_user(loginUser.getI_user());
		param.setI_board(i_board);
		// 로그인한 유저의 pk값(i_user를) 받아와서 'read_10' 키값으로 저장
		//단독으로 조회수 올리기 방지 --- [end]
		request.setAttribute("data", BoardDAO.selBoard(param));
		
		ViewResolver.forward("board/detail", request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// post는 form으로만 보낼수있다!!!!!!!!!!!
	}

}
