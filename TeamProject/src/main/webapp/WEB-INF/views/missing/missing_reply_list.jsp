<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" type="text/css" href="resources/css/footer.css"">
		<style>
			table {border-collapse: collapse;
			margin-bottom: 120px;}
			th {background-color: #6799FF;}
			td {background-color: #D9E5FF}
		</style>
		
	</head>
	<body>
	<jsp:include page="../main/top.jsp" flush="false" />
		<h1 align="center">'${param.subject}'의 댓글</h1>
		<table border="1" align="center" width="800">
				<tr>
					<th width="100">작성자</th>
					<th width="520">내용</th>
					<th>작성날짜</th>
				</tr>
				<c:forEach var="vo" items="${list}">
					<c:if test="${param.idx eq vo.ref}">
					<tr>
						<c:set var="totalLength" value="${fn:length(vo.name) }" />
						<c:set var="first" value="${fn:substring(vo.name, 0, 1) }" />
						<c:set var="last" value="${fn:substring(vo.name, 2, totalLength) }" />
						<td align="center">${first}*${last}</td>
						<td>${vo.content}</td>
						<td align="center">${vo.regidate}</td>
					</tr>
					</c:if>
				</c:forEach>
				<tr>
					<td colspan="3" align="right">
						<input type="button" value="본문보기" onclick="location.href='missing_view.do?idx=${param.idx}&page=${param.page}'">
						<input type="button" value="목록보기" onclick="location.href='missing_list.do?page=${param.page}'">
					</td>
				</tr>
			</table>
		<jsp:include page="../main/footer.jsp" flush="false" />
	</body>
</html>