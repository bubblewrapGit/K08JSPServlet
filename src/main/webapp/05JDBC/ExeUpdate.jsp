<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC</title>
</head>
<body>
	<h2>회원 추가 테스트(executeUpdate() 사용)</h2>
	<% 
	// JDBC를 통한 DB 연결
	JDBConnect jdbc = new JDBConnect();
	
	// 입력할 회원데이터 준비(하드코딩)
	String id = "test1";
	String pass = "1111";
	String name = "테스트1회원";
	
	// 쿼리문 준비(입력값에 대한 부분은 ?(인파라미터)로 처리한다.)
	String sql = "INSERT INTO member VALUES(?, ?, ?, sysdate)";
	// 동적쿼리 실행을 위한 prepared객체 생성
	PreparedStatement psmt = jdbc.con.prepareStatement(sql);
	// 인파라미터 설정(인덱스는 1부터 시작한다.)
	psmt.setString(1, id);
	psmt.setString(2, pass);
	psmt.setString(3, name);
	
	// 행에 영향을 주는 update, delete, insert문을 실행할때 사용하는 메서드
	int inResult = psmt.executeUpdate(); // 반환값은 적용된 행의 갯수임으로 int사용
	out.println(inResult + "행이 입력되었습니다.");
	
	// 자원해제(객체 소멸)
	jdbc.close();
	%>
</body>
</html>