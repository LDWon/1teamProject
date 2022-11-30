<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>FIND</title>
	<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath }/resources/css/missing/missing_insert_modify.css">
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
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}
/* 홈페이지 기능 네비 */
.top_gnb_area {
	width: 100%;
	height: 50px;
	background-color: #f0f0f1;
	position: relative;
}

.top_gnb_area .list {
	position: absolute;
	top: 0px;
	right: 0;
}

.top_gnb_area .list li {
	list-style: none;
	float: left;
	padding: 13px 15px 0 10px;
	font-weight: 900;
	cursor: pointer;
}
/* 관리제 페이지 상단 현페이지 정보 */
.admin_top_wrap {
	height: 110px;
	line-height: 110px;
	background-color: #5080bd;
	margin-bottom: 15px;
}

.admin_top_wrap>span {
	margin-left: 30px;
	display: inline-block;
	color: white;
	font-size: 50px;
	font-weight: bolder;
}
</style>
</head>
	<body>
		<div class="wrapper">
			<div class="wrap">
				<!-- gnv_area -->
				<div class="top_gnb_area">
					<ul class="list">
						<li><a href="/missing/main.do">메인 페이지</a></li>
						<li><a href="/missing/logout">로그아웃</a></li>
					</ul>
				</div>
				<!-- top_subject_area -->
				<div class="admin_top_wrap">
					<span>관리자 페이지</span>
				</div>
				<h1 align="center">공지사항 등록</h1>
				<form enctype="multipart/form-data">
					<table border="1" align="center">
					<input type="hidden" name="id" value="${member.id}">
						<tr>
							<th>제목</th>
							<td><input name="subject" style="border: 0;background-color: #e3f2fd; width: 75%; height: 100%;" placeholder="제목을 입력해주세요."></td>
						</tr>
						<tr>
							<th>작성자</th>
							<td><input name="name" style="border: 0;background-color: #e3f2fd" value="관리자(id : ${member.id})" readonly="readonly"></td>
						</tr>
						<tr>
							<th>내용</th>
							<td colspan="3">
								<pre><textarea name="content" rows="25" cols="136" style="resize:none; border: 0;background-color: #e3f2fd; padding: 10px;"></textarea></pre>
							</td>
						</tr>
						<tr>
							<th>파일 첨부</th>
							<td><input type="file" name="photo" style="cursor:pointer"></td>
		 				</tr>
						<tr>
							<td colspan="4" align="right" id="menu">
								<input type="button" value="목록으로" style="cursor:pointer" onclick="location.href='../notice_list.do?page=${param.page}'">
								<input type="button" value="등록하기" style="cursor:pointer" onclick="notice_insert(this.form);">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</body>
</html>