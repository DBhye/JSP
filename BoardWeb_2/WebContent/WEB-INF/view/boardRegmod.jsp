<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>
	<div>글쓰기</div>
	<form id="frm" action="/boardWrite.jsp" method="post" <%/*onsubmit="return chk()"*/%>>
			<div><label>제목:<br><input type="text" name="title"></label></div>
			<div><label>내용:<br><textarea name="ctnt"></textarea></label></div>
			<div><label>작성자:<br><input type="text" name="i_student"></label></div>
			<div><input type="submit" value="글등록"></div>
			</form>
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
		}
			function eleValid(ele, nm){
			if(ele.value.length == 0) {
				alert(nm+'을(를) 입력해주세요.')
				ele.focus()
				return true
			}
			
		}
	</script>
</body>
</html>