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
* {
	margin: 0;
	padding: 0;
}
	.member_list_wrapper {
		width: 100%;
	}
	/* content 랩 */
	.member_list_wrap {
		width: 1080px;
		margin: auto;
	}
	
	.member_list_wrap h1 {
		margin-top: 50px;
	}
	
	.member_list_wrap td {
		text-align: center;
	}
	.member_list_search_container{margin-top: 50px;}
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
	margin-bottom : 15px;
}

.admin_top_wrap>span {
	margin-left: 30px;
	display: inline-block;
	color: white;
	font-size: 50px;
	font-weight: bolder;
}
</style>
<script type="text/javascript">
	function member_list_search(f) {
		/* var search_type = f.search_type.value; */
		f.method="get";
		f.action="member_list_searching";
		f.submit();
	}
</script>
</head>
<body>
	<div class="member_list_wrapper">
		<div class="member_list_wrap">
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
			<h1>회원 목록</h1>
			<!-- 회원 정보 검색// -->
			<div align="center" class="member_list_search_container">
				<form action="">
					<select name="search_type">
						<option value="전체">전체</option>
						<option value="아이디">아이디</option>
						<option value="이름">이름</option>
					</select>
					<input type="text" name="search_word"> 
					<button onclick="member_list_search(this.form)">검색</button>
				</form>
			</div>
			<!-- //회원 정보 검색 -->
			<table style="margin-top: 20px;" border="1" align="center">
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>생년월일</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>우편번호</th>
					<th>상세주소</th>
					<th>이메일 인증여부</th>
				</tr>
				<c:if test="${member_list==null }">
					<caption>:::검색결과 없음:::</caption>
				</c:if>
				<c:if test="${member_list!=null }">
					<c:forEach var="vo" items="${member_list }">
						<c:if test="${vo.adminCk==0 }">
							<tr>
								<td>${vo.id }</td>
								<td>${vo.name }</td>
								<td>${vo.birth }</td>
								<td>${vo.email }</td>
								<td>${vo.tel }</td>
								<td>${vo.memberAddr1 }</td>
								<td>${vo.memberAddr2 } ${vo.memberAddr3}</td>
								<c:if test="${vo.mail_auth==1 }">
									<td>O</td>
								</c:if>
								<c:if test="${vo.mail_auth==0 }">
									<td>X</td>
								</c:if>
							</tr>
						</c:if>
					</c:forEach>
				</c:if>
			</table>
		</div>
	</div>
</body>
</html>