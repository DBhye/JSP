<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
 	String i_board = request.getParameter("i_board");
	String err = request.getParameter("err");
	
	String errMsg = null;
	
		if(i_board == null || "".equals(i_board)) {
			errMsg = "잘못된 접근입니다.";
		} else if(err != null) {
			switch(err) {
			case "1":
				errMsg = "삭제할 수 없습니다.";
				break;
		}
	}
%>
<% if(errMsg != null) { %>
	<script>
	alert('<%=errMsg%>')
	location.href = '/boardList'
	</script>
<% return; %>
<% }%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>
</head>
<body>
	<div><button onclick="doDel(${data.i_board})">삭제</button></div>
   <div>상세 페이지</div>
   <div>글번호: ${data.i_board}</div>
   <div>제목: ${data.title}</div>
   <div>내용: ${data.ctnt}</div>
   <div>작성자: ${data.i_student}</div>
   <script>
   function doDel(i_board) {
	   if(confirm('삭제하시겠습니까?')) {
		   location.href='boardDel?i_board=' + i_board
	   }
   }
   </script>
</body>
</html>