<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#id_ok{
		color: #008000;
		display: none;
	}
	#id_already{
		color: #F55939;
		display: none;	
	}
</style>
<script src="${pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
<script type="text/javascript">
	//회원 등록
	function join(f) {
		var id = f.id.value;
		var pwd = f.pwd.value;
		var pwdChk = f.pwdChk.value;
		var name = f.name.value;
		var birth = f.birth.value;
		var email = f.email.value;
		var tel = f.tel.value;
		
		//유효성검사
		if (id=="") {
			alert("아이디를 입력해주세요.");
			f.id.focus();
		}else if (f.idDuplication.value=="idUncheck") {
			alert("아이디 중복체크를 해주세요.");
		}else if (pwd=="") {
			alert("비밀번호를 입력해주세요.");
			f.pwd.focus();
		}else if (pwdChk=="") {
			alert("다시 한번 비밀번호를 입력해주세요.");
			f.pwdChk.focus();
		}else if (name=="") {
			alert("이름을 입력해주세요.");
			f.name.focus();
		}else if (birth=="") {
			alert("생년월일을 입력해주세요.");
			f.birth.focus();
		}else if (email=="") {
			alert("이메일을 입력해주세요.");
			f.email.focus();
		}else if (tel=="") {
			alert("전화번호를 입력해주세요.");
			f.tel.focus();
		}
		
		//비밀번호 일치 확인
		if(pwd!=pwdChk){
			alert("비밀번호가 일치하지 않습니다.");
		}else if(pwd==pwdChk&&f.idDuplication.value=="idCheck") {
			alert("회원가입이 완료되었습니다.");
			f.action="join.do";
			f.submit();
		}
	}
	//아이디 중복확인
	function fn_dbCheckId(f) {
		var id = f.id.value;
		var url = "dbCheckId.do";
		var param = "id="+id;
		if (id.length==0||id=="") {
			alert("아이디를 입력해주세요.");
			f.id.focus();
		}else{
			sendRequest(url,param,dbChkId,"post");
		}
	}
	//아이디 중복확인 콜백메서드
	function dbChkId() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			var data = xhr.responseText;
			var json = eval(data);
			
			if(json[0].param == 'yes'){
				alert('사용할 수 있는 아이디 입니다.');
				document.joinForm.idDuplication.value="idCheck";
				document.getElementById('id_ok').style.display='block';
				document.getElementById('id_already').style.display='none';
			} else{
				alert('이미 존재하는 아이디 입니다.');
				document.getElementById('id_already').style.display='block';
				document.getElementById('id_ok').style.display='none';
			}
		}
	}
	//이메일 인증
	function emailAuth(f) {
		var id = f.id.value;
		var email =f.email.value;
		var url="emailAuth.do";
		var param="id="+id+"&email"+email;
	}
	
</script>
</head>
<body>
	<form name="joinForm" method="post" action="">
		<!-- 메인상표 -->
		<h1>FIND</h1>
		<!-- 아이디 입력 -->
		<div>
			<p>아이디</p>
			<input name="id" id="id" type="text" placeholder="아이디를 입력해주세요">
			<!-- 아이디 중복확인 -->
			<button type="button" onclick="fn_dbCheckId(this.form)" name="dbCheckId" class="checkId">
				중복확인
			</button>
			<!-- 아이디 중복확인 체크여부 -->
			<input type="hidden" name="idDuplication" value="idUncheck">
			<span id="id_ok">사용 가능한 아이디입니다.</span>
			<span id="id_already">이미 존재하는 아이디 입니다.</span>
		</div>
		<!-- 비밀번호 입력 -->
		<div>
			<p>비밀번호</p>
			<input name="pwd" type="password" placeholder="비밀번호를 입력해주세요">
		</div>
		<div>
			<p>비밀번호 재확인</p>
			<input name="pwdChk" type="password" placeholder="비밀번호를 다시 입력해주세요">
		</div>
		<!-- 이름 입력 -->
		<div>
			<p>이름</p>
			<input name="name" type="text">
		</div>
		<!-- 생년월일 -->
		<div>
			<p>생년월일</p>
			<input name="birth" type="text" placeholder="6자리 입력해주세요(예:950118)">
		</div>
		<!-- 이메일 입력 -->
		<div>
			<p>이메일</p>
			<input name="email" type="text">
			<!-- 이메일 인증 -->
			<input type="button" value="인증하기" onclick="emailAuth(this.form)">
		</div>
		<!-- 휴대전화 입력 -->
		<div>
			<p>휴대전화</p>
			<input name="tel" type="text" placeholder="-없이 입력해주세요">
		</div>
		<!-- 가입하기 버튼 -->
		<input type="button" value="가입하기" onclick="join(this.form)">
	</form>
</body>
</html>