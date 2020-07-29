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
		}%>
<%
	//List<BoardVO> boardList = new ArrayList();
	Connection con = null; 
	PreparedStatement ps = null;
	ResultSet rs = null; 

%>

<%   
	String strI_board = request.getParameter("i_board"); 
 	
	String sql ="SELECT title,ctnt,i_student FROM t_board WHERE i_board = "+strI_board;
	BoardVO vo = new BoardVO();		//PK가 조건일때  WHILE문 밖에서 객체를 생성해서 한 주솟값에 값을 전부 넣어준다.
	try {
		
		con = getCon();
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery();
		
		while (rs.next()) {
			
			String title = rs.getNString("title");
			String ctnt = rs.getNString("ctnt");
			int i_student = rs.getInt("i_student");
			
			
			vo.setI_board(Integer.parseInt(strI_board));
			vo.setCtnt(ctnt);
			vo.setI_student(i_student);
			vo.setTitle(title);

		}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) {try {rs.close();} catch (Exception e) {}}
		if (ps != null) {try {ps.close();} catch (Exception e) {}}
		if (con != null) {try {con.close();} catch (Exception e) {}}
	}
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>
</head>
<body>
	<div>상세 페이지 : <%=strI_board %></div>
	<table>
		<tr>
			<th>제목</th>
			<th>내용</th>
			<th>번호</th>
		</tr>
		<tr>
			<td><%=vo.getTitle() %></td>
			<td><%=vo.getCtnt() %></td>
			<td><%=vo.getI_student() %></td>
		</tr>
	</table>	
</body>
</html>