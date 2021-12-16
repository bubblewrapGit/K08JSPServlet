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
</head>
<script type="text/javascript">
	$(document).ready(function(){
		// select를 선택하면 발생되는 change이벤트를 통해 서버로 요청
		$("#goodsOptionId01").change(function(){
			$.ajax({
				url : "../ShoppingOptions.choice", // 요청URL
				type : "get",	// 전송방식
				data : {	// 파라미터 : select에서 선택한 값
					goodsOptionName : $("#goodsOptionId01").val()
				},
				dataType : "json", // 콜백데이터의 형식
				contentType : "text/html;charset:utf-8",
				success : function(d){
					// totalPrice에 있는 가격을 가져와서 parseInt로 정수형태로 변환
					var totalPrice = parseInt($("#totalPrice").val());
					// 선택한 옵션의 value값을 얻어옴.
					var goodsOption = $("#goodsOptionId01").val();
					// 선택한 옵션에 따라 value값을 totalPrice에 더해줌
					if(goodsOption=="op01") totalPrice += 5000;
					if(goodsOption=="op02") totalPrice += 7000;
					if(goodsOption=="op03") totalPrice += 10000;
					// value값에 계산된 totalPrice를 적용함. 
					$("#totalPrice").val(totalPrice);
					// 브라우저에 총 금액을 출력함.
					$("#priceDisplay").html("총상품금액 : " + totalPrice);
					
					// 콜백된 데이터를 통해 옵션 테이블을 생성한다.
					var table = ""
						+"<table class='table table-bordered'>"
						+"<tr>"
						+"<td>옵션명</td>"
						+"<td>"+d.optionName+"</td>"
						+"</tr>"
						+"<tr>"
						+"<td colspan='2' class='info'>추가비용 : "+d.optionPrice+"원</td>"
						+"</tr>"
						+"</table>";
						console.log(d);
						
						//웹 브라우저에 옵션상품을 추가한다.
						$("#goodsList").append(table);
						
						// 옵션을 선택한 후 최초 상태로 리셋한다.
						$("#goodsOptionId01").val('');
				},	
				error : function(e){
					alert("실패"+e.status)
				}
				
			})
		})
	})
	
	// 썸네일 이미지에 마우스 오버시 대표이미지 변경됨
	function imgChange(imgSrc){
		var bigImg = document.getElementById("bigImg");
		// 이미지의 경로 변경
		bigImg.src = "../images/"+imgSrc+".png";
		// 이미지의 스타일 속성을 통해 가로,세로 크기 변경
		bigImg.style.width="367px";
		bigImg.style.height="286px";
	}
</script>

<body>

<div class="container">
    <div class="row">
   	 <h2>쇼핑몰 옵션상품 구현하기</h2>
    </div>
    <div class="row">
   	 <div class="col-md-6">
   		 <table>
   			 <tr>
   				 <td colspan="3"><img src="../images/amazon.png" class="img-thumbnail" id="bigImg" /></td>
   			 </tr>
   			 <tr align="center">
   				 <td><img src="../images/amazon.png" class="img-thumbnail" width="100" onmouseover="imgChange('amazon');"/></td>
   				 <td><img src="../images/chosun.png" class="img-thumbnail" width="100" onmouseover="imgChange('chosun');" /></td>
   				 <td><img src="../images/naver.png" class="img-thumbnail" width="100" onmouseover="imgChange('naver');" /></td>
   			 </tr>
   		 </table>
   	 </div>
   	 <div class="col-md-6">
   		 <!-- 상품가격과 옵션 -->
   		 <form id="goodsFrm">   		 
   		 <!-- 상품가격+옵션가격 -->
   		 <input type="hid-den" id="totalPrice" value="70000" style="background-color:#bbbbbb;color:red;"/>   		 
   		 <table class="table table-bordered">
   		 <colgroup>
   			 <col width="30%"/>
   			 <col width="*"/>
   		 </colgroup>
   		 <tr>
   			 <td>상품명</td>
   			 <td>3 in 1 Type-C HDMI 케이블</td>
   		 </tr>
   		 <tr>
   			 <td>상품가격</td>
   			 <td><del>100,000원</del> -> 70,000원</td>
   		 </tr>
   		 <tr>
   			 <td>옵션선택1</td>
   			 <td>
   				 <select id="goodsOptionId01">
   					 <option value="">선택하삼</option>
   					 <option value="op01">옵션1(+5000)</option>
   					 <option value="op02">옵션2(+7000)</option>
   					 <option value="op03">옵션3(+10,000)</option>
   				 </select>
   			 </td>
   		 </tr>   		 
   		 </table>
   		 </form>   		 
   		 <!-- 선택한 옵션상품이 디스플레이 되는곳 -->
   		 <div class="row" id="goodsList"></div>   		 
   		 <!-- 기본가격 + 옵션가격 -->
   		 <div class="row" id="priceDisplay"
   			 style="font-size:1.5em; color:red;">
   			 총상품금액 : 70,000원
   		 </div>
   	 </div>
    </div>    
</div>


</body>
</html>