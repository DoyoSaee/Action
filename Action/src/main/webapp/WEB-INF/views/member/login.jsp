<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>로그인 페이지</title>
<style type="text/css">
@import
	url('https://fonts.googleapis.com/css?family=Montserrat:400,800');

* {
	box-sizing: border-box;
}

body {
	
	justify-content: center;
	align-items: center;
	flex-direction: column;
	font-family: 'Montserrat', sans-serif;
	height: 200vh;
	margin: -20px 0 50px;
}

h1 {
	font-weight: bold;
	margin: 0;
}

p {
	font-size: 14px;
	font-weight: 100;
	line-height: 20px;
	letter-spacing: 0.5px;
	margin: 20px 0 30px;
}

span {
	font-size: 12px;
}

.ak{
	color: #4a3b3a;
	text-decoration: none;
	margin: 15px 0;
}

button {
	border-radius: 20px;
	border: 1px solid #241d1c;
	background-color: #241d1c;
	color: #FFFFFF;
	font-size: 12px;
	font-weight: bold;
	padding: 12px 45px;
	letter-spacing: 1px;
	text-transform: uppercase;
	transition: transform 80ms ease-in;
}

form {
	background-color: #d5d1d1;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	padding: 0 50px;
	height: 100%;
	text-align: center;
}

input {
	border-radius:10px;
	background-color: #eee;
	border: none;
	padding: 12px 15px;
	margin: 8px 0;
	width: 100%;
}

.container2 {
	border-radius: 10px;
	box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px
		rgba(0, 0, 0, 0.22);
	position: relative;
	overflow: hidden;
	width: 768px;
	max-width: 100%;
	min-height: 480px;
}

.form-container {
	position: absolute;
	top: 0;
	height: 100%;
}

.log-in-container {
	left: 0;
	width: 50%;
	z-index: 2;
}

.overlay-container {
	position: absolute;
	top: 0;
	left: 50%;
	width: 50%;
	height: 100%;
}

.overlay {
	background: linear-gradient(to bottom, #000000 0%, #ffffff 200%);
	    background-repeat: no-repeat;
    background-size: cover;
    background-position: 0 0;
    color: #FFFFFF;
    position: relative;
    left: -100%;
    height: 100%;
    width: 200%;
}

.overlay-panel {
	position: absolute;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	padding: 0 40px;
	text-align: center;
	top: 0;
	height: 100%;
	width: 50%;
}

.overlay-right {
	right: 0;
}

.social-container {
	/*margin: 50px 0;*/
	
}

.social-container a {
	border: 1px solid #DDDDDD;
	border-radius: 50%;
	display: inline-flex;
	justify-content: center;
	align-items: center;
	margin: 0 5px;
	height: 40px;
	width: 40px;
}

.headH1 {
	position: absolute;
	margin-left: -20px;
	color: ##4a3b3a;
	margin-top: -250px;
}
</style>

</head>
<body>
<section style="margin-top: 5%;margin-left: 30%;">
	<div class="container2" id="container2">
		<div class="form-container log-in-container">
			<form action="/member/login_check.do" method="post">
				<h1 class="headH1"><a class="ak" href="/"><strong>Action</strong></a></h1><br><br><br>
				
				<input type="text" placeholder="ID" name="memId" /> 
				<input type="password" placeholder="Password" name="passwd" style="    color: black;"/> 
				<p>
				<a class="ak"href="/member/write.do" > 회원가입 /</a>
				<a class="ak"href="/member/findId" > 아이디찾기 /</a>
				<a class="ak"href="/member/findPasswd">비밀번호찾기</a>
				</p>
				
				<button style="cursor: pointer;" id="btnLogin">Log In</button>
			</form>
		</div>
		<div class="overlay-container">
			<div class="overlay">
				<div class="overlay-panel overlay-right">
					<h1>Enjoy  Movies,  Global  No.1 Action</h1>
					<p>2023 Action</p>
				</div>
			</div>
		</div>
</div>
	</section>
</body>
</html>