<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${data == null ? '글등록' : '글수정' }</title>
<style>
.err{
color:#e74c3c;
}
</style>
</head>
<body>
	<div>${data == null ? '글등록' : '글수정' }</div>
	<div class="err">${msg }</div>
	<form id="frm" action="/${data == null ? 'boardWrite' : 'boardMod' }" method="post" Wonsubmit="return chk()">
			<input type="hidden" name="i_board" value="${data.i_board }">
			<div><label>제목:<br><input type="text" name="title" value="${ data.title}"></label></div>
			<div><label>내용:<br><textarea name="ctnt">${data.ctnt }</textarea></label></div>
			<div><label>작성자:<br><input type="text" name="i_student" value="${data.i_student }" ${data==null ? '':'readonly'} ></label></div>
			<div><input type="submit" value="${data == null ? '글등록' : '글수정' }"></div>
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