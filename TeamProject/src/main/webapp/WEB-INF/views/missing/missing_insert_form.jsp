<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			function missing_insert(f) {
				var subject = f.subject.value.trim();
				var name = f.name.value.trim();
				var content = f.content.value;
				var region = f.region.value;
				
				if (subject == '') {
					alert('제목을 입력해주세요');
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
				f.action="missing_insert.do";
				f.submit();
			}
		</script>
	</head>
	<body>
	<jsp:include page="../main/top.jsp" flush="false" />
		<h1 align="center">게시글 등록</h1>
		<form enctype="multipart/form-data">
			<table border="1" align="center"  width ="800"; height="400";>
			<input type="hidden" name="id" value="임시아이디">
				<tr>
					<th>제목</th>
					<td colspan="3"><input name="subject"></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>
						<input name="name" value="${member.name}" readonly="readonly">
					</td>
					<th>지역</th>
					<td align="center">
						<select name="region" style="cursor:pointer">
							<option value="선택">선택</option>
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
							<option value="제주">제주</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3">
						<pre><textarea name="content" rows="15" cols="100" style="resize:none;">※실종자 등록 양식※&#10;상세지역: &#10;성별: &#10;이름: &#10;나이: &#10;키: &#10;몸무게: &#10;&#10;&#10;→이 부분은 지우고 자유롭게 적어주세요←&#10;&#10;&#10;&#10;&#10;※첨부파일은 1개만 등록 가능합니다.※</textarea></pre>
					</td>
				</tr>
				<tr>
					<th>파일 첨부</th>
					<td colspan="3"><input type="file" name="photo" style="cursor:pointer"></td>
 				</tr>
				<tr>
					<td colspan="4" align="right">
						<input type="button" value="뒤로가기" style="cursor:pointer" onclick="location.href='missing_list.do?page=${param.page}'">
						<input type="button" value="등록하기" style="cursor:pointer" onclick="missing_insert(this.form);">
					</td>
				</tr>
			</table>
		</form>
		<jsp:include page="../main/footer.jsp" flush="false" />
	</body>
</html>