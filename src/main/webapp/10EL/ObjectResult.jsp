<%@page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 객체 매개변수</title>
</head>
<body>
	<h2>영역을 통해 전달된 객체 읽기</h2>
	<!-- 
		영역애 저장된 속성에 EL로 접근할 때는 속성명이 중복되지 않는 경우라면
		EL내장객체없이 속성명 만으로 접근할 수 있다.
		
		즉, requestScope.personObj.name 형태로 기술하지 않아도 된다.
	 -->
	<ul>
	<!-- "속성명.멤버변수" 형태로 기술하면,
		객체의 getter()를 자동으로 호출하게 되어 값이 출력된다. 
		
		즉, 아래 문장은 getter()를 호출한다.
		(Person클래스에 getter()가 없으면 에러가 발생한다.)
		
		또한, 출력 시 형변환이 자동으로 됨으로 더욱 편리하다.
	-->
		<li>Person 객체 => 이름 : ${ personObj.name }, 나이 : ${ personObj.age }</li> <!-- 생략 : 속성명.멤버변수 -->
		<!-- requestScope은 생략할 수 있다. -->
		<li>String 객체 => ${ requestScope.stringObj }</li> <!-- 생략 안한 경우 -->
		<li>Integer 객체 => ${ integerObj }</li> <!-- 생략 한 경우 -->
	</ul>
	
	<h2>JSP내강객체를 통해 영역의 값 읽어오기</h2>
	<%
	// 영역은 모든 객체를 저장할 수 있는 공간임으로 Object형으로 저장된다.
	Object object = request.getAttribute("personObj");
	// 따라서 영역에서 객체를 꺼내서 사용할 때는 원래 형으로 형변환 해야한다.
	Person person = (Person)object;
	// 출력시에는 getter()를 사용한다.
	out.print("이름 : " + person.getName() + "<br>");
	%>
	나이 : <%= person.getAge() %>
	
	<!-- 
	파라미터로 전달된 값을 읽을때 아래 3가지 모두 사용할 수 있다.
		param.파라미터명
		param['파라미터명']
		param["파라미터명"]
	 -->
	<h2>매개변수로 전달된 값 읽기</h2>
	<ul>
		<!-- EL에서는 산술연산이 가능함으로 아래에서는 30이 출력된다.
			 또한, 파라미터로 전달된 문자열을 숫자로 자동변환 해준다. -->
		<li>${ param.firstNum + param['secondNum'] }</li>
		<!-- 단순한 출력이므로 10 + 20으로 출력된다. -->
		<li>${ param.firstNum } + ${ param["secondNum"] }</li>
	</ul>
</body>
</html>