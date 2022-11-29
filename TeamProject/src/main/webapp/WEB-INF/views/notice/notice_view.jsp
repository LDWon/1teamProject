<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath }/resources/css/missing/missing_view.css">
	</head>
	<body>
	<jsp:include page="../main/top.jsp" flush="false" />
		<div class="wrapper">
			<div class="wrap">
			<h1 align="center">공지사항</h1>
				<form> <!-- 수정할 때 idx를 가져오기 위한 form태그 -->
					<table border="1" align="center">
						<input type="hidden" name="idx" value="${vo.idx}">
						<input type="hidden" name="page" value="${param.page}">
						<tr>
							<td colspan="8" align="center" id="subject"><b>${vo.subject}</b></td>
						</tr>
						<tr>
							<th width="100">작성자</th>
							<td align="center">${vo.name}</td>
							
							<th width="100">등록일</th>
							<td align="center" colspan="3">${vo.regidate}</td>
							
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
							<td colspan="8"><div id="content"><pre>${vo.content}</pre>
							<c:if test="${vo.filename ne 'no_file'}">
								<img src="${pageContext.request.contextPath}/resources/upload/${vo.filename}"
								    width="200">
							</c:if>
							</div>
							</td>
						</tr>
						<tr>
							<td colspan="8" align="right" id="view_menu">
								<input type="button" value="공지사항 목록으로" style="cursor:pointer" onclick="location.href='notice_list.do?page=${param.page}'">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	<jsp:include page="../main/footer.jsp" flush="false" />
	</body>
</html>