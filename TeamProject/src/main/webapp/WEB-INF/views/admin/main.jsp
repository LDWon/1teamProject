<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/admin/main.css">
<!-- jquery 적용 -->
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
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
			<!-- contents-area -->
			<div class="admin_wrap">
				<!-- 네비영역 -->
				<div class="admin_navi_wrap">
					<ul>
						<li><a onclick="location.href='member_list_search'" class="admin_list_01">회원 목록 조회</a></li>
						<li><a onclick="location.href='notice_insert_form.do'" class="admin_list_02">공지사항 등록</a></li>
					</ul>
					<!-- 
                    <div class="admin_list_01">
                        <a>상품 관리</a>
                    </div>
                     -->
				</div>
				<div class="admin_content_wrap">
					<div>관리자 페이지 입니다.</div>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
</body>
</html>