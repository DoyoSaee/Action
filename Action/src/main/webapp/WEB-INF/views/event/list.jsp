<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"	href="${ pageContext.request.contextPath }/resources/css/movie_rank.css">
<link rel="stylesheet"	href="${ pageContext.request.contextPath }/resources/css/movie_release.css">
<link rel="stylesheet"	href="${ pageContext.request.contextPath }/resources/css/movie_query.css">
<meta charset="UTF-8">
<title>이벤트 목록</title>
</head>
<style >


td{
	text-align: center;
}


#tablediv{	
		
}
#search{
	position: relative;
    left: 1120px;
    margin:20px;
}


<style type="text/css">
   th{
      width: 50px;
   }
  
   body {
     color: #666;
     font: 14px/24px "Open Sans", "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", Sans-Serif;
   }
   table {
     border-collapse: separate;
     border-spacing: 0;
     width: 100%;
     margin: auto;
     background-color: white;
     
   }
   th,   td {
     padding: 6px 15px;
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
     background: white;
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

</style>
<body>
<section id="bg">


<div class="searchmove">
	<form id="search" action="${contextPath}/event/list">  
		<input type="text" placeholder="검색어를 입력하세요." name="keyword" value="${keyword}" />  
		<input type="submit" value="검색" />
	</form>
</div>

<div id="tablediv">

<table border=1 style="width:1200px;">
    <thead>
        <tr>
            <th>번호</th>
            <th>작성자</th>
            <th>제목</th>
            <th>등록일</th>
        </tr>
    </thead>
    <tbody>
         <c:forEach var="data" items="${list}">
            <tr>
                <td>${data.eventNo}</td>
                <td>${data.memberId}</td>
                <td><a href="${contextPath}/event/detailForm?eventNo=${data.eventNo}" style="color: black;">${data.title}
                <td><fmt:formatDate value="${data.writeDate}" pattern="yyyy-MM-dd"/></td>
       </a></td>
            </tr>
      </c:forEach>
    </tbody>
</table>
<button type="button" onclick="location.href='${contextPath}/event/addForm'">글쓰기</button>
</div>

</section>
</body>
</html>




