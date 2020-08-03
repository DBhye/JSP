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
String strI_board = request.getParameter("i_board"); 


String sql ="UPDATE t_board SET title=?, ctnt=? WHERE i_board=?";
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정하기</title>
</head>
<body>

</body>
</html>