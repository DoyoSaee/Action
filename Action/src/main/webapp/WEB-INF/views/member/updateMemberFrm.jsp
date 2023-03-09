<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  <!-- 날짜 출력 format 지정 -->
  
<!DOCTYPE html>
<html>
<head>
<%-- style --%>
<meta charset="UTF-8">
   <style type="text/css">
   th{
      width: 50px;
   }
   <style>
   body {
     color: #666;
     font: 14px/24px "Open Sans", "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", Sans-Serif;
   }
   table {
     border-collapse: separate;
     border-spacing: 0;
     width: 1000px;
     margin: auto;
   }
   th,   td {
     padding: 6px 15px;
	color:blue
   }
   th {
     background: #42444e;
     color: #fff;
     text-align: center;
   }
   tr:first-child th:first-child {
     border-top-left-radius: 6px;
   }
   tr:first-child th:last-child {
     border-top-right-radius: 6px;
   }
   td {
     border-right: 1px solid #c6c9cc;
     border-bottom: 1px solid #c6c9cc;
   }
   td:first-child {
     border-left: 1px solid #c6c9cc;
   }
   tr:nth-child(even) td {
     background:   #C0C0C0;
   }
   tr:last-child td:first-child {
     border-bottom-left-radius: 6px;
   }
   tr:last-child td:last-child {
     border-bottom-right-radius: 6px;
   }
   #searchDiv, #tableDiv {
      text-align: center;
   }
   .writeSpan1 {
      position: relative;
      left: 160px;
   }
   .writeSpan2 {
      position: relative;
      left: 1010px;
   }
   
   .button {
  background-color: blue;
  border-radius: 5%;
  color: white;
  padding: 15px 30px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  
  </style>

<meta charset="UTF-8">
<title>내 정보 수정</title>
	
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>	
	<script>
		$(function() {
			
			$("#btnUpdate").click(function() {				
				document.form1.action="/member/update.do";	
				document.form1.submit();					
			});
			
			$("#btnDelete").click(function() {		
				if(confirm("탈퇴하시겠습니까? 한번 탈퇴하면 다시 되돌릴 수 없습니다.")) {
					document.form1.action="/member/delete.do";
					document.form1.submit();
				}
			});
		});
		$( document ).ready( function() {
			$("p:contains('0')").html("일반회원");
			$("p:contains('999')").html("관리자"); 
			$("span:contains('0')").html("남자");
			$("span:contains('1')").html("여자");
		} );
	</script>
	<!-- 유효성검사 -->
	<script>
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
		

		 
		if (confirm("수정하시겠습니까??")){
		
			$("#createForm").submit();
		
		}else{
		 
			return false;
		} 
		
	}
	 
	</script>
	</script>
	
</head>
<body>
<section class="bg">

	<h2>내 정보</h2>
	<form name="form1" method="post"	onsubmit="return fnSubmit()">
		<table border="1" style="width: 400px">		
												
			<tr>									
				<td>아이디</td>						
				<td><input name="memId" id="memId"value="${dto.memId}" readonly></td>	
			</tr>																
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="passwd" id="passwd"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input name="memName" id="memName" value="${dto.memName}"></td>
			</tr>
			<tr>
				<td>성별</td>
				<td><span><input name="gender" value="${dto.gender}" disabled="disabled">${dto.gender}</span></td>
			</tr>
			
			<tr>
				<td>이메일</td>
				<td><input name="email" id=email value="${dto.email}"></td>
			</tr>
			<tr>
				<td>회원가입 일자</td>
				<td><fmt:formatDate value="${dto.regDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			<tr>
				<td>우편번호</td>
				<td><input name="postcode" id="postcode" value="${dto.postcode}"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input name="address" value="${dto.address}"></td>
			</tr>
			
			<tr>
				<td>상세주소</td>
				<td><input name="extraAddress" id="extraAddress" value="${dto.extraAddress}"></td>
			</tr>
						
			<tr>
				<td>등급</td>
				<td><p><input name="grade" value="${dto.grade}" disabled="disabled">${dto.grade}</p></td>
			</tr>			
						
			
			<tr>
				<td colspan="2" align="center">
					<input type="submit" class="button" value="수정" id="btnUpdate">
					<input type="button" class="button" value="삭제" id="btnDelete">
					<div style="color: red"> ${message} </div>			<!--비밀번호 틀릴경우 message 출력  -->
				</td>
			</tr>
		</table>
		<input type="hidden" id="memNo" name="memNo" value="${dto.memNo}">
	</form>
</section>
</body>
</html>