<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
	<header> <!--  헤드영역    -->
		<jsp:include page="/WEB-INF/views/main/top.jsp" flush="false" /><!-- main폴더의 top.jsp를 끌고온다.  -->
	</header>
		
		<table border="1" align="center">
			<tr>
				<th width="50">번호</th>
				<th width="300">제목</th>
				<th width="100">작성자</th>
				<th width="100">등록일</th>
			</tr>
			
			<c:forEach var="notice" items="${n_list}"> <!-- var = notice로 선언과  noticeDAO에  n_list를 불러온다 -->
				<tr>
					<td align="center">${notice.idx}</td><!-- 선언명 . n_list에 idx 가져오기  -->
					<td>
					<a href="notice_view.do?idx=${notice.idx}&page=${param.page}">
						<font color="black">${notice.subject}</font>
					</a>
					</td>
					<td align="center">${notice.name}</td>
					<td align="center">${fn:split(notice.regidate,' ')[0]}</td>
				</tr>
			</c:forEach>
			<!-- 하단 페이지 처리  메뉴버튼   -->
			<tr>
				<td colspan="6" align="center"> 
					${pageMenu}
				</td>
			</tr>
	<tr>
	  <c:if test="${member.id eq 1234}">
		  <td>
		  <input type='button' value='등록하기 '  onclick="location.href='notice_insert_form.do?page=${param.page}'"/>
		  </td>
	 </c:if>
	 <c:if test="${member.id ne admin }">
		  <td>
		  <input style="display:none" type='button'  value='등록하기 'onclick="location.href='notice_insert_form.do?page=${param.page}'"/>
		  </td>
	 </c:if>
	</tr>
		</table>
		
	<!-- 푸터 영역   -->
	<footer>
		<jsp:include page="/WEB-INF/views/main/footer.jsp" flush="false" /><!-- main폴더의 footer.jsp를 끌고온다. -->
	</footer>
	</body>
</html>