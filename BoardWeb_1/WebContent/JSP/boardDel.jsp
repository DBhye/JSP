<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
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
} %>

<%
	// 쿼리스트링에 i_board를 해주지 않으면 null값이 넘어온다.
	String strI_board = request.getParameter("i_board"); 
	
	
	String sql ="DELETE FROM t_board WHERE i_board = ?";
	int i_board = Integer.parseInt(strI_board);
	
	Connection con = null; 
	PreparedStatement ps = null;
	ResultSet rs = null; 
	int result=-1;
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		ps.setInt(1, i_board);
		
		result = ps.executeUpdate();
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		
		if (ps != null) {try {ps.close();} catch (Exception e) {}}
		if (con != null) {try {con.close();} catch (Exception e) {}}
	}
	System.out.println("result :"+result);
	switch(result) {
		case -1:
			response.sendRedirect("/JSP/boardDetail.jsp?err=-1&i_board="+i_board);
			break;
		case 0:
			response.sendRedirect("/JSP/boardDetail.jsp?err=0&i_board="+i_board);
			break;
		case 1:
			response.sendRedirect("/JSP/boardList.jsp");
			break;
		}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
		<a href="/JSP/boardList.jsp">리스트로가기</a>
	</div>
</body>
</html>