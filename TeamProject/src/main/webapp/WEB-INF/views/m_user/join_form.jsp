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
<!-- 외부 스크립트 파일을 연결하는 코드 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- jquery문 사용을 위한 -->
﻿<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>﻿
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
		}else if(pwd == pwdChk && f.idDuplication.value == "idCheck") {
			alert("회원가입이 완료되었습니다.\n이메일 인증을 진행해주세요!");
			f.action = "join.do";
			f.submit();
		}
	}
	//아이디 중복확인
	function fn_dbCheckId(f) {
		var id = f.id.value;
		var url = "dbCheckId.do";
		var param = "id=" + id;
		if (id.length == 0 || id == "") {
			alert("아이디를 입력해주세요.");
			f.id.focus();
		} else {
			sendRequest(url, param, dbChkId, "post");
		}
	}
	//아이디 중복확인 콜백메서드
	function dbChkId() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			var data = xhr.responseText;
			var json = eval(data);

			if (json[0].param == 'yes') {
				alert('사용할 수 있는 아이디 입니다.');
				document.joinForm.idDuplication.value = "idCheck";
				document.getElementById('id_ok').style.display = 'block';
				document.getElementById('id_already').style.display = 'none';
			} else {
				alert('이미 존재하는 아이디 입니다.');
				document.getElementById('id_already').style.display = 'block';
				document.getElementById('id_ok').style.display = 'none';
			}
		}
	}
	/* 다음 주소 연동 */
	function execution_daum_address(){
		//주소를 검색하는 팝업창을 띄우는 코드
		 new daum.Postcode({
		        oncomplete: function(data) {
		            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
		            
		        	  // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 주소변수 문자열과 참고항목 문자열 합치기
	                    addr += extraAddr;
	                } else {
	                	 addr += ' ';
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                $(".address_input_1").val(data.zonecode);
	                $(".address_input_2").val(addr);
	                // 상세주소 입력란 disabled 속성 변경 및 커서를 상세주소 필드로 이동한다.
	                $(".address_input_3").attr("readonly",false);
	                $(".address_input_3").focus();
		        }
		    }).open();   
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
			<input name="email" type="text" placeholder="이메일을 입력해주세요">
			
		</div>
		<!-- 휴대전화 입력 -->
		<div>
			<p>휴대전화</p>
			<input name="tel" type="text" placeholder="-없이 입력해주세요">
		</div>
		<!-- 주소 입력 -->
		<div class="address_wrap">
			<div class="address_name">주소</div>
			<div class="address_input_1_wrap">
				<div class="address_input_1_box">
					<input class="address_input_1" name="memberAddr1" readonly="readonly">
				</div>
				<div class="address_button" onclick="execution_daum_address()">
					<span>주소 찾기</span>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="address_input_2_wrap">
				<div class="address_input_2_box">
					<input class="address_input_2" name="memberAddr2" readonly="readonly">
				</div>
			</div>
			<div class="address_input_3_wrap">
				<div class="address_input_3_box">
					<input class="address_input_3" name="memberAddr3" readonly="readonly">
				</div>
			</div>
		</div>
		<!-- 가입하기 버튼 -->
		<input type="button" value="가입하기" onclick="join(this.form)">
	</form>
</body>
</html>


















