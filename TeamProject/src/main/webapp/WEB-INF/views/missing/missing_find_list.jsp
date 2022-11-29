<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
				<h1 align="center">종결 게시판</h1>
				<table border="1" align="center">
					<tr>
						<th width="50">번호</th>
						<th width="300">제목</th>
						<th width="100">작성자</th>
						<th width="50">지역</th>
						<th width="100">등록일</th>
						<th width="50">조회수</th>
					</tr>
					<c:forEach var="vo" items="${list}">
						<tr>
							<td align="center">${vo.idx}</td>
							<td>
							<a href="missing_find_view.do?idx=${vo.idx}&page=${param.page}">
								<font color="black">${vo.subject}</font>
							</a>
							</td>
							<c:set var="totalLength" value="${fn:length(vo.name) }" />
							<c:set var="first" value="${fn:substring(vo.name, 0, 1) }" />
							<c:set var="last" value="${fn:substring(vo.name, 2, totalLength) }" />
							<td align="center">${first}*${last}</td>
							<td align="center">${vo.region}</td>
							<td align="center">${fn:split(vo.regidate,' ')[0]}</td>
							<td align="center">${vo.readhit}</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="6" align="center" id="pageMenu"> 
							${pageMenu}
						</td>
					</tr>
				</table>
			</div>
		</div>
	<jsp:include page="../main/footer.jsp" flush="false" />
	</body>
</html>