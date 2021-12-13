<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
SimpleDateFormat dateFormate = new SimpleDateFormat("HH:mm:ss");

long creationTime = session.getCreationTime();
String creationTimeStr = dateFormate.format(new Date(creationTime));

long lastTime = session.getLastAccessedTime();
String lastTimeStr = dateFormate.format(new Date(lastTime));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Session</title>
</head>
<body>
	<h2>Session 설정 확인</h2>
	<!-- 
		web.xml에서 <session-config>엘레이먼트를 통해 설정한다.
		분 단위로 설정하게 되고 아래에서는 초 단위로 출력된다.
	 -->
	<ul>
		<li>세션 유지 시간 : <%= session.getMaxInactiveInterval() %>
		<li>세션 아이디 : <%= session.getId() %>
		<li>최초 요청 시각 : <%= creationTimeStr %>
		<li>마지막 요청 시각 : <%= lastTimeStr %>
	</ul>

</body>
</html>