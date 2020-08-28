<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${data == null ? '등록할래' : '수정할래'}</title>
</head>
<body>
<% // '/'안붙이면 앞주소 그대로에 뒤만 바뀜
//붙이면 접근하는 아이피주소만 그대로고 나머지 주소 전부 바뀜 
// 쿼리스트링 ? 서블릿 친구에게 값 전달하기 위해(argument 보내는 것!)%>

	<div class="container">
		<form id="frm" action="regmod" method="post">
			<div><input type="hidden" name="i_board" value="${data.i_board }"></div>
			<div><input id="title" type="text" name="title" placeholder="제목을 입력하세요" value="${data.title }"></div>
			<div><textarea name="ctnt" placeholder="내용을 입력하세요">${data.ctnt }</textarea></div>
			<div><button type="submit">${data.i_board == null ? '글등록' : '글수정'}</button></div>
		</form>
	</div>
</body>
</html>