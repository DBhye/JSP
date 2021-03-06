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
.containerPImg {
		display: inline-block;	
		width: 30px;
		height: 30px;
	    border-radius: 50%;
	    overflow: hidden;
	}
	
	.pImg {
	
		 object-fit: cover;
		  max-width:100%;
	}
	
	.highlight {
		color: red;
		font-weight: bold;
	}
	#likeListContainer {			
			padding: 10px;			
			opacity: 0;
			border: 1px solid #bdc3c7;
			position: absolute;
			left: 0px;
			top: 30px;
			width: 130px;
			height: 0;
			overflow-y: auto;
			background-color: white !important;
			transition-duration : 500ms;
		}		
		#id_like { 
			position:relative;
			font-size: 1em;
		 }		
		
		#id_like:hover #likeListContainer {
			height: 130px;						
			opacity: 1;
		}
		
		.profile {
			background-color: white !important;
			display: inline-block;	
			width: 25px;
			height: 25px;
		    border-radius: 50%;
		    overflow: hidden;
		}		
		
		.likeItemContainer {
			display: flex;
		}
		
		.likeItemContainer .nm {
			background-color: white !important;
			margin-left: 7px;
			font-size: 0.7em;
			display: flex;
			align-items: center;
		}
</style>
</head>
<body>
	<div class="container">
        <table>
            <tr id="title">
                <th>제목</th>
                <th colspan="6" id="elTitle">${data.title}</th>
            </tr>
            <tr class="boardInfo">
                <th id="nm">작성자</th>
                <td id="nm-1"><div class="containerPImg">
							<c:choose>
								<c:when test="${data.profile_img != null}">
									<img class="pImg" src="/img/user/${data.i_user}/${data.profile_img}">
								</c:when>
								<c:otherwise>
									<img class="pImg" src="/img/cat.jpg">
								</c:otherwise>
							</c:choose>
						</div>
						${data.nm}</td>
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
              <c:if test="${data.like_cnt > 0}">
            	<tr>
            		<td colspan="7">
            			<span id="id_like" class="pointerCursor">좋아요 ${data.like_cnt}개
	            			<div id="likeListContainer">
	            				<c:forEach items="${likeList}" var="item">
	            					<div class="likeItemContainer">
	            						<div class="profileContainer">
	            							<div class="profile">
		            							<c:choose>
		            								<c:when test="${item.profile_img == null}">
		            									<img class="pImg" src="/img/cat.jpg">
		            								</c:when>
		            								<c:otherwise>
		            									<img class="pImg" src="/img/user/${item.i_user}/${item.profile_img}">
		            								</c:otherwise>
		            							</c:choose>
	            							</div>
	            						</div>
	            						<div class="nm">${item.nm}</div>
	            					</div>
	            				</c:forEach>
		   	 				</div>
            			</span>
            		</td>
            	</tr>
            </c:if>
        </table>
        <div class="ctnt" id="elCtnt">
            ${data.ctnt }
        </div>
        <div class="btn">
             	<a href="/board/list?page=${param.page}&record_cnt=${param.record_cnt}&searchText=${param.searchText}&searchType=${param.searchType}">목록</a>
             <c:if test="${loginUser.i_user == data.i_user }">
                <a href="/board/regmod?i_board=${data.i_board}">
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
                 <th></th>
                 <th>글쓴이</th>
                 <th>등록일</th>
                 <th>비고</th>
              </tr>
              <c:forEach items="${cmtList}" var="item">
                 <tr>
                    <td>${item.cmt}</td>
                    <td><div class="containerPImg">
							<c:choose>
								<c:when test="${item.profile_img != null}">
									<img class="pImg" src="/img/user/${item.i_user}/${item.profile_img}">
								</c:when>
								<c:otherwise>
									<img class="pImg" src="/img/cat.jpg">
								</c:otherwise>
							</c:choose>
						</div>
						${item.nm}</td>
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
		cmtFrm.cmt.value = ''  //홑따옴표
		cmtSubmit.value = '전송'
	}

	function clkCmtDel(i_cmt) {
		if(confirm('삭제 하시겠습니까?')) {
			location.href = '/board/cmt?i_board=${data.i_board}&i_cmt=' + i_cmt
		}
	}
	
	//댓글 수정
	function clkCmtMod(i_cmt, cmt) {
		console.log('i_cmt : ' + i_cmt)
		
		cmtFrm.i_cmt.value = i_cmt
		cmtFrm.cmt.value = cmt
		
		cmtSubmit.value = '수정'
	}

	function toggleLike(yn_like) {
		location.href='/board/toggleLike?i_board=${data.i_board}&yn_like=' + yn_like
	}

    function submitDel() {
        delFrm.submit()
    }
    
    function doHighlight() {
    	var searchText = '${param.searchText}'
    	var searchType = '${param.searchType}'
    	
    	switch(searchType) {
    	case 'a': //제목
    	//자바스크립트에서 replaceAll은 없다.
 
    		var txt = elTitle.innerText
    		txt = txt.replace(new RegExp('${searchText}'), '<span class="highlight">' + searchText + '</span>')
    		elTitle.innerHTML = txt
    		break
    	case 'b': //내용
    		var txt = elCtnt.innerText
    		txt = txt.replace(new RegExp('${searchText}'), '<span class="highlight">' + searchText + '</span>')
    		elCtnt.innerHTML = txt
    		
    		break
    	case 'c': //제목+내용
    		var txt = elTitle.innerText
    		txt = txt.replace(new RegExp('${searchText}'), '<span class="highlight">' + searchText + '</span>')
    		elTitle.innerHTML = txt
    		
    		txt = elCtnt.innerText
    		txt = txt.replace(new RegExp('${searchText}'), '<span class="highlight">' + searchText + '</span>')
    		elCtnt.innerHTML = txt
    		break
    	}
    }
    
    doHighlight()
    
	</script>
</body>
</html>