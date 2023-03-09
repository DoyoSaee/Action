<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  <!-- 날짜 출력 format 지정 -->
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>    
<!DOCTYPE html>
<html>
<head>
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
	
	#memId ,#memName, #email,#passwd ,#postcode, #address, #extraAddress {
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

<meta charset="UTF-8">
<title>회원목록</title>
	
		<script>
		$( document ).ready( function() {
			$("p:contains('0')").html("일반회원");
			$("p:contains('999')").html("관리자"); 
			$("span:contains('0')").html("남자");
			$("span:contains('1')").html("여자");
		} );
		</script>
</head>
<body>
<section class ="bg">
	<h2>회원목록</h2>
		


	<table border="1" style="width: 1100px;">
		<tr>
			<td>아이디</td>
			<td>이름</td>
			<td>성별</td>
			<td>이메일</td>
			<td>가입일자</td>
			<td>주소</td>
			<td>등급</td>
		</tr>
	<c:forEach var="row" items="${list}">
		<tr>
			<td>${row.memId}</td>
			<td><a href="/member/view.do?memId=${row.memId}">${row.memName}</a></td>
			<td width="20%"><span>${row.gender}</span></td>
			<td>${row.email}</td>
			<td><fmt:formatDate value="${row.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td >${row.address}</td>
			<td ><p>${row.grade}</p></td>
		</tr>
	</c:forEach>	
	</table>
</section>	
</body>
</html>