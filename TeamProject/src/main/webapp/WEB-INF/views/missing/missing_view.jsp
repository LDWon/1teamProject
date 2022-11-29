<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath }/resources/css/missing/missing_view.css">
		<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		<script>
			/* ----------------------------------삭제---------------------------------- */
			function missing_del() {
				
				if ('${member.id}'!='${vo.id}') {
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
				/* if ('${vo.id}' != '${param.id}') {
					alert('이 글의 작성자만 수정할 수 있습니다.');
					return;
				} */
				if ('${member.id}'!='${vo.id}') {
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
			/* ----------------------------------댓글---------------------------------- */
			function reply(f) {
				
				var content = f.content.value;
				if (${member == null}) {
					alert("로그인 후 이용 가능합니다.");
					return;
				}
				if (!confirm("등록하시겠습니까?")){
					return;
				}
				if (content == '') {
					alert("내용을 입력해주세요.");
					return;
				}
				
				f.action="missing_reply.do";
				f.method="get";
				f.submit();
				
			}
			
			
			/* ---------------------------종결게시판으로 등록하기-------------------- */
			
			function missing_find(f) {
				if ('${member.id}'!='${vo.id}') {
					alert('이 글의 작성자만 이용할 수 있습니다.');
					return;
				}
				if (!confirm("이 글은 종결 게시판으로 이동합니다.\r\n계속하시겠습니까?")){
					return;
				}
				var url = "missing_find.do";
				var param = "idx=${vo.idx}";
				
				sendRequest(url, param, missing_findCheck, "post");
			}
			
			function missing_findCheck() {
				if(xhr.readyState == 4 && xhr.status == 200) {
					var data = xhr.responseText;
					//"[{'param':'yes'}]"
					var json = eval(data);
					
					if (json[0].param == 'yes'){
						alert('해결 완료!\r\n종결 게시판 목록으로 이동합니다.');
						location.href="missing_find_list.do?page=${param.page}";
					} else {
						alert('실패');
					}
				}
			}
			
		</script>
	</head>
	<body>
	<jsp:include page="../main/top.jsp" flush="false" />
		<div class="wrapper">
			<div class="wrap">
				<h1 align="center">실종자 정보</h1>
				<form> <!-- 수정할 때 idx를 가져오기 위한 form태그 -->
					<table border="1" align="center">
						<input type="hidden" name="idx" value="${vo.idx}">
						<input type="hidden" name="page" value="${param.page}">
						<input type="hidden" name="name" value="${member.name}">
						<input type="hidden" name="id" value="${member.id}">
						<tr>
							<td colspan="6" align="center" id="subject"><b>${vo.subject}</b></td>
						</tr>
						<tr>
							<th width="100">작성자</th>
							<c:set var="totalLength" value="${fn:length(vo.name) }" />
							<c:set var="first" value="${fn:substring(vo.name, 0, 1) }" />
							<c:set var="last" value="${fn:substring(vo.name, 2, totalLength) }" />
							<td align="center">${first}*${last}</td>
							<th width="100">등록일</th>
							<td align="center" colspan="3">${vo.regidate}</td>
							
						</tr>
						<tr>
							<th width="100">지역</th>
							<td align="center">${vo.region}</td>
							
							
							<th width="100">조회수</th>
							<td align="center">${vo.readhit}</td>
							
							<th width="150">이미지파일 여부</th>
							<td align="center">
							<c:if test="${vo.filename eq 'no_file'}">
								X
							</c:if>
							<c:if test="${vo.filename ne 'no_file'}">
								O
							</c:if>
						</tr>
						<tr>
							<td colspan="6"><div id="content"><pre>${vo.content}</pre>
							<c:if test="${vo.filename ne 'no_file'}">
								<img src="${pageContext.request.contextPath}/resources/upload/${vo.filename}"
								    width="200">
							</c:if>
							</div>
							</td>
						</tr>
						<tr>
							<td colspan="6" align="right" id="view_menu">
								<input type="button" value="해결완료" style="cursor:pointer" onclick="missing_find();">
								<input type="button" value="댓글보기" style="cursor:pointer" onclick="location.href='missing_reply_list.do?idx=${vo.idx}&page=${param.page}&subject=${vo.subject}'">
								<input type="button" value="삭제하기" style="cursor:pointer" onclick="missing_del();">
								<input type="button" value="수정하기" style="cursor:pointer" onclick="missing_mod(this.form);">
								<input type="button" value="목록으로" style="cursor:pointer" onclick="location.href='missing_list.do?page=${param.page}'">
							</td>
						</tr>
					</table>
					<br>
					<div align="center" id="reply">
						<pre><textarea name="content" rows="4" cols="100" style="resize:none;" placeholder="댓글을 입력하세요."></textarea></pre>
						<input type="button" value="등록" onclick="reply(this.form);">
			       	</div>
				</form>
			</div>
		</div>
	<jsp:include page="../main/footer.jsp" flush="false" />
	</body>
</html>