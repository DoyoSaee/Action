<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script type="text/javascript">



	var msg = "${msg}";
		 
		if (msg != "") {
			alert(msg);
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
	color: white;
	text-decoration: none;
	margin: 15px 0;
	}
	</style>
</head>
<body>
<section class ="bg">

   <div class="text-center">
           <h2>비밀번호 찾기</h2>
       </div>
       <form class="member" action="/member/findPasswd" method="POST">
           <table>
           <tr>
        	 <td align="center"><input type="text" id="memId"  name="memId" placeholder="Enter Your Id"></td>
           </tr>
           
      
           <tr>
             <td align="center"><input type="text" id="memName"  name="memName" placeholder="Enter Your Name"></td>
           </tr>
           
           <tr>
            <td align="center"><input type="email" id="email"  name="email" placeholder="Enter Your Email"></td>
           </tr>
           
      		<tr>
           <td align="center"><button type="submit" class="btn11">비밀번호 찾기 </button></td>
           </tr>
           </table>
       </form>

          <div class="text-center">     
       		<a class="ak" href="/member/login.do">로그인 / </a>
           	<a class="ak" href="/">메인페이지</a>
     </div>
     </section>
</body>
</html>