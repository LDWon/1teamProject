<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/shopping_main.css">
<!-- jquery 사용 -->
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
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
						<li><a class="logout_button">로그아웃</a></li>
						<li>마이룸</li>
						<li>장바구니</li>
					</c:if>
					<li>고객센터</li>
				</ul>
			</div>
			<div class="top_area">
				<div class="logo_area">
					<a href="/missing/main.do">
						<img src="resources/img/logo_find.png">
					</a>
				</div>
				<div class="search_area">
					<h1>Search area</h1>
				</div>
				<div class="login_area">
					<!-- 로그인 하기전에 띄울 창 -->
					<c:if test="${member==null }">
						<div class="login_button">
							<a href="/missing/loginForm">로그인</a>
						</div>
						<span>
							<a href="/missing/member_agreement.do">회원가입</a>
						</span>
					</c:if>
					<!-- 로그인한 상태 -->
					<c:if test="${ member != null }">
						<div class="login_success_area">
							<span>회원이름 : ${member.name}</span> 
							<a class="logout_button" href="/missing/logout.do">로그아웃</a>
						</div>
					</c:if>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="navi_bar_area">
				<h1>navi area</h1>
			</div>
			<div class="content_area">
				<h1>content area</h1>
			</div>
		</div>
	</div>
	
	<script>
 
	    /* 로그아웃 버튼 작동 */
	    /* 비동기식 */
	    $(".logout_button").click(function(){
	    	//alert("버튼 작동");
	        $.ajax({
	            type:"GET",
	            url:"/missing/logout.do",
	            success:function(data){
	                alert("로그아웃 되셨습니다.");
	                document.location.reload();     
	            } 
	        }); // ajax 
	    });
	    
	</script>
</body>
</html>