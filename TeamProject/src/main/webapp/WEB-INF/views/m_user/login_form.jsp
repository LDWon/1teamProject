<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
<script type="text/javascript">
	//로그인
	function login(f) {
		var id = f.id.value.trim();
		var pwd = f.pwd.value.trim();
		//유효성 검사
		if (id=="") {
			alert("아이디를 입력해주세요");
			f.id.focus();
		}else if (pwd=="") {
			alert("비밀번호를 입력해주세요");
			f.pwd.focus();
		}
		
		//로그인 정보 확인 ajax
		var url= "login";
		var param="id="+id+"&pwd="+pwd;
		
		sendRequest(url,param,loginCheck,"post");
	}
	//로그인 콜벡함수
	function loginCheck() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			var data = xhr.responseText;
			var json = eval(data);
			
			if(json[0].param == 'Y'){
				alert("로그인 되셨습니다!");
				location.href="main.do";
			} else if (json[0].param == 'noEmail') {
				alert("이메일 인증이 완료되지 않았습니다!\n먼저 이메일 인증을 완료해주세요!");
			}else if (json[0].param == 'noPwd') {
				alert("비밀번호를 잘못 입력하셨습니다!");
			}else if (json[0].param == 'noId') {
				alert("아이디를 잘못 입력하셨습니다!");
			}else if (json[0].param == 'error') {
				alert("회원정보가 없습니다!");
			}
		}
	}
</script>
</head>
<body>
	<form action="">
		<!-- 메인상표 -->
		<h1>FIND</h1>
		<!-- 아이디 입력창 -->
		<div>
			<input type="text" placeholder="아이디를 입력해주세요" name="id">
		</div>
		<!-- 비밀번호 입력창 -->
		<div>
			<input type="password" placeholder="비밀번호를 입력해주세요" name="pwd">
		</div>
		<!-- 로그인 버튼 -->
		<div>
			<input type="button" value="로그인" onclick="login(this.form)">
		</div>
		<!-- 비밀번호 찾기,아이디 찾기,회원가입 -->
		<div>
			<a>비밀번호 찾기</a>
			<a>아이디 찾기</a>
			<a href="join_form.do">회원가입</a>
		</div>
	</form>
</body>
</html>