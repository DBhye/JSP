<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
<style> 
	.pointerCursor { cursor: pointer; }
	span { 
background: linear-gradient(to bottom, #ba5370, #f4e2d8);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;}
  button { backgound-color:#f4e2d8; }
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
		</c:if>
	</div>
	<div>제목: ${data.title}</div>
	<div>일시: ${data.r_dt}</div>
	<div>작성자: ${data.nm}</div>
	<div>조회수: ${data.hits}</div>
	<div class="pointerCursor" onclick="toggleLike((${data.yn_like}))">
		  <c:if test="${data.yn_like==0 }">
             <span class="material-icons">favorite_border</span>
          </c:if>
          <c:if test="${data.yn_like==1 }">
             <span class="material-icons">favorite</span>
          </c:if>
	</div>
	<hr>
	<div>
		<form id="cmtFrm" action="/board/cmt" method="post">
			<input type="hidden" name="i_cmt" value="0">
			<input type="hidden" name="i_board" value="${data.i_board}">
		<div>${data.ctnt}</div>
		<div>
			<input type="text" name="cmt" placeholder="댓글내용">
			<input type="submit" value="전송">
		</div>
	</form>
	</div>
	 <div class="marginTop30">
        	<table>
        		<tr>
        			<th>내용</th>
        			<th>글쓴이</th>
        			<th>등록일</th>
        			<th>비고</th>
        		</tr>
        		<c:forEach items="${cmtList}" var="item">
        			<tr>
        				<td>${item.cmt}</td>
        				<td>${item.nm}</td>
        				<td>${item.r_dt}</td> 
        				<td>
        				<c:if test="${item.i_user == loginUser.i_user}">
        						<a href="/board/cmt?i_board=${data.i_board}&i_cmt=${item.i_cmt}"><button>삭제</button></a>
        						<button>수정</button>
        				</c:if>

					</td>
        			</tr>
        		</c:forEach>
        	</table>
        </div>
    </div>
	<script>
		function submitDel() {
			delFrm.submit()
		}
		function toggleLike(yn_like) {			//키값      //밸류값
			location.href="/board/toggleLike?i_board=${data.i_board}&yn_like=" + yn_like
		
		}
	function updCmt() {
		updFrm.submit()
	}
	</script>
</body>
</html>