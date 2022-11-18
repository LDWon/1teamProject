<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style>
			a{text-decoration: none;}
		</style>
		<script>
			function missing_search() {
				var region = document.getElementById("region").value;
				alert(region);
				location.href="missing_list.do?page=" + ${param.page} + "&region=" + region;
			}
		</script>
	</head>
	<body>
		<h1 align="center">게시판</h1>
		<p align="center">
			<select name="region" id="region" style="cursor:pointer">
				<option value="전체">전체</option>
				<option value="서울">서울</option>
				<option value="경기">경기</option>
				<input type="button" value="검색" onclick="missing_search();">
			</select>
		</p>
		<table border="1" align="center">
			<tr>
				<th width="50">번호</th>
				<th width="300">제목</th>
				<th width="100">작성자</th>
				<th width="50">지역</th>
				<th width="100">등록일</th>
				<th width="50">조회수</th>
			</tr>
			<c:forEach var="vo" items="${list}">
				<tr>
					<td align="center">${vo.idx}</td>
					<td>
					<a href="missing_view.do?idx=${vo.idx}&page=${param.page}">
						<font color="black">${vo.subject}</font>
					</a>
					</td>
					<td align="center">${vo.name}</td>
					<td align="center">${vo.region}</td>
					<td align="center">${fn:split(vo.regidate,' ')[0]}</td>
					<td align="center">${vo.readhit}</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="6" align="center"> 
					${pageMenu}
				</td>
			</tr>
			<tr>
				<td colspan="6" align="right">
				<input type="button" value="등록하기" style="cursor:pointer" onclick="location.href='missing_insert_form.do?page=${param.page}'">
				</td>
			</tr>
		</table>
	</body>
</html>