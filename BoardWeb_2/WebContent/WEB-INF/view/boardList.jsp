<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.koreait.board.vo.BoardVO"%>

 <% List<BoardVO> list = (List<BoardVO>)request.getAttribute("data"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
</head>
<body>
	<div>게시판 리스트
	<a href="/boardWrite"><button>글쓰기</button></a>
	</div>
	<table>
	<tr>
	<th>No</th>
	<th>제목</th>
	<th>내용</th>
	<th>작성자</th>
	</tr>
	<% for(BoardVO vo : list){ %>
	<tr class="itemRow" onclick="moveToDetail(<%=vo.getI_board() %>)">
	<td><%=vo.getI_board() %></td>
	<td><%=vo.getTitle() %></td>
	<td><%=vo.getI_student() %></td>
	</tr>
	<% } %>
	</table>
	<script>
	function moveToDetail(i_board){
		console.log('moveToDetail - i_board' + i_board)
		location.href = 'boardDetail?i_board=' + i_board
	}
	</script>
</body>
</html>