<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
<h1>로그인</h1>
<div>
<div class="err">${msg} </div>
<div class="err">${msg_1} </div>
<form action="/login" method="post">
	<div><input type="text" name="user_id" placeholder="아이디" required value="${data.user_id }"></div>
	<div><input type="password" name="user_pw" placeholder="비밀번호" ></div>
	<div><input type="submit" value="로그인"></div>
</form>
	<div><a href="/join">가입안하셨나요?</a></div>
</div>
</body>
</html>