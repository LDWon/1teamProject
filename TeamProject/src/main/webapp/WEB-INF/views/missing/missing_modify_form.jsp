<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath }/resources/css/missing/missing_insert_modify.css">
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
				var region = f.region.value;
				
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
				if (region == '선택') {
					alert('지역을 선택해주세요');
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
		<div class="wrapper">
			<div class="wrap">
				<h1 align="center">수정하기</h1>
					<form enctype="multipart/form-data">
						<table border="1" align="center">
						<input type="hidden" name="id" value="${member.id}">
						<input type="hidden" name="idx" value="${vo.idx}">
						<input type="hidden" name="page" value="${param.page}">
							<tr>
								<th>제목</th>
								<td colspan="3"><input name="subject" value="${vo.subject}" style="border: 0;background-color: #e3f2fd; width: 75%; height: 100%;" placeholder="제목을 입력해주세요."></td>
							</tr>
							<tr>
								<th>작성자</th>
								<td><input name="name" style="border: 0;background-color: #e3f2fd" value="${member.name}" readonly="readonly"></td>
								<th>지역</th>
								<td align="center">
									<select name="region" style="cursor:pointer">
										<option value="선택">선택</option>
										<option value="서울">서울</option>
										<option value="경기">경기</option>
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
								<div id="content">
									<pre><textarea name="content" rows="25" cols="136" style="resize:none; border: 0; background-color: #e3f2fd; padding: 10px;">${vo.content}</textarea></pre>
									<c:if test="${vo.filename ne 'no_file'}">
									<img src="${pageContext.request.contextPath}/resources/upload/${vo.filename}"
									    width="200">
									</c:if>
								</div>
								</td>
							</tr>
							<tr>
								<th>파일 첨부</th>
								<td colspan="3"><input type="file" name="photo" style="cursor:pointer"></td>
			 				</tr>
							<tr>
								<td colspan="4" align="right" id="menu">
									<input type="button" value="취소하기" style="cursor:pointer" onclick="cancel(this.form)">
									<input type="button" value="수정하기" style="cursor:pointer" onclick="missing_modify(this.form);">
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		<jsp:include page="../main/footer.jsp" flush="false" />
	</body>
</html>