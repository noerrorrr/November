<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<!-- Ajax활용을 위한 js파일 로드 -->
	<script src="/vs/resources/js/httpRequest.js"></script>

	<script>
		function send(f){
			var name = f.name.value;
			if( name == '' ){
				alert("이름은 필수");
				return;
			}
			
			//encodeURIComponent : 특수문자가 포함되어 있는 경우에 내용을 그대로 서버로 전달하기 위해
			//존재하는 메서드
			var url = "modify.do";
			var param = "idx="+f.idx.value+
			            "&name="+f.name.value+
			            "&content="+ encodeURIComponent(f.content.value) + 
			            "&pwd=" + encodeURIComponent(f.pwd.value);
			
			sendRequest( url, param, sendCallback, "POST");
		}
		
		function sendCallback(){
			
			if( xhr.readyState == 4 && xhr.status == 200 ){
				
				//"{'result':'no'}"
				var data = xhr.responseText;
				
				//문자열 구조로 넘어온 data를 실제 JSON타입으로 변경
				var json = (new Function('return'+data))();
				
				if( json.result == 'no' ){
					alert("수정실패");
					return;
				}
				
				alert("수정성공");
				location.href="list.do";
				
			}
			
		}
		
		
	</script>

</head>
<body>
	<form>
		<input type="hidden" name="idx" value="${ vo.idx }">
		
		<table border="1" align="center">
			<caption>:::글 수정:::</caption>
			
			<tr>
				<th>작성자</th>
				<td><input name="name" value="${ vo.name }"></td>
			</tr>
			
			<tr>
				<th>내용</th>
				<td><pre><textarea rows="5" cols="50" name="content">${vo.content}</textarea></pre></td>
			</tr>
			
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="pwd" value="${ vo.pwd }">
				</td>
			</tr>
			
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="수정" onclick="send(this.form);">
					<input type="button" value="취소" onclick="location.href='list.do'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>