<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/m_user/login_form.css">
<script
	src="${pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
<script type="text/javascript">
	//로그인
	function login(f) {
		var id = f.id.value.trim();
		var pwd = f.pwd.value.trim();
		//유효성 검사
		if (id == "") {
			alert("아이디를 입력해주세요");
			f.id.focus();
		} else if (pwd == "") {
			alert("비밀번호를 입력해주세요");
			f.pwd.focus();
		}

		//로그인 정보 확인 ajax
		var url = "login";
		var param = "id=" + id + "&pwd=" + pwd;

		sendRequest(url, param, loginCheck, "post");
	}
	//로그인 콜벡함수
	function loginCheck() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			var data = xhr.responseText;
			var json = eval(data);

			if (json[0].param == 'Y') {
				alert("로그인 되셨습니다!");
				location.href = "main.do";
			} else if (json[0].param == 'noEmail') {
				alert("이메일 인증이 완료되지 않았습니다!\n먼저 이메일 인증을 완료해주세요!");
			} else if (json[0].param == 'noPwd') {
				alert("비밀번호를 잘못 입력하셨습니다!");
			} else if (json[0].param == 'noId') {
				alert("아이디를 잘못 입력하셨습니다!");
			} else if (json[0].param == 'error') {
				alert("회원정보가 없습니다!");
			}
		}
	}
</script>
</head>
<body>
	<div class="wrapper">
		<div class="wrap">
			<form action="">
				<!-- 메인상표 -->
				<!-- <h1>FIND</h1> -->
				<div class="main_logo">
					<!-- <h1>FIND</h1> -->
					<img src="resources/img/logo_find.png">
				</div>
				<!-- 아이디 입력창 -->
				<div class="input_container">
					<input type="text" placeholder="아이디를 입력해주세요" name="id">
				</div>
				<!-- 비밀번호 입력창 -->
				<div class="input_container">
					<input type="password" placeholder="비밀번호를 입력해주세요" name="pwd">
				</div>
				<!-- 로그인 버튼 -->
				<div class="login_button_container">
					<input class="login_button" type="button" value="로그인" onclick="login(this.form)">
				</div>
				<!-- 비밀번호 찾기,아이디 찾기,회원가입 -->
				<div class="sign_up_container">
					<a href="member_agreement.do">회원가입</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>