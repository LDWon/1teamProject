<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>FIND</title>
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath }/resources/css/missing/missing_list.css">
	</head>
	<body>
		<jsp:include page="../main/top.jsp" flush="false" />
		<div class="wrapper">
			<div class="wrap">
			<h1 align="center">공지사항</h1>
				<table border="1" align="center">
					<tr>
						<th width="50">번호</th>
						<th width="300">제목</th>
						<th width="100">작성자</th>
						<th width="100">등록일</th>
					</tr>
	
					<c:forEach var="notice" items="${n_list}">
						<!-- var = notice로 선언과  noticeDAO에  n_list를 불러온다 -->
						<tr>
							<td align="center">${notice.idx}</td>
							<!-- 선언명 . n_list에 idx 가져오기  -->
							<td><a
								href="notice_view.do?idx=${notice.idx}&page=${param.page}"> <font
									color="black">${notice.subject}</font>
							</a></td>
							<td align="center">${notice.name}</td>
							<td align="center">${fn:split(notice.regidate,' ')[0]}</td>
						</tr>
					</c:forEach>
					<!-- 하단 페이지 처리  메뉴버튼   -->
					<tr>
						<td colspan="6" align="center">${pageMenu}</td>
					</tr>
				</table>
			</div>
		</div>
		<!-- 푸터 영역   -->
		<jsp:include page="../main/footer.jsp" flush="false" />
	</body>
</html>