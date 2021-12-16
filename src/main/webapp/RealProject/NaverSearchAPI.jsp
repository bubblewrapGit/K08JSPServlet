<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script type="text/javascript">
	$(function(){
		// $.ajax메서드에서 반복적으로 사용되는 속성을 묶어 정의한다.
		$.ajaxSetup({
			url : "../NaverSearchAPI.do", // 요청URL(서버측)
			type : "get", // 전송방식
			contentType : "text/html;charset:utf-8;", // 전송방식에 따른 컨텐츠 타입
			dataType : "json", // 콜백데이터의 형식
			success : sucFuncJson, // 성공했을때 호출할 콜백메서드
			error : errFunc // 실패했을때 호출할 콜백메서드
		});
		/*
			앞의 $.ajaxSetup() 메서드에서 모든 속성에 대해 설정이 완료되었음으로
			아래에서는 추가로 설정할 값이 없다. 이 경우 속성을 생략해도 된다.
		*/
		$('#searchBtn').click(function(){
			$.ajax({
				// 버튼을 클릭했을때 요청
				data : { // 서버로 전송할 파라미터(JSON타입으로 만들어야 함.)
					keyword : $('#keyword').val(), // 검색어
					startNum : $('#startNum option:selected').val() // 페이지번호
				},
			});
		});
		$('#startNum').change(function(){
			$.ajax({
				// 셀렉트박스를 선택했을때 요청	
				data : { // 서버로 전송할 파라미터(JSON타입으로 만들어야 함.)
					keyword : $('#keyword').val(), // 검색어
					startNum : $('#startNum option:selected').val() // 페이지번호
				},
			});
		});
	});
	function sucFuncJson(d){
		console.log("성공", d); // 로그로 출력
		var str = "";
		// 콜백된 JSON데이터는 객체임으로 "매개변수.키값"형태로 파싱할 수 있다.
		console.log("검색결과", d.total);
		
		// items키값의 데이터는 배열임으로 갯수만큼 반복이 가능하다.
		/*
		$.each(배열데이터, function(반복시 index반환, 반복시 해당 객체 반환)
			반복된 요소들은 하나의 문자열로 만들어 준다.
		*/
		$.each(d.items, function(index, item){
			str += "<ul>";
			str += "	<li>" + (index+1) + "</li>";
			str += "	<li>" + item.description + "</li>";
			str += "	<li>" + item.bloggername + "</li>";
			str += "	<li>" + item.bloggerlink + "</li>";
			str += "	<li>" + item.postdate + "</li>";
			str += "	<li><a href='" + item.link + "' ";
			str += "	target='_black'>바로가기</a></li>";
			str += "</ul>";
		});
		// 앞에서 생성된 문자열을 화면에 출력한다.
		$("#searchResult").html(str);
	}
	function errFunc(e){
		alert("실패 : "+e.status);
	}
    </script>
    <style>
    	ul{border:2px #cccccc solid;}
    </style>
</head>
<body>
	<div class="container">
	<!-- 
	Ajax를 통해 비동기 통신을 구현할때는 반드시 요청한 페이지에서
	콜백할 데이터가 정상적으로 출력되는지 직접 확인해야 한다.(매우 중요)
	 -->
		<div class="row">
			<a href="../NaverSearchAPI.do?keyword=한국소프트웨어인재개발원&startNum=1">
				네이버검색정보JSON바로가기
			</a>
		</div>	
		<div class="row">
			<form id="searchFrm">			
				한페이지에 20개씩 노출됨 <br />
				
				<select id="startNum">
					<option value="1">1페이지</option>
					<option value="21">2페이지</option>
					<option value="41">3페이지</option>
					<option value="61">4페이지</option>
					<option value="81">5페이지</option>
				</select>
				
				<input type="text" id="keyword" size="30" value="한국소프트웨어인재개발원" />
				<button type="button" class="btn btn-info" id="searchBtn">
					Naver검색API요청하기
				</button>		
			</form>	
		</div>
		
		<div class="row" id="searchResult">
			요기에 정보가 노출됩니다
		</div>		
	</div>
</body>

</html>