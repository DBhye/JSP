<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>
	<div>
		<form action="boardWriteProc.jsp" method="post">
			<div><label>제목:<input type="text" name="title"></label></div>
			<div><label>내용:<textarea name="ctnt"></textarea></label></div>
			<div><label>작성자:<input type="text" name="i_student"></label></div>
			<div><input type="submit" value="글등록"></div>
		<%//name이라는 친구는 주소창의 value가 된다.(get방식) 내용적으로 중요하지 않으면 get 방식으로 하면된다.
			//label 태그는 주로 radio나 checkbox에 편하기 위해서 사용. form에 이름붙일때 사용
			//name은 서버에 값 날릴때 key값으로 쓰기 위함이다. id나 class는 key값으로 쓰일 수 없다.%>	
		</form>
	</div>
</body>
</html>