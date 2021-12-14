<%@page import="utils.BoardPage"%>
<%@page import="model1.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
// DAO객체 생성 및 DB연결
BoardDAO dao = new BoardDAO(application);

// 검색어가 있는 경우 파라미터를 저장하기 위한 Map컬렉션 생성
Map<String, Object> param = new HashMap<String, Object>();
// 검색 파라미터를 rquest내장객체를 통해 얻어온다.
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
// 검색어가 있는 경우에만
if(searchWord != null){
	// Map컬렉션에 파라미터 값을 추가한다.
	param.put("searchField", searchField); // 검색필드명(title, content 등)
	param.put("searchWord", searchWord); // 검색어
}
// board테이블에 저장된 게시물의 갯수 카운드
int totalCount = dao.selectCount(param);


// 페이지 처리를 위한 코드 추가 부분
/********** 페이지 처리 start **********/
	// 컨텍스트 초기화 파라미터를 얻어온 후 사칙연산을 위해 정수로 변경한다.
int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));

	// 전체 페이지 수를 계산한다.
		// ★ 이 때 double로 형변환 하는 이유는 
			// 형변환 X 계산 ex. 108/10 = 10     ▶ 올림  ▶ 10page
			// 형변환 O 계산 ex. 108.0/10 = 10.8 ▶ 올림  ▶ 11page
int totalPage = (int)Math.ceil((double)totalCount / pageSize);
/*
목록에 첫 진입시에는 페이지 관련 파라미터가 없음으로 무조건 1page로 지정한다.
만약 pageNum이 있다면 파라미터를 받아와서 정수로 변경한 후 페이지수로 지정한다.
*/
	
int pageNum = 1;
String pageTemp = request.getParameter("pageNum");
if(pageTemp != null && !pageTemp.equals(""))
	pageNum = Integer.parseInt(pageTemp);

// 게시물의 구간을 계산한다.
int start = (pageNum - 1) * pageSize + 1; // 구간의 시작
int end = pageNum * pageSize; // 구간의 끝
param.put("start", start); // Map컬렉션에 저장 후 DAO로 전달함.
param.put("end", end);
/**********  페이지 처리 end **********/

// 게시물 목록 받기
List<BoardDTO> boardLists = dao.selectListPage(param);
// 자원 해제
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
</head>
<body>
	<jsp:include page="../Common/Link.jsp"/>
	<h2>목록 보기(List) - 현재 페이지 : <%= pageNum %> (전체 : <%= totalPage %>)</h2>
	
	<form method="get">
		<table border="1" width="90%">
			<tr>
				<td align="center">
					<select name="searchField">
						<option value="title">제목</option>
						<option value="content">내용</option>
					</select>
					<input type="text" name="searchWord"/>
					<input type="submit" name="검색하기" value="검색"/>
				</td>
			</tr>
		</table>
	</form>
	
	<!-- 게시물 목록 페이블(표) -->
	<table border="1" width="90%">
		<!-- 각 컬럼의 이름 -->
		<tr>
			<th width="10%">번호</th>
			<th width="50%">제목</th>
			<th width="15%">작성자</th>
			<th width="10%">조회수</th>
			<th width="15%">작성일</th>
		</tr>
		<%
		if(boardLists.isEmpty()){
		%>
		<tr>
			<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
		</tr>
		<%
		}else{
			// 게시물이 있을때
			int virtualNum = 0; // 게시물의 출력번호
			int countNum = 0;
			for(BoardDTO dto : boardLists){
				/* virtualNum = totalCount--; */
				virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
		%>
		<tr align="center">
			<td><%= virtualNum %></td>
			<td align="left">
				<a href="View.jsp?num=<%= dto.getNum() %>"><%= dto.getTitle() %></a>
			</td>
			<td align="center"><%= dto.getId() %></td>
			<td align="center"><%= dto.getVisitcount() %></td>
			<td align="center"><%= dto.getPostdate() %></td>
		</tr>
<%
			}
		}
%>
	</table>
	
	<table border="1" width="90%">
		<tr align="right">
			<!-- 페이징 처리 -->
			<td>
				<%= BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI()) %>
				<!-- 
				request.getRequestURI() : request내장 객체를 통해 현재 페이지에서
					HOST부분을 제외한 전체 경로명(URI)을 얻을 수 있다.
					여기서 얻은 경로명을 통해 "경로명?pageNum=번호"와 같은 링크를 만들 수 있다.
					getRequestURI() : HOST 제외 전체 경로명
					getRequestURL() : HOST 포함 전체 경로명
				 -->
			</td>
			<td><button type="button" onclick="location.href='Write.jsp';">글쓰기</button></td>
		</tr>
	</table>
</body>
</html>