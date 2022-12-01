<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>사번</th>
			<th>이름</th>
			<th>입사일</th>
		</tr>
		
		<c:forEach var="vo" items="${ empList }">
			<tr>
				<td>${ vo.empno }</td>
				<td>${ vo.ename }</td>
				<td>${ vo.hiredate }</td>
			</tr>
		</c:forEach>
		
	</table>
</body>
</html>
















