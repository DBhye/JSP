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
if(strI_board == null) {
%>
	<script>
	alert('잘못된 접근입니다.')
	location.href='/JSP/boardList.jsp'
	</script>
<% return;
	}
	String sql ="SELECT title,ctnt,i_student FROM t_board WHERE i_board = ?";
	int i_board = Integer.parseInt(strI_board);
	BoardVO vo = new BoardVO();		
	//PK가 조건일때  WHILE문 밖에서 객체를 생성해서 한 주솟값에 값을 전부 넣어준다.
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
//prepareStatement는 문장완성까지 도와준다. setInt, setString 등으로 sql문의 ?자리에 정수나 스트링 등을 넣어준다.
		ps.setInt(1, i_board);
		//ps.setString(1,strI_board);
		rs = ps.executeQuery(); //select문의 결과를 가져온다
		//excuteUpdate
	//	if(rs.next()) {
			//무조건 한번은 실행한다.
			//while문은 언제든지 쓰면된다.
	//		String title = rs.getNString("title");
	//		String ctnt = rs.getNString("ctnt");
		//	int i_student = rs.getInt("i_student");
			
			//vo.setTitle(title);
			//vo.setCtnt(ctnt);
			//vo.setI_student(i_student);
		//}
		
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
	<div>
		<a href="/JSP/boardList.jsp">리스트로가기</a>
		<a href="#" onclick="proDel(<%=i_board%>)">삭제</a>
	</div>
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
	<script>
	function proDel(i_board) {
		var result = confirm('삭제하시겠습니까?');
		if(result) {
			location.href = '/JSP/boardDel.jsp?i_board='+i_board;
		}
	}
	
	</script>
	
</body>
</html>