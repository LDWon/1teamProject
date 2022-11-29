<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/missing/missing_list.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.member_list_wrapper {
	width: 100%;
}
/* content 랩 */
.member_list_wrap {
	width: 1080px;
	margin: auto;
}
</style>
</head>
<body>
	<div class="member_list_wrapper">
		<div class="member_list_wrap">
		<h1>회원 목록</h1>
			<table style="margin-top: 100px;" border="1" align="center">
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>생년월일</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>이메일 인증여부</th>
					<th>우편주소</th>
				</tr>
				<c:forEach var="vo" items="${member_list }">
					<c:if test="${vo.adminCk==0 }">
						<tr>
							<td>${vo.id }</td>
							<td>${vo.name }</td>
							<td>${vo.birth }</td>
							<td>${vo.email }</td>
							<td>${vo.tel }</td>
							<c:if test="${vo.mail_auth==1 }">
								<td>O</td>
							</c:if>
							<c:if test="${vo.mail_auth==0 }">
								<td>X</td>
							</c:if>
							<td>${vo.memberAddr1 }</td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>