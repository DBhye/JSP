package com.koreait.pjt.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.Const;
import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.vo.*;
@WebServlet("/board/list")
public class BoardListSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if(MyUtils.isLogout(request)) {
			response.sendRedirect("/login");
			return;
		}
		
		
		int page = MyUtils.getIntParameter(request, "page");
		page = page ==0 ? 1 : page;
		
		
		BoardDomain param = new BoardDomain();
		
		param.setPage(page);
		
		//0이 언제찍히는가?
		//nul은 인트형으로 변환할수없으므로 null일때 0으로 찍힌다!!
		//주소값에 숫자가 넘어와야 0이 아닌값이 뜬다!!
		
		
		request.setAttribute("pagingCnt", BoardDAO. selPagingCnt(param));
		request.setAttribute("data", BoardDAO.selBoardList(param));
		ViewResolver.forwardLoginChk("board/list", request, response);
	}

}
