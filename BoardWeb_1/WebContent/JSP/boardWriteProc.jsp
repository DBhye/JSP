<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.web.BoardVO"%>
<%!
 	Connection getCon() throws Exception {
		
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String username = "hr";
		String password = "koreait2020";
	
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		Connection con = DriverManager.getConnection(url, username, password); //클래스.실행();이런 실행은 static이다. db연결을 담당하는 실행문이다. 
		System.out.println("접속성공");
		return con;
		}%>
<%
	// request.setCharacterEncoding("UTF-8");
	// 한글이 깨지지 않도록 설정하기
	String title = request.getParameter("title");
	String ctnt = request.getParameter("ctnt");
	String strI_student = request.getParameter("i_student"); 
	
	
	if( "".equals(title) || "".equals(ctnt) || "".equals(strI_student) ) {
	response.sendRedirect("/jsp/boardWrite.jsp?err=10");
	return;

	int i_student = Integer.parseInt(strI_student);
	
	Connection con = null;
	PreparedStatement ps = null;
	
	int result=-1;
	//sql문에서 따옴표 안에 한칸씩 띄워줘야한다. sql문은 띄어쓰기로 구별하기 때문.
	String sql = " INSERT INTO t_board (i_board,title,ctnt,i_student) "
				+ " SELECT nvl(max(i_board), 0)+1, ?, ?, ? "
				+ " FROM t_board ";
	try{
		con = getCon();
		ps = con.prepareStatement(sql);	
		ps.setNString(1, title);
		ps.setNString(2, ctnt);
		ps.setInt(3,i_student);
		
		result = ps.executeUpdate();
	
	} catch(Exception e) {
		e.printStackTrace();
		
	} finally {
	
		if (ps != null) {try {ps.close();} catch (Exception e) {}}
		if (con != null) {try {con.close();} catch (Exception e) {}}
	}
		
	int err = 0;
	switch(result) {
	//case -1:
		//response.sendRedirect("/JSP/boardWrite.jsp?err=-1");
		//break;
	//case 0:
		//response.sendRedirect("/JSP/boardWrite.jsp?err=0");
		//break;
		case 1:
		response.sendRedirect("/JSP/boardList.jsp");
		return;
		case 0:
		err = 10;
		break;
		case -1:
		err = 20;
		break;
		
		
	} response.sendRedirect("/JSP/boardWrite.jsp?err="+err);
%>
	
	<div> title: <%=title %></div>
	<div> ctnt:  <%=ctnt %></div>
	<div> strI_student: <%=strI_student%></div>
	<%/*시퀀스?*/ %>
	