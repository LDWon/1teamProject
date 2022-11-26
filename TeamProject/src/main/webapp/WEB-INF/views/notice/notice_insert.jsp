<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<script>
			function notice_insert(f) {
				var subject = f.subject.value.trim();
				var name = f.name.value.trim();
				var content = f.content.value;
				
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
				f.action="notice_insert.do";
				f.submit();
			}
		</script>
	</head>
	<body>
		<h1 align="center">공지사항 등록</h1>
		<form enctype="multipart/form-data">
			<table border="1" align="center">
			<input type="hidden" name="id" value="임시아이디">
				<tr>
					<th>제목</th>
					<td><input name="subject"></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><input name="name" value="임시이름"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3">
						<pre><textarea name="content" rows="15" cols="50" style="resize:none;"></textarea></pre>
					</td>
				</tr>
				<tr>
					<th>파일 첨부</th>
					<td><input type="file" name="photo" style="cursor:pointer"></td>
 				</tr>
				<tr>
					<td colspan="4" align="right">
						<input type="button" value="뒤로가기" style="cursor:pointer" onclick="location.href='notice_list.do?page=${param.page}'">
						<input type="button" value="등록하기" style="cursor:pointer" onclick="notice_insert(this.form);">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>