<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" type="text/css" href="resources/css/missing_list.css">
		<style>
			a{text-decoration: none;}
		</style>
		<script>
			function cat1_change(){
				var si = ;
				var do = ;
			}
		</script>
	</head>
	<body>
	
		<!-- 헤더  -->
	 <jsp:include page="/WEB-INF/views/main/top.jsp" flush="false" />
		<h1 align="center">게시판</h1>
		<select  name="h_area1" onChange="cat1_change(this.value,h_area2)" >
            <option selected>-지역-</option>
            <option value='1'>서울</option>
            <option value='2'>부산</option>
            <option value='3'>대구</option>
            <option value='4'>인천</option>
            <option value='5'>광주</option>
            <option value='6'>대전</option>
            <option value='7'>울산</option>
            <option value='8'>강원</option>
            <option value='9'>경기</option>
            <option value='10'>경남</option>
            <option value='11'>경북</option>
            <option value='12' >전남</option>
            <option value='13'>전북</option>
            <option value='14'>제주</option>
            <option value='15'>충남</option>
            <option value='16'>충북</option>
        </select>
        <select name="h_area2">
            <option align="center"selected>-선택-</option>
            <option value='193' >광양시</option>
            <option value='194'>나주시</option>
            <option value='195'>목포시</option>
            <option value='196'>순천시</option>
            <option value='197'>여수시</option>
            <option value='198'>강진군</option>
            <option value='199'>고흥군</option>
            <option value='200'>곡성군</option>
            <option value='201'>구례군</option>
            <option value='202'>담양군</option>
            <option value='203'>무안군</option>
            <option value='204'>보성군</option>
            <option value='205'>신안군</option>
            <option value='206'>영광군</option>
            <option value='207'>영암군</option>
            <option value='208'>완도군</option>
            <option value='209'>장성군</option>
            <option value='210'>장흥군</option>
            <option value='211'>진도군</option>
            <option value='212'>함평군</option>
            <option value='213'>해남군</option>
            <option value='214'>화순군</option>
        </select>
		<table border="1" align="center">
			<tr>
				<th width="50">번호</th>
				<th width="300">제목</th>
				<th width="100">작성자</th>
				<th width="50">지역</th>
				<th width="100">등록일</th>
				<th>조회수</th>
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
				<input type="button" value="등록하기" style="cursor:pointer" onclick="location.href='missing_insert_form.do'">
				</td>
			</tr>
		</table>
		<!-- 푸터 -->
		<jsp:include page="/WEB-INF/views/main/footer.jsp" flush="false" />
	</body>
</html>