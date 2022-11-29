<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>FIND</title>
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath }/resources/css/missing/missing_list.css">
		
		<script>
			function missing_search(f) {
				var region = f.region.value;
		
				f.method = "get";
				f.action = "missing_region_list.do";
				f.submit();
			}
		</script>
	</head>
	<body>
		<jsp:include page="../main/top.jsp" flush="false" />
		<div class="wrapper">
			<div class="wrap">
				<h1 align="center">실종자 게시판</h1>
				<div class="region_container">
					<form>
						<p align="center">
							<select name="region" id="region" style="cursor: pointer">
								<option value="전체">전체</option>
								<option value="서울">서울</option>
								<option value="경기">경기</option>
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
								<input type="button" value="검색"
								onclick="missing_search(this.form);">
							</select>
						</p>
					</form>
				</div>
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
							<td><a
								href="missing_view.do?idx=${vo.idx}&page=${param.page}"> <font
									color="black">${vo.subject}</font>
							</a></td>
							<c:set var="totalLength" value="${fn:length(vo.name) }" />
							<c:set var="first" value="${fn:substring(vo.name, 0, 1) }" />
							<c:set var="last"
								value="${fn:substring(vo.name, 2, totalLength) }" />
							<td align="center">${first}*${last}</td>
							<td align="center">${vo.region}</td>
							<td align="center">${fn:split(vo.regidate,' ')[0]}</td>
							<td align="center">${vo.readhit}</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="6" align="center" id="pageMenu">${pageMenu}</td>
					</tr>
					<c:if test="${member!=null }">
						<tr>
							<td colspan="6" align="right"><input type="button"
								value="등록하기" style="cursor: pointer"
								onclick="location.href='missing_insert_form.do?page=${param.page}'">
							</td>
						</tr>
					</c:if>
				</table>
			</div>
		</div>
		<jsp:include page="../main/footer.jsp" flush="false" />
	</body>
</html>