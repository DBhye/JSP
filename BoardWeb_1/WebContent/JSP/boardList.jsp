<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.koreait.web.BoardVO"%>
<%!/* <%일 때는 메소드 안임, 지역변수이므로 private 못 붙임
	메소드 안에 메소드 만들 수 없으므로 <%!와 같이 ! 붙여서 메소드 바깥으로 보내야만 메소드를 만들 수 있다.
	! 붙이면 전역변수가 된다. 클래스 단에 메소드를 만들고 싶을 때 사용.*/
	//public void ddd() {

	//int a=10;}%>

<%!Connection getCon() throws Exception {
			/*Connection 실행 시 try catch문으로 감싸줘야한다*/
			/*void 가 아니므로 return이 있어야한다.*/
			String url = "jdbc:oracle:thin:@localhost:1521:orcl";
			String username = "hr";
			String password = "koreait2020";

			Class.forName("oracle.jdbc.driver.OracleDriver");
			/*해결할것인가? try catch를 해줄것인가?*/
			Connection con = DriverManager.getConnection(url, username, password); //클래스.실행();이런 실행은 static이다. db연결을 담당하는 실행문이다. 
			System.out.println("접속성공");
			return con;
		}%>
<%
List<BoardVO> boardList = new ArrayList();
Connection con = null; /*리턴 타입이 Connection 타입이다 Connection 객체가 연결을 담당한다.*/
PreparedStatement ps = null;/*객체의 담당은 '쿼리문완성' + 쿼리문 실행*/
ResultSet rs = null; /*select문의 결과를 담을 객체이다.*/
//여기서 선언하면 try부터는 계속 살아있다.scope 스코프 : 유효범위		
String sql = "SELECT i_board, title FROM t_board ORDER BY i_board DESC";
/*t_board옆에 세미콜론 붙이면 인젝션 공격이 가능해지므로 조심해야한다.where i_board*/
//가독성 때문에 떨어뜨려놓음.

try {
	con = getCon(); /*con은 Connection 객체를 받을 수 있다.*/
	ps = con.prepareStatement(sql); //static이 아니다. static이 붙은 메소드는 클래스명.실행(); 하여 바로 쓸 수 있다.
	rs = ps.executeQuery(); //메소드 호출 , return 타입은 resultset 객체 주솟값

	//if(rs.next()) {}
	//void 는 = 붙여서 쓸 수 없다.

	while (rs.next()) {
		//while문 boolean타입
		//true false 반환.
		//rs.next()는 처음실행했을 때 첫번째 줄 레코드를 가리킨다. 실행할때마다 다음줄 실행.
		//레코드(데이터)가 다 있으면 true를 리턴한다.
		int i_board = rs.getInt("i_board"); //return타입 인트형
		String title = rs.getNString("title"); //'안녕'이라는 값이 title 에 담김.
		//getString보다는 getNstring 사용 권장. 

		// *********** 이부분 중요
		// while문 밖에서 사용하면 다 같은 객체의 주솟값을 가지게 되므로 꼭 반복문안에서 사용!!
		BoardVO vo = new BoardVO();
		//복수의 데이터를 가져오므로 WHILE문 안에서 객체에 들어있는 값이 계속 바뀐다.
		vo.setI_board(i_board);
		vo.setTitle(title);

		boardList.add(vo);
	}

	//파라미터로 들어오는 것 만으로 모든 작업이 가능하면 static을 쓰면좋다.
} catch (Exception e) {
	e.printStackTrace();
} finally {
	//중요한 부분
	//열었으면 닫아줘야한다
	//하나씩 각각 따로 닫아줘야한다.
	if (rs != null) {
		try {
	rs.close();
		} catch (Exception e) {
		}
	}
	if (ps != null) {
		try {
	ps.close();
		} catch (Exception e) {
		}
	}
	if (con != null) {
		try {
	con.close();
		} catch (Exception e) {
		}
	}
}
%>
<%
	//페이지컨텍스트 jsp 파일에서 생성되고 jsp 파일 끝나면 죽는다. =개인용
//리퀘스트 =개인용 웹 브라우저와 같은 클라이언트로부터의 요청 정보를 담아 제공하는 객체입니다. 
//request 객체는 javax.servlet.http.HttpServletRequest 객체이며 
//JSP가 서블릿으로 변환되었을 때 요청을 처리하기 위해 실행되는 메서드인 _jspService() 
// 메서드의 첫번째 파라미터로 넘어오게 됩니다.=개인용
//세션 브라우저에서 페이지 켤때 생성되고 끌때 죽는다.(세션이 소스를 많이 차지한다.) =개인용
//애플리케이션 서버 켤때 생성되고 서버끌때 죽는다.(고객이 몇명이든 한개만 만들어진다.) = 전체용
//html 태그들은 메소드 안에 존재한다.
//jsp에서 html css 자바까지 사용한다.
//db로부터 가져온 값을 찍는다! = 동적페이지를 만들 수 있다.
//동적 페이지는 쿼리만 넘어오면 작동한다. 네이버 검색 쿼리스트링 ?sm(상자)=top_hty(상자에서 꺼내서 본 밸류값)&(더보내고 싶은 값을 연결해주는 연결자)fbm(상자)=1(밸류값)
//쿼리스트링 get방식 (속도에 유리), tost방식(보안적으로 유리 주소에 쿼리스트링이 나타나지않는다.)
//jsp?i_board=<%=vo.getI_board() 이렇게 get 방식으로 밸류를 보낼것이다.
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
	<div>게시판리스트
	<a href="/JSP/boardWrite.jsp"><button>글쓰기</button></a></div>
	<table>
		<tr> 
			<th>No</th>
			<th>제목</th>
		</tr> 
		<%
			for (BoardVO vo : boardList) {
		%>
		<tr>
			<td><%=vo.getI_board()%></td>
			<td><a href="/JSP/boardDetail.jsp?i_board=<%=vo.getI_board()%>"> 
					<%=vo.getTitle()%>
			</a></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>