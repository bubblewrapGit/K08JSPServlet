<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 예시에서 사용할 변수 선언
pageContext.setAttribute("num1", 9);
pageContext.setAttribute("num2", "10");

pageContext.setAttribute("nullStr", null);
pageContext.setAttribute("emptyStr", "");
pageContext.setAttribute("lengthZero", new Integer[0]);
pageContext.setAttribute("sizeZero", new ArrayList());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 연산자</title>
</head>
<body>
	<!-- 
		null, 빈문자열, 길이가 0인 컬렉션, 크기가 0인 경우
		empty 연산자는 true를 반환한다.
	 -->
	<h3>empty 연산자</h3>
	empty nullStr : ${ empty nullStr }<br>
	empty emptyStr : ${ empty emptyStr }<br>
	empty lengthZero : ${ empty lengthZero }<br>
	empty sizeZero : ${ empty sizeZero }
	
	<hr>
	<h3>삼항 연산자</h3>
	num1 gt num2 ? "참" : "거짓" => ${ num1 gt num2 ? "num1이 크다" : "num2가 크다" }
	
	<!-- 
		EL에서는 null을 0으로 판단한다. 따라서 아래의 결과는 10이 나오게된다.
		
		단, null과 정수를 연산하는 부분을 이클립스는 에러로 표시한다.
		하지만 실행에는 전혀 문제가 없다.
	 -->	
	<hr>
	<h3>null 연산</h3>
	null + 10 : ${ null + 10 }<br>
	nullStr + 10 : ${ nullStr + 10 }<br>
	param.noVar > 10 : ${ param.noVar > 10 }
</body>
</html>