<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<style>
.pointerCursor {
	cursor: pointer;
}

span {
	background: linear-gradient(to bottom, #ba5370, #f4e2d8);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
}

button {
	backgound-color: #f4e2d8;
}
</style>
</head>
<body>
	<div class="container">
        <table>
            <tr id="title">
                <th>제목</th>
                <th colspan="6">${data.title}</th>
            </tr>
            <tr class="boardInfo">
                <th id="nm">작성자</th>
                <td id="nm-1">${data.nm }</td>
                <th id="date">작성일시</th>
                <td id="date-1"> ${data.r_dt } <small>${data == null ? '' : '수정' }</small> </td>
                <th id="hits">조회수</th>
                <td id="hits-1">${data.hits }</td>
                <td class="pointerCursor" onclick="toggleLike(${data.yn_like})">
                   <c:if test="${data.yn_like==0 }">
                      <span class="material-icons">favorite_border</span>
                   </c:if>
                   <c:if test="${data.yn_like==1 }">
                      <span class="material-icons">favorite</span>
                   </c:if>
                </td>
            </tr>
        </table>
        <div class="ctnt">
            ${data.ctnt }
        </div>
        <div class="btn">
             <a href="/board/list"><button type="button">목록</button></a>
             <c:if test="${loginUser.i_user == data.i_user }">
                <a href="/regmod?i_board=${data.i_board}">
                   <button type="submit">수정</button>
                </a>
                <form id="delFrm" action="/board/del" method="post">
                    <input type="hidden" name="i_board" value="${data.i_board}">
                    <a href="#" onclick="submitDel()"><button type="submit">삭제</button></a>
                </form>
            </c:if>
        </div>
        
        <div class="marginTop30">
           <form id="cmtFrm" action="/board/cmt" method="post">
              <input type="hidden" name="i_cmt" value="0">
              <input type="hidden" name="i_board" value="${data.i_board}">
              <div>
                 <input type="text" id="cmt" name="cmt" placeholder="댓글내용">
                 <input type="submit" id="cmtSubmit" value="전송">
                 <input type="button" value="취소" onclick="clkCmtCancel()">
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
                    <td>${item.m_dt}</td>
                    <td>
                       <c:if test="${item.i_user==loginUser.i_user}">
                          <a href="/board/cmt?i_board=${data.i_board}&i_cmt=${item.i_cmt}"><button>삭제</button></a>
                          <button onclick="clkCmtMod(${item.i_cmt}, '${item.cmt}')">수정</button>
                       </c:if>
                    </td>
                 </tr>
              </c:forEach>
           </table>
        </div>
    </div>

	<script>
		function clkCmtCancel() {
	        cmtFrm.i_cmt.value = 0
	        cmtFrm.cmt = ''
	        cmtSubmit.value = '전송'
	     }
	  
	     // 댓글 수정
	     function clkCmtMod(i_cmt, cmt) {
	        console.log('i_cmt: '+i_cmt)
	        console.log('cmt: '+cmt)
	        
	        cmtFrm.i_cmt.value = i_cmt
	        cmtFrm.cmt.value = cmt
	        
	        cmtSubmit.value = '수정'
	     }

	
		function submitDel() {
			delFrm.submit()
		}
		function toggleLike(yn_like) {			//키값      //밸류값
			location.href="/board/toggleLike?i_board=${data.i_board}&yn_like=" + yn_like
		
		}

	</script>
</body>
</html>