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
			table {border-collapse: collapse;}
			th {background-color: #6799FF;}
			td {background-color: #D9E5FF;}
			#subject {background-color: #6799FF;}
		</style>
	</head>
	<body>
	<jsp:include page="../main/top.jsp" flush="false" />
		<form> <!-- 수정할 때 idx를 가져오기 위한 form태그 -->
			<table border="1" align="center" width="800" height="400">
				<input type="hidden" name="idx" value="${vo.idx}">
				<input type="hidden" name="page" value="${param.page}">
				<tr>
					<td colspan="6" align="center" height="50" id="subject"><b>${vo.subject}</b></td>
				</tr>
				<tr>
					<th width="100">작성자</th>
					<c:set var="totalLength" value="${fn:length(vo.name) }" />
					<c:set var="first" value="${fn:substring(vo.name, 0, 1) }" />
					<c:set var="last" value="${fn:substring(vo.name, 2, totalLength) }" />
					<td align="center">${first}*${last}</td>
					
					<th width="100">등록일</th>
					<td align="center" colspan="3">${vo.regidate}</td>
					
				</tr>
				<tr>
					<th width="100">지역</th>
					<td align="center">${vo.region}</td>
					
					
					<th width="100">조회수</th>
					<td align="center">${vo.readhit}</td>
					
					<th width="150">이미지파일 여부</th>
					<td align="center">
					<c:if test="${vo.filename eq 'no_file'}">
						X
					</c:if>
					<c:if test="${vo.filename ne 'no_file'}">
						O
					</c:if>
				</tr>
				<tr>
					<td colspan="6"><pre>${vo.content}</pre>
					<c:if test="${vo.filename ne 'no_file'}">
						<img src="${pageContext.request.contextPath}/resources/upload/${vo.filename}"
						    width="200">
					</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="6" align="right">
						<input type="button" value="종결 게시판 목록으로" style="cursor:pointer" onclick="location.href='missing_find_list.do?page=${param.page}'">
					</td>
				</tr>
			</table>
		</form>
	<jsp:include page="../main/footer.jsp" flush="false" />
	</body>
</html>