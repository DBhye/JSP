package com.koreait.board;

import java.io.IOException;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import com.koreait.board.db.BoardDAO;
import com.koreait.board.vo.BoardVO;


@WebServlet("/boardList") //<- 원하는 주솟값 적어주면 주소 맵핑됨, jsp container가 들고 있다가 저 주솟값 분석해서 연결된 객체에 Get/Post방식으로 보낼 때에 각각의 메소드를 실행  
// 원래는 보안상 파일명과 이름 다르게 해야 함, 파일명 유추할 수 없도록 해야
// 여기에 웹서블릿 주소 안 적을 거면 xml에 엄청 길게 적어야 함

public class BoardListSer extends HttpServlet {
	private static final long serialVersionUID = 1L; //private 지우면 default //멤버필드

 
    public BoardListSer() {
        super();
     //파라미터를 받지 않는 생성자 = 기본생성자   
        //1. 클래스명과 동일  2. 리턴타입 적으면 안된다

      //super는 부모의 기본생성자를 호출한다는 뜻이다.
    }

	@Override // 있으면 실수 방지 -> 적어주는 게 좋다

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String strI_board = request.getParameter("i_board");
//		System.out.println("Servlet i_board :" +strI_board);
		 // 고객이 나한테 보낸 모든 정보가 request에 담겨 있음
		// RequestDispatcher 항상 jsp 파일만 여는것은 아니다.
		//여기서 날리면 get 방식 - 보통 화면 띄우는 용도
		//스프링에서는 알아서 동작한다.(RequestDispatcher)
		//이동할때 주솟값이 변하지않는다.
		// 웹인포는 원래 보안적으로 외부에서 접근할수가 없게 막아놓은 것이다. 웹인포 안의 파일은 RequestDispatcher로만 접근할 수 있다.
		//페이지 컨텍스트와 리퀘스트는 응답하고나면 죽는다.
		//세션은 브라우저를 끄는 순간 죽는다.
		// 어플리케이션은 서버 켜는 순간 생성, 서버 끄는 순간 종료. (개인용이 아니라 전체용) (여러명이서 같이 씀.)하나밖에 생성되지않는다.
		//input > 로직 > output
//		웹 서버 : 응답이 목표 -> html로 하고 있음
//		응답하고 나면 필요없는 것들은 다 소멸 for 메모리관리
//		request, response는 응답하고 나서 바로 소멸 
//
//		SendRedirect : 주솟값이 변함
//		RequestDispatcher : 주솟값이 안 변함
//
//		sendRedirect -> doGet/doPost : 무조건 get방식으로 날아감
//		RequestDispatcher : doGet/doPost 각각의 방식으로 날아감
//
//
//		RequestDispatcher
//		주솟값 변하지 않으므로 파일명 숨길 수 있다
//		RequestDispatcher만 WEB-INF 아래의 파일 부를 수 있다(WEB-INF 아래 파일은 외부에서 부를 수 없음, 보안적으로 뛰어남)
//
//		doGet은 보통 화면 띄우는 용도로 사용, jsp파일과 주로 붙어다님
//
//		doPost는 처리담당
//
//
//		페이지 컨텍스트
//		리퀘스트, 세션, 어플리케이션 -> 통신, 자료전달
//		살아있는 스쿠프가 다 다름
//		페이지 컨텍스트 -jsp파일 열고 닫힐 때 죽음
//		리퀘스트 - 요청 들어오고 응답햇을 때 죽음
//		세션 - 브라우저(탭 말고 브라우저 창) 하나 당 하나 생성, 브라우저 끌 때 죽음
//		어플리케이션 - 서버 켜는 순간 생성, 끄는 순간 죽음(개인용 아니라 전체용)
//		세션, 리퀘스트, 페이지 컨텍스트는 개인용
//
//
//		data access object -> dao
		
		List<BoardVO> list = BoardDAO.selBoardList();
		request.setAttribute("data",list);
		request.setAttribute("data2",1);
		request.setAttribute("data2",1.1);
		request.setAttribute("data2",true);
		//두번째 파라미터는 오브젝트이다.
		//getAttribute 또한 오브젝트타입으로 리턴할것이다.
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/boardList.jsp");
		rd.forward(request,response);
		
		
//		try {
//			Connection con = DbCon.getCon();
//			PreparedStatement ps=null;
//			ResultSet rs=null;
//			
//			
//			DbCon.close(con,ps,rs);
//			
//			DbCon.close(con,ps);
//			
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
		
//		
//		response.getWriter().append("Served at: ").append(request.getContextPath());
//	}
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
		//get방식으로 실행하면 이부분이 실행된다.
		//폼에서만 post방식으로 날릴수있다. - proc 처리하는 용도
		//쿼리스트링 get방식 (속도에 유리), post방식(보안적으로 유리 주소에 쿼리스트링이 나타나지않는다. 보내는 것을 캡슐화해서 많은 양을 보낼 수 있고 속도가 약간 느려진다.)
		//jsp는 화면 뿌리는 담당 서블릿은 (jsp에서 썻던 스크립트 릿이 전부 여기에 들어간다) 로직담당하는 역할
		//jsp 파일 주소 이동 = response.sendRedirect - 무조건 get 방식으로 이동.(이동할때 주솟값 변함)
		
	}

}


