<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="<%=request.getContextPath()%>"></c:set> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>

	
<style >
   
	td{
		text-align: center;
	}
	.searchmove{
				position: relative;
	            margin-left:18.5%;
	            margin-top:2%;
	            margin-bottom:2%;
	            }
	
	#tablediv{	
			
	}
   th{
      width: 200px;
   }
   body {
     color: #666;
   }
   table {
     border-spacing: 0;
     width: 100%;
     margin: auto;
     background-color: #cacaca;
     
   }
   th,   td {
     padding: 6px 15px;
   }
   th {
     background: #42444e;
     color: #fff;
     text-align: center;
   }
   td {
     border-right: 1px solid #c6c9cc;
     border-bottom: 1px solid #c6c9cc;
   }
   td:first-child {
     border-left: 1px solid #c6c9cc;
   }
   tr:nth-child(even) td {
     background: #c1c1c1;
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
	button{
	background-color:#dadada;
	}
	input{
	background-color:#dadada;
	}
	.ak {
	color:black;
	}
	button{
	color: black;
	background-color: #ffffff;
	border: none;height: 50px;
	width: 200px;
	border-radius: 10px;
		}




.filebox input[type="file"] {
  position: absolute;
  width: 0;
  height: 0;
  padding: 0;
  overflow: hidden;
  border: 0;
}

.filebox label {
  display: inline-block;
  padding: 10px 20px;
  color: #999;
  vertical-align: middle;
  background-color: #fdfdfd;
  cursor: pointer;
  border: 1px solid #ebebeb;
  border-radius: 5px;
}

/* named upload */
.filebox .upload-name {
  display: inline-block;
  height: 35px;
  font-size:18px; 
  padding: 0 10px;
  vertical-align: middle;
  background-color: #f5f5f5;
  border: 1px solid #ebebeb;
  border-radius: 5px;

}
</style>

	<meta charset="UTF-8">
	<title>?????????</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	
	<script>
	let count=1; 
	$(document).ready(function(){
	
    	$("#btnDelFile").click(function(){ 
		  	if(count==1){ //?????????????????? ??????????????? ?????????
		  		alert("????????? ????????? ????????? ?????????.");
		  		return;
		  	}
	  		let tr = $("#files"+count).parents("tr");
	  		//id??? "i1"????????? ?????? ?????? ????????? ??????(??????)??? ???????????? ????????? ?????????
	   		//$(????????????).remove();
		    $(tr).remove();
		  	count--; 
		});

		$("#btnAddFile").click(function(){ 
			count++;
			if(count==4){ //????????? ???????????????(3???)?????? ?????????
				alert("??????????????? ?????? 3????????? ???????????????.");
				count=3;
				return; //????????????
			}
   			let tr = "<tr><th>????????????"+count+"</th><td>";
   				tr+= "<div class='filebox'>";
   				tr+= "<label for='files"+count+"'>?????????</label>";
   				tr+= "<input type='file' name='file"+count+"'id='files"+count+"'/></div></td></tr>";
   
   				
   				
   				
//    			<div class="filebox"> 
// 				  <label for="file">?????????</label> 
// 				  <input type="file" id="file"> 
// 				  <input class="upload-name" value="????????????">
// 				</div>


			//id??? "i1"????????? ?????? ?????? ????????? ??????(??????)?????????
			//$(????????????).before(???????????????);	
			$("#i1").before(tr);	
		});
		
		$("#btnList").click(function(no) {
			location.href = "${path}/qna/list";
		});
	});
	</script>

</head>
<body>

	<!--
	memNo: ${memNo} <br/>
	memId: ${memId} <br/>
	email:  ${email} <br/><br/>
	
	badRequest:${badRequest}
	-->
	
	<section class="bg">
	<br/><br/>
	
	<div id="tableDiv">
	<form action="${path}/qna/add" id="addForm" method="post" enctype="multipart/form-data">

		<input type="hidden" name="memNo" value="${sessionScope.memNo}" >
		<input type="hidden" name="writerId" value="${sessionScope.memId}" >
		<input type="hidden" name="writerEmail" value="${sessionScope.email}" >

		<table border="1"  style="    width: 63%;">
			<tr>
				<th>????????? ?????????</th>
				<td>${sessionScope.memId}</td>
			</tr>
			<tr>
				<th>??? ????????????</th>
				<td>
					<span><input type="radio" name="secret" id="secret" value="N" class="radio" required="required"><p style="    margin-left: -90%;    margin-top: -1.5%;">??????</p></span>
					<span><input type="radio" name="secret" id="secret" value="Y" class="radio"> <p style=" margin-left: -90%;    margin-top: -1.5%;">?????????</p></span>
				</td>
			</tr>
			<tr>
				<th>??????</th>
				<td>
					<input type="text" name="title" style="color: black; width: 950px;"/>
					<br>
					<spring:hasBindErrors name="qna">
						<c:if test="${errors.hasFieldErrors('title')}">
							<strong style="color: red;">${errors.getFieldError('title').defaultMessage}</strong>
						</c:if>
					</spring:hasBindErrors>
				</td>
			</tr>
			<tr>
				<th>??????</th>
				<td>
					<textarea cols="90" rows="10" name="content" style="color: black;" ></textarea>
					<br>
					<spring:hasBindErrors name="qna">
						<c:if test="${errors.hasFieldErrors('content')}">
							<strong style="color: red;">${errors.getFieldError('content').defaultMessage}</strong>
						</c:if>
					</spring:hasBindErrors>
				</td>
			</tr>
			<tr>
				<td></td>
			    <td>
			    <span id="waringSpan">*???????????? : ????????? ????????? ???????????? ?????????????????????</span><br><br>
			        <input type="button" value="????????????" id="btnAddFile" style="color: black;background-color: #ffffff;border: none;height: 50px;width: 200px;border-radius: 10px;" />
			    	<input type="button" value="????????????" id="btnDelFile" style="color: black;background-color: #ffffff;border: none;height: 50px;width: 200px;border-radius: 10px;" />
				</td>
			</tr>
			<tr>
				<th>????????????</th>
				<td>
					<div class="filebox"> 
					  <label for="file">?????????</label> 
					  <input type="file" id="file"> 
					  <input class="upload-name" value="????????????">
					</div>
	     		</td>
			</tr>	
			<tr id="i1">
	     		<td colspan="2" style="text-align: center;">
	     			<input type="submit" value="??????" style="color: black;background-color: #ffffff;border: none;height: 50px;width: 200px;border-radius: 10px; margin-left: 17%;" />
	     			<input type="button" value="??????" id="btnList" style="color: black;background-color: #ffffff;border: none;height: 50px;width: 200px;border-radius: 10px;" />
	     		</td>
	    	</tr>	
		</table>

		<!-- ???????????? ???????????? ????????? ???????????? ?????????????????? ??????
	    <div id="fileArea">
	    </div>
	    -->
	</form>
	</div>
	
	</section>
</body>
</html>