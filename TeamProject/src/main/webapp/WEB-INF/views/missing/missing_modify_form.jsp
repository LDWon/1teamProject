<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" type="text/css" href="resources/css/footer.css"">
		<style>
			table {border-collapse: collapse;}
			th {background-color: #6799FF;}
			td {background-color: #D9E5FF}
		</style>
		<script>
			function cancel(f) {
				if (!confirm("수정을 취소하시겠습니까?")) {
					return;
				}
				
				f.method="post";
				f.action="missing_view.do";
				f.submit();
			}
			
			
			function missing_modify(f) {
				
				var subject = f.subject.value.trim();
				var name = f.name.value.trim();
				var content = f.content.value;
				
				if (!confirm("정말 수정하시겠습니까?")) {
					return;
				}
				
				if (subject == '') {
					alert('제목을 입력해주세요');
					return;
				}
				if (name == '') {
					alert('이름을 입력해주세요');
					return;
				}
				if (content == '') {
					alert('내용을 입력해주세요');
					return;
				}
				
				f.method="post";
				f.action="missing_modify.do";
				f.submit();
			}
		</script>
	</head>
	<body>
	<jsp:include page="../main/top.jsp" flush="false" />
		<h1 align="center">게시글 등록</h1>
		<form enctype="multipart/form-data">
			<table border="1" align="center" width="800" height="400">
			<input type="hidden" name="id" value="임시아이디">
			<input type="hidden" name="idx" value="${vo.idx}">
			<input type="hidden" name="page" value="${param.page}">
				<tr>
					<th>제목</th>
					<td colspan="3"><input name="subject" value="${vo.subject}"></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><input name="name" value="${vo.name}"></td>
					<th>지역</th>
					<td align="center">
						<select name="region" style="cursor:pointer">
							<option value="전체">전체</option>
							<option value="서울">서울</option>
							<option value="경기">경기</option>
							<option value="부산">부산</option>
							<option value="대전">대전</option>
							<option value="대구">대구</option>
							<option value="울산">울산</option>
							<option value="세종">세종</option>
							<option value="광주">광주</option>
							<option value="강원">강원</option>
							<option value="충북">충북</option>
							<option value="충남">충남</option>
							<option value="경북">경북</option>
							<option value="경남">경남</option>
							<option value="전북">전북</option>
							<option value="전남">전남</option>
							<option value="부산">부산</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3">
						<pre><textarea name="content" rows="15" cols="50" style="resize:none;">${vo.content}</textarea></pre>
						<c:if test="${vo.filename ne 'no_file'}">
						<img src="${pageContext.request.contextPath}/resources/upload/${vo.filename}"
						    width="200">
						</c:if>
					</td>
				</tr>
				<tr>
					<th>파일 첨부</th>
					<td colspan="3"><input type="file" name="photo" style="cursor:pointer"></td>
 				</tr>
				<tr>
					<td colspan="4" align="right">
						<input type="button" value="취소하기" style="cursor:pointer" onclick="cancel(this.form)">
						<input type="button" value="수정하기" style="cursor:pointer" onclick="missing_modify(this.form);">
					</td>
				</tr>
			</table>
		</form>
		<jsp:include page="../main/footer.jsp" flush="false" />
	</body>
</html>