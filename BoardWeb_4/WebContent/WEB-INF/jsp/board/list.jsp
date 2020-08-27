<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
<style>
th,td {border: 1px solid black; border-collapse: collapse;}
table {border: 1px solid black;border-collapse: collapse;}
</style>
</head>
<body>
<% 

	String pageddd = request.getParameter("page");
        
%>
<div>${loginUser.nm} 님 환영합니다!<a href="/logout">로그아웃</a></div>
<div>
<div>
	<form id="selFrm" action="/board/list" method="get">
	<input type="hidden" name="page" value="${param.page == null ? 1: param.page}">
	레코드 수 : 
		<select name="record_cnt" onchange="changeRecordCnt()">
			<c:forEach begin="10" end="30" step="10" var="item">
			<c:choose>
				<c:when test="${param.record_cnt == item || (param.record_cnt == null && item ==10)}">
					<option value="${item}" selected>${item}개</option>
					</c:when>
			</c:choose>
			<c:if test="${}"
		</select>
	</form>
</div>
<a href="/board/regmod">글쓰기</a>
</div>
<h1>리스트</h1>
<table>
	<tr>
		<th>No</th>
		<th>제목</th>
		<th>조회수</th>
		<th>작성자</th>
		<th>작성날짜</th>
	</tr>
	<c:forEach items="${data}" var="item">
	<tr class="itemRow" onclick="moveToDetail(${item.i_board})">
		<td>${item.i_board}</td>
		<td>${item.title}</td>
		<td>${item.hits}</td>
		<td>${item.i_user}</td>
		<td>${item.r_dt}</td>
	</tr>
	</c:forEach>
	</table>
	<div class="fontCenter">
        <c:forEach begin="1" end="${pagingCnt}" var="item">
         	<c:choose>
         		<c:when test="${param.page == item}">
         			<span class="pagingFont pageSelected">${item}</span>
         		</c:when>
         	<c:otherwise>
         		<span class="pagingFont"><a href="/board/list?page=${item}">${item}</a></span>
         	</c:otherwise>
        </c:choose>
      	</c:forEach>
         
      </div>
	
	<a href="/board/list"></a>
	<script>
	function moveToDetail(i_board) {
		location.href = "/board/detail?i_board=" + i_board
	}
	function chageRecoredCnt() {
		selFrm.submit()
	}
	
	</script>
</body>
</html>