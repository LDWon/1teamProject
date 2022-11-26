<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>top</title>
<link rel="stylesheet" type="text/css" href="resources/css/top.css">
</head>
<body>
	<header>
		<img src="resources/img/sos.jpg" width="80" height="80" onclick="location.href='main.do'">
			<div>
				<h1 align="center">실종 게시판</h1>
				<!-- 로그인 하지 않은 상태 -->
				<c:if test="${member==null }">
					<button type="button" class="userLink" onclick="location.href='loginForm'">Login</button>
			       	<button type="button" class="userLink" onclick="location.href='member_agreement.do'">Sign-up</button>
				</c:if>
				<!-- 로그인 한 상태 -->
				<c:if test="${member!=null }">
					<div class="login_success_area">
						<span>회원이름 : ${member.name}</span>
						<!-- 로그아웃 버튼 -->
						<a href="/missing/logout">로그아웃</a>
					</div>
				</c:if>
		     </div>
			  	<nav id="topMenu" >
		         	<ul>
		               <li><a class="menuLink" onclick = "location.href='about.do'">About us</a></li>
		               <li><a class="menuLink" onclick ="location.href='notice_list.do'">공지사항</a></li>
		               <li><a class="menuLink" onclick ="location.href='missing_list.do'">실종자 게시판</a></li>
		               <li><a class="menuLink" href="#">종결 게시판</a></li>
		               <li><a class="menuLink" href="#">장기처리 게시판</a></li>
		           </ul>
		        </nav>
	 </header>
</body>
</html>