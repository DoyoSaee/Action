<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
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
	
	<%-- 이름 공백 확인 --%>
	if ($("#memName").val() == null || $("#memName").val() == "") {
		alert("이름을 입력해주세요.");
		$("#memName").focus();
	 
		return false;
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
	
	if (confirm("확인을 누르시면 id를 검색합니다.")){
		 $("#createForm").submit();
		 
		}else{
		 return false;
		}
	
}
	</script>
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
	.ak{
	color: white
	text-decoration: none;
	margin: 15px 0;
	}
	</style>
</head>
<body>
<section class ="bg">

 <div>
      <h2>아이디 찾기</h2>
      
 </div>
     <form class="member" action="/member/findId" method="POST" onsubmit="return fnSubmit()">
        <table>
        <tr>
        	<td align="center">
            <input type="email" id="email"  name="email" placeholder="Enter Email Address"></td>
        </tr>
         
        <tr>
        	<td align="center">
            <input type="text" id="memName"  name="memName" placeholder="Enter Your Name"></td>
        </tr>
		<tr>    
        	<td align="center"><input type="submit" class="btn11" value="아이디찾기"/></td>
         	
     	</table>
     	<input type="hidden" id="memId">
     </form>
     		<div align="center">
       <a href="/member/login.do" class="ak">로그인 / </a> 
       <a href="/" class="ak"> 메인페이지</a>
    		 </div>
     </section>
</body>
</html>