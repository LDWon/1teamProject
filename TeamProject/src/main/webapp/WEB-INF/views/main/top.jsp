<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>top</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/top.css">
</head>
<body>
	<div class="wrapper">
		<div class="wrap">
			<div class="top_gnb_area">
				<ul class="list">
					<c:if test="${member==null }">
						<li><a href="/missing/loginForm">로그인</a></li>
						<li><a href="/missing/member_agreement.do">회원가입</a></li>
					</c:if>
					<c:if test="${member != null }">
						<!-- 관리자권한을 갖고 있을 때만 표시 -->
						<c:if test="${member.adminCk == 1 }">
							<li><a href="/missing/admin/main">관리자 페이지</a></li>
						</c:if>
						<li><a onclick="location.href='logout'" class="logout_button">로그아웃</a></li>
					</c:if>
				</ul>
			</div>

			<div class="top_menu">

				<ul>
					<li><a onclick="location.href='about.do'">About us</a></li>
					<li><a onclick="location.href='notice_list.do'">공지사항</a></li>
					<li><a onclick="location.href='missing_list.do'">실종자 게시판</a></li>
					<li><a class="menuLink"
						onclick="location.href='missing_find_list.do'">종결 게시판</a></li>
					<li><a class="menuLink"
						onclick="location.href='missing_long_term_list.do'">장기처리 게시판</a></li>
				</ul>

			</div>
			<!-- <nav id="topMenu">
				<ul>
					<li><a class="menuLink" onclick="location.href='about.do'">About
							us</a></li>
					<li><a class="menuLink"
						onclick="location.href='notice_list.do'">공지사항</a></li>
					<li><a class="menuLink"
						onclick="location.href='missing_list.do'">실종자 게시판</a></li>
					<li><a class="menuLink" href="#">종결 게시판</a></li>
					<li><a class="menuLink" href="#">장기처리 게시판</a></li>
				</ul>
			</nav> -->
		</div>
	</div>
</body>
</html>