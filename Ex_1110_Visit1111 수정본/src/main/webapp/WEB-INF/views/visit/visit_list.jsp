<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="/vs/resources/css/visit.css">

<!-- Ajax를 사용하기 위한 httpRequest.js파일을 참조 -->
<!-- Ajax(Asynchronous Javascript And Xml) : 비동기 통신 -->
<script src="/vs/resources/js/httpRequest.js"></script>

<script>
	function del(f){
		
		var pwd = f.pwd.value;//원본비번
		var c_pwd = f.c_pwd.value;//입력비번
		
		if( pwd != c_pwd ){
			alert("비밀번호 불일치");
			return;
		}
		
		if( !confirm('정말 삭제하시겠습니까?') ){
			return;
		}
		
		//idx를 Ajax를 통해서 서버로 전달
		var url = "delete.do";
		var param = "idx=" + f.idx.value;
		//준비된 두 개의 정보를 콜백메서드로 전달
		sendRequest( url, param, resultFn, "GET" );
		
	}
	
	//콜백메서드를 생성
	function resultFn(){
		//서버에서 넘어온 데이터를 받아오기 위한 메서드
		//xhr.readyState 
		//1 ~ 3 : 페이지 로드중
		//4 : 페이지로드 완료
		
		//xhr.status
		//404, 500등의 오류를 가지고 오거나 200의 정상적인 결과를 가지고 오는 속성
		
		if( xhr.readyState == 4 && xhr.status == 200 ){
			
			//xhr.responseText : 컨트롤러에서 return으로 보내준 결과값
			var data = xhr.responseText;
		
			if( data == 'no' ){
				alert("삭제 실패");
				return;
			}
			
			alert("삭제성공");
			location.href="list.do";
		}
	}
	
	//게시글 수정
	function modify(f){
		var pwd = f.pwd.value;
		var c_pwd = f.c_pwd.value;
		
		if( pwd != c_pwd ){
			alert("비밀번호 불일치");
			return;
		}
		
		f.action = 'modify_form.do';
		f.method = "post";
		f.submit();
		
	}
	
</script>

</head>
<body>

	<div id="main_box">
		<h1>:::방명록 리스트:::</h1>
		
		<div align="center">
			<input type="button" value="글쓰기"
			       onclick="location.href='insert_form.do'">
		</div>
	</div>
	
	<c:forEach var="vo" items="${ list }">
		<div class="visit_box">
			<div class="type_content"><pre>${ vo.content }</pre></div>
			<div class="type_name">${ vo.name }(${vo.ip})</div>
			<div class="type_regdate">작성일 : ${ vo.regdate }</div>
			
			<form>
			<input type="hidden" name="idx" value="${ vo.idx }">
			<input type="hidden" name="pwd" value="${ vo.pwd }">
			비밀번호 : <input type="password" name="c_pwd">
			<input type="button" value="수정" onclick="modify(this.form);">
			<input type="button" value="삭제" onclick="del(this.form);">
			</form>
		</div>
	</c:forEach>
	
</body>
</html>























































