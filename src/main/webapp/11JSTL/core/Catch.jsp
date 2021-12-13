<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - catch</title>
</head>
<body>
	<!-- 
		catch태그
			- EL이나 JSP에서 발생한 예외를 처리할때 사용한다.
			- 에러 내용을 원하는 위치에 출력할 수 있다.
			- JSTL문법 오류는 catch되지 않는다.
	 -->
	<h4>자바 코드에서의 예외</h4>
	<%
	int num1 = 100;
	%>
	<c:catch var="eMessage">
		<%
		int result = num1 / 0;
		%>
	</c:catch>
	예외 내용 : ${ eMessage } <!-- 0으로 나눌 수 없음 => java.lang.ArithmeticException: / by zero -->
	
	<h4>EL에서의 예외</h4>
	<c:set var="num2" value="200"/>
	
	<c:catch var="eMessage">
		${"일" + num2 }
	</c:catch>
	예외 내용 : ${ eMessage }<!-- EL에서는 문자 + 숫자 는 연산 불가하다 -->
	<!-- => NumberFormatException: For input string: "일" -->
</body>
</html>