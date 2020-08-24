<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지</title>
<style> 
	.heart {
      position: relative;
      width: 100px;
      height: 90px;
     padding: 0;
	border: none;
	background: none;
    }
    .heart:before,
    .heart:after {
      position: absolute;
      content: "";
      left: 50px;
      top: 0;
      width: 50px;
      height: 80px;
      background: pink;
      border-radius: 50px 50px 0 0;
      transform: rotate(-45deg);
      transform-origin: 0 100%;
    }
    .heart:after {
      left: 0;
      transform: rotate(45deg);
      transform-origin: 100% 100%;
    }
</style>
</head>
<body>
	<div>
		<a href="/board/list">리스트</a>		
		<c:if test="${loginUser.i_user == data.i_user }">
		<a href="/board/regmod?i_board=${data.i_board}">수정</a>
		<form id="delFrm" action="/board/del" method="post">
		<input type="hidden" name="i_board" value="${data.i_board}">				
		<a href="#" onclick="submitDel()">삭제</a>
		</form>			
			<button class="heart" id="" ></button> 
		</c:if>
	</div>
	<div>제목: ${data.title}</div>
	<div>일시: ${data.r_dt}</div>
	<div>작성자: ${data.nm}</div>
	<div>조회수: ${data.hits}</div>
	<hr>
	<div>${data.ctnt}</div>
	<script>
		function submitDel() {
			delFrm.submit()
		}
		function addmitLike() {
			
		}
	</script>
</body>
</html>