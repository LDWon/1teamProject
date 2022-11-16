<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	/* .id_ok{
		color: #008000;
		display: none;
	}
	.id_already{
		color: #6A82FB;
		display: none;	
	} */
</style>
<script type="text/javascript">
	/* function checkId() {
		var id = $('#id').val();//id값이 "id"인 입력란의 값을 저장
		$.afax({
			url:'./idCheck',//Controller에서 요청받을 주소
			type:'post',
			data:{id:id},
			success:function(cnt){//컨트롤러에서 넘어온 cnt
				if (cnt==0) {//0일때 사용가능 아이디
					$('.id_ok').css("display","inline-block");
					$('.id_already').css("display", "none");
				}else { // cnt가 1일 경우 -> 이미 존재하는 아이디
                    $('.id_already').css("display","inline-block");
                    $('.id_ok').css("display", "none");
                    alert("아이디를 다시 입력해주세요");
                    $('#id').val('');
                }
			},
            error:function(){
                alert("에러입니다");
            }
		});
	} */
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
		}else if (pwd=="") {
			alert("비밀번호를 입력해주세요.");
		}else if (pwdChk=="") {
			alert("다시 한번 비밀번호를 입력해주세요.");
		}else if (name=="") {
			alert("이름을 입력해주세요.");
		}else if (birth=="") {
			alert("생년월일을 입력해주세요.");
		}else if (email=="") {
			alert("이메일을 입력해주세요.");
		}else if (tel=="") {
			alert("전화번호를 입력해주세요.");
		}
		
		//비밀번호 일치 확인
		if(pwd!=pwdChk){
			alert("비밀번호가 일치하지 않습니다.");
		}else {
			alert("회원가입이 완료되었습니다.");
			f.action="join.do";
			f.submit();
		}
	}
</script>
</head>
<body>
	<form method="post" action="">
		<!-- 메인상표 -->
		<h1>FIND</h1>
		<!-- 아이디 입력 -->
		<div>
			<label>아이디</label>
			<input name="id" id="id" type="text" placeholder="아이디를 입력해주세요" oninput="checkId()">
			<!-- id ajax 중복체크 -->
			<!-- <span class="id_ok">사용 가능한 아이디입니다.</span>
			<span class="id_already">사용할 수 없는 아이디입니다.</span>
			<input type="button" value="중복확인"> -->
		</div>
		<!-- 비밀번호 입력 -->
		<div>
			<p>비밀번호</p>
			<input name="pwd" type="text" placeholder="비밀번호를 입력해주세요">
		</div>
		<div>
			<p>비밀번호 재확인</p>
			<input name="pwdChk" type="text" placeholder="비밀번호를 다시 입력해주세요">
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