<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%
   String msg = "";
   String err = request.getParameter("err");
   if(err != null){
	   switch(err) {
	   case "10":
	   msg = "등록할 수 없습니다.";
	   break;
	   case "20":
		msg =  "DB에러발생";
		break;
   	}
   }
   %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<style>
#msg {color:red}</style>
</head>
<body>
<div id="msg"><%=msg%></div>
	<div>
		
		<form id="frm" action="/JSP/boardWriteProc.jsp" method="post" onsubmit="return false">
			<div><label>제목:<br><input type="text" name="title"></label></div>
			<div><label>내용:<br><textarea name="ctnt"></textarea></label></div>
			<div><label>작성자:<br><input type="text" name="i_student"></label></div>
			<div><input type="submit" value="글등록"></div>
		<%//name이라는 친구는 주소창의 value가 된다.(get방식) 내용적으로 중요하지 않으면 get 방식으로 하면된다.
			//label 태그는 주로 radio나 checkbox에 편하기 위해서 사용. form에 이름붙일때 사용
			//name은 서버에 값 날릴때 key값으로 쓰기 위함이다. id나 class는 key값으로 쓰일 수 없다.
			// onsubmit은 콜백함수 글등록을 날렸을때 안날아가게 함 -> onsubmit="return false"
			//console.log('title :'+frm.title.value)와 같다.%>	
		</form>
	</div>
	<script>
	function chk() {
		console.log(`title:\${frm.title.value}`)frm.title.value
		if(eleValid(frm.title,'제목')){
			return false
		} else if(eleValid(frm.ctnt,'내용')) {
			return false
		} else if(eleValid(frm.i_student,'작성자')){
			return false
		}
		
		/*
		if(frm.title.value ==") {
			alert('제목을 입력해 주세요.')
			frm.title.focus()
			return false
		} else if (frm.ctnt.value.length == 0){
			alert('내용을 입력해주세요.')
			frm.ctnt.focus()
			return false
		} else if (frm.i_student.value.length ===0) {
			alert('작성자를 입력해주세요')
			frm.i_student.focus()
			return false
		}*/
		
		return false
	}
	</script>
</body>
</html>