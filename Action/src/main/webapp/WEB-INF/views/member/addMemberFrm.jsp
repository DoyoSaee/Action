<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- style --%>
<meta charset="UTF-8">
   <style>
	table {
	  border-collapse: separate;
	  border-spacing: 0;
	  width: 1200px;
	  margin: auto;
	}
	th,	td {
	  padding: 6px 15px;
	 
	}
	th {
	  background: #42444e;
	  color: #fff;
	  text-align: center;
	}
	#waringSpan {
		position: relative;
		left:250px;
		color: red;
	}
	#btns {
		text-color: black;
		text-align: center;
	}
	
	#memId ,#memName, #email,#passwd1 ,#passwd2,#postcode,#address,#extraaddress {
		color:black;
	}
	
	
	
	td {
		width: 30%;
	}
	h2 { text-align: center; }
	
	.btn11 {
	
		border-radius: 7px;
		background-color:white ;
		color:black;
		font-size:20px;
	}
	</style>

<title>회원가입</title>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 상세주소 변수

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
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = '';
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
            }
        }).open();
    }
</script>

<%-- 유효성 검사 처리 --%>
<script>
var path = "${pageContext.request.contextPath }";
 
$(document).ready(function() {
	var msg = "${msg}";
	if(msg != ""){
	alert(msg);    
	}
});
 
 
function fnSubmit() {
	<%-- email 형식 지정 --%> 
	var email_rule =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

	<%-- 아이디 공백 확인 --%>
	if ($("#memId").val() == null || $("#memId").val() == "") {
		alert("아이디를 입력해주세요.");
		$("#memId").focus();
	 
		return false;
	}

	<%-- 비밀번호1  입력 확인 --%>
	if ($("#passwd1").val() == "" && $("#passwd1").val() != "") {
		alert("비밀번호를 입력해주세요.");
		$("#passwd1").focus();
	 
		return false;
	}
	
	<%-- 비밀번호2  입력 확인 --%> 
	if ($("#passwd2").val() != "" && $("#passwd2").val() == "") {
		alert("비밀번호 확인을 입력해주세요.");
		$("#passwd2").focus();
		 
		return false;
	}	
	
	
	<%-- 이름 공백 확인 --%>
	if ($("#memName").val() == null || $("#memName").val() == "") {
		alert("이름을 입력해주세요.");
		$("#memName").focus();
	 
		return false;
	}
	
	<%-- 성별 공백 확인 --%>
	if($('[name="gender"]:checked').length == 0){
		alert('성별을 입력하세요');
		return;
	}
	
	<%-- 이메일 공백 확인 --%> 
	if ($("#email").val() == null || $("#email").val() == "") {
		alert("이메일을 입력해주세요.");
		$("#email").focus();
	 
		return false;
	}
	
	<%-- 이메일 형식 확인 --%>
	if(!email_rule.test($("#email").val())){
		alert("이메일을 형식에 맞게 입력해주세요.");

		return false;
	}
	
	<%-- 주소api 공백 확인 --%>
	if ($("#postcode").val() == null || $("#postcode").val() == "") {
		alert("주소 검색 버튼을 통해 주소를 입력해주세요.");
		$("#postcode").focus();
	 
		return false;
	}

	<%-- 주소api 공백 확인 --%>
	if ($("#extraAddress").val() == null || $("#extraAddress").val() == "") {
		alert("상세 주소를 입력해주세요.");
		$("#extraAddress").focus();
	 
		return false;
	}
	
	<%-- 비밀번호 1,2  일치 확인 --%> 
	if ($("#passwd1").val() != $("#passwd2").val()) {
		alert("입력한 두 비밀번호가 일치하지 않습니다.");
		$("#passwd2").focus();
	 
		return false;
	}
	 
	if (confirm("가입하시겠습니까??")){
	 $("#createForm").submit();
	 alert("가입 성공.로그인 페이지로 이동합니다.");
	}else{
	 return false;
	} 
	
}
 
</script>
<style>

</style>

</head>
<body>
<section class="bg">
<h2 >회원가입 양식</h2>

<form name="createForm" method="post" action="/member/insert.do"   onsubmit="return fnSubmit()">
		
		<table border="1" style="width: 400px">
			<tr>
				<td>아이디</td>
				<td><input name="memId" id="memId" ></td>
				
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="passwd" id=passwd1 ></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password"  id=passwd2></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input name="memName" id="memName"></td>
			</tr>
			<tr>
				<td>성별</td>
				<td><label><input type="radio" name="gender" id="gender" value="0"/>남자</label>
					<label><input type="radio" name="gender" id="gender" value="1"/>여자</label></td>
			</tr>
							
			<tr>
				<td>이메일</td>
				<td><input type="email" name="email" id="email"></td>
				
			</tr>
			<tr>
				<td>주소</td>
				<td>
					<input type="text" name ="postcode" id="postcode" placeholder="우편번호" readonly>
					<input type ="button" class="btn11" onclick="execDaumPostcode()" value="주소 검색" readonly><br>
					<input type="text" name="address" id="address" placeholder="주소" readonly><br>
					<input type="text" name="extraAddress" id="extraAddress" placeholder="상세주소" >
				</td>
			</tr>	
			<tr>
				<td colspan="2" align="center">
				<input type="submit" class="btn11" value="회원가입하기">
				
				</td>
			</tr>
		</table>
					
					
	</form>
	</section>
</body>
</html>