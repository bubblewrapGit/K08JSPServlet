<%@page import="utils.CookieManager"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 전송된 폼값을 받는다..
String user_id = request.getParameter("user_id");
String user_pw = request.getParameter("user_pw");
/*
	checkbox의 경우 둘 이상의 값이라면 getPrameterValues()를 통해 받아야 하지만
	항목이 한개라면 getParameter()로 받을수 있다.
	
	받는 값 단수(1개) : getParameter()
	받는 값 복수(n개) : getPrameterValues()
*/
String save_check = request.getParameter("save_check");

// 아이디&패스워드가 일치하는 경우 로그인 성공 처리
if("must".equals(user_id) && "1234".equals(user_pw)){
	// 로그인 성공시 아이디 저장 체크를 햇다면
	if(save_check != null && save_check.equals("Y")){
		// 쿠키를 저장한다. 쿠키값은 로그인 아이디, 유효기간(1일)
		CookieManager.makeCookie(response, "loginId", user_id, 86400);
	}else{
		CookieManager.deleteCookie(response, "loginId");		
	}
	//JSFunction.alertLocation("로그인에 성공했습니다.", "IdSaveMain.jsp", out);
	%>
	<script>
		alert("로그인에 성공하였습니다.");
		location.href="IdSaveMain.jsp";
	</script>
	<%
}else{
	//로그인 실패
	//JSFunction.alertBack("로그인에 실패했습니다.", out);
	%>
	<script>
		alert("로그인에 실패하였습니다.");
		history.back();
	</script>
	<%
}
%>