<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		<script>
			/* ----------------------------------삭제---------------------------------- */
			function missing_del() {
				
				if ('${vo.id}' != '${param.id}') {
					alert('이 글의 작성자만 삭제할 수 있습니다.');
					return;
				}
				if (!confirm("삭제하시겠습니까?")){
					return;
				}
				
				var url = "missing_del.do";
				var param = "idx=${vo.idx}";
				
				sendRequest(url, param, missing_delCheck, "post");
				
			}
			
			function missing_delCheck() {
				if(xhr.readyState == 4 && xhr.status == 200) {
					var data = xhr.responseText;
					//"[{'param':'yes'}]"
					var json = eval(data);
					
					if (json[0].param == 'yes'){
						alert('삭제 성공');
						location.href="missing_list.do?page=${param.page}";
					} else {
						alert('삭제 실패');
					}
				}
			}
			/* ----------------------------------수정---------------------------------- */
			function missing_mod(f) {
				if ('${vo.id}' != '${param.id}') {
					alert('이 글의 작성자만 수정할 수 있습니다.');
					return;
				}
				if (!confirm("수정하시겠습니까?")){
					return;
				}
				
				f.method="get";
				f.action="missing_modify_form.do";
				f.submit();
			}
		</script>
	</head>
	<body>
		<form> <!-- 수정할 때 idx를 가져오기 위한 form태그 -->
			<table border="1" align="center">
				<input type="hidden" name="idx" value="${vo.idx}">
				<input type="hidden" name="page" value="${param.page}">
				<tr>
					<td colspan="6">${vo.subject}</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${vo.name}</td>
					
					<th>아이디(확인용)</th>
					<td>${vo.id}</td>
					
					<th>ip</th>
					<td>${vo.ip}</td>
				</tr>
				<tr>
					<th>지역</th>
					<td>${vo.region}</td>
					
					<th>등록일</th>
					<td>${vo.regidate}</td>
					
					<th>조회수</th>
					<td>${vo.readhit}</td>
				</tr>
				<tr>
					<td colspan="6"><pre>${vo.content}</pre>
					<c:if test="${vo.filename ne 'no_file'}">
						<img src="${pageContext.request.contextPath}/resources/upload/${vo.filename}"
						    width="200">
					</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="6" align="right">
						<input type="button" value="삭제하기" style="cursor:pointer" onclick="missing_del();">
						<input type="button" value="수정하기" style="cursor:pointer" onclick="missing_mod(this.form);">
						<input type="button" value="목록으로" style="cursor:pointer" onclick="location.href='missing_list.do?page=${param.page}'">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>