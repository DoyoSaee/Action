<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detail</title>
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<link rel="stylesheet"  href="${ pageContext.request.contextPath }/resources/css/movie_detail.css">
<link rel="stylesheet"	href="${ pageContext.request.contextPath }/resources/css/movie_rank.css">
<link rel="stylesheet"	href="${ pageContext.request.contextPath }/resources/css/movie_release.css">
<link rel="stylesheet"	href="${ pageContext.request.contextPath }/resources/css/movie_query.css">
<style type="text/css">
body {
	background-image: url(${ pageContext.request.contextPath }/resources/img/m_list_bg.png);
	background-repeat: repeat-y;
	background-size: 100%;
}
#header .nav > h2 > img { width:100%; height:70px;   
	animation: main_bg 0.7s linear infinite;
	animation-iteration-count: 2;
	}
@keyframes main_bg {
    50% {opacity:0.2;}
    100% {opacity:1;}
}
	</style>
<script type="text/javascript">
   
      if (self.name != 'reload') {
         self.name = 'reload';
         self.location.reload(true);
      }
      else self.name = '';
   
      window.onload=function(){
         
         var totalTitle;
         var outposters;
         var splitStills;
         if( "${type}" == "2" ){
            load_list2();
         } else {
            load_list();         
         }
      };
      
      
      
      //여러개 포스터 잘라쓰기
      function spPoster(inPosters) {
         
          outposters = inPosters.split('|');
         
         if (inPosters === "") {
            outposters[0] = "${ pageContext.request.contextPath }/resources/img/nullImg.png";
         }
         
         //한개 포스터 출력
         var onePoster = document.createElement("img");
          onePoster.src = outposters[0];
          document.getElementById("movie_detail_poster_contain").appendChild(onePoster);
          document.getElementById("movie_first_box").style.backgroundImage="url("+outposters[0]+")";
         
          //여러개의 포스터 출력(임시 : 포스터 더보기 누르면 뜨게)
         /* for(var i = 0 ; i<outposters.length; i++){
             var onePoster = document.createElement("img");
             onePoster.src = outposters[i];
             document.getElementById("movie_detail_poster_contain").appendChild(onePoster); 
          } */

      }
      
      //필요한 OPEN API 불러오기(Ajax)
      //상영예정작 -> 상세정보
      function load_list(){
         var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
         var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&movieId=${movieId}&movieSeq=${movieSeq}';
         sendRequest( url, param, resultFn, "GET" );
      }
      
      //박스오피스 -> 상세정보
      function load_list2(){
         var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
         var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&title=${title}&releaseDts=${releaseDts}';
         sendRequest( url, param, resultFn, "GET" );      
      }
      
      function resultFn(){
         
         if( xhr.readyState == 4 && xhr.status == 200 ){
            
            var data = xhr.responseText;
            var json = eval("["+data+"]");      

             spPoster(json[0].Data[0].Result[0].posters);//포스터
             var movieNm = json[0].Data[0].Result[0].title;
             
             //영화 제목   
             if( "${type}" == "2" ){
                totalTitle="${title}";   
             } else {
                //()"${type}" == "1" )
                totalTitle=movieNm;             
             }
             document.getElementById("movie_detail_title").innerHTML=totalTitle;
             document.getElementById("movie_detail_titleEng").innerHTML=json[0].Data[0].Result[0].titleEng;//영화 영문 제목
             document.getElementById("movie_detail_directors").innerHTML="<b>감독  </b>" +json[0].Data[0].Result[0].directors.director[0].directorNm;//감독
             
             //배우 출력하기 위한 코드
             var actor = "<b>배우  </b>";
             var maxNumActor = json[0].Data[0].Result[0].actors.actor.length;
             var etc = 0;
             //배우가 많으면 5명만 출력
             if( maxNumActor >= 6 ){
                maxNumActor = 6;
                etc = 1;
             }
             
             for(var i=0 ; i<maxNumActor; i++){
                if( i === maxNumActor-1 ){
                   actor += json[0].Data[0].Result[0].actors.actor[i].actorNm;
                   if( etc === 1 ) {
                      actor += " 등..";
                   }
                } else {
                   actor += json[0].Data[0].Result[0].actors.actor[i].actorNm + " ,  ";//배우 한명 한명                   
                }
             }
             document.getElementById("movie_detail_actors").innerHTML=actor;//배우들
             etc = 0;
             
             document.getElementById("movie_detail_genre").innerHTML="<b>장르  </b>"+json[0].Data[0].Result[0].genre;//장르
             document.getElementById("movie_detail_rating").innerHTML=json[0].Data[0].Result[0].rating;//관람등급
             document.getElementById("movie_detail_nation").innerHTML="<b>국가  </b>"+json[0].Data[0].Result[0].nation;//국가
             document.getElementById("movie_detail_company").innerHTML="<b>제작  </b>"+json[0].Data[0].Result[0].company;//회사
             
             document.getElementById("movie_detail_relDate").innerHTML=json[0].Data[0].Result[0].repRlsDate+" 개봉";//개봉일
             document.getElementById("movie_detail_runtime").innerHTML=json[0].Data[0].Result[0].runtime+"분";//상영시간
                
             document.getElementById("movie_detail_plot").innerHTML=json[0].Data[0].Result[0].plots.plot[0].plotText;//줄거리
            
             //트레일러 주소 불러오기
             if( "${type}" == "2" ){
                document.getElementById("movie_trailer_frame").src="${trailer}";
             }
             
             //여러개의 스틸이미지를 출력하기 위함
             var stills = json[0].Data[0].Result[0].stlls;
                splitStills = stills.split('|');
               if(splitStills.length >= 4){
                   document.getElementById("movie_still_img_0").src = splitStills[0];
                   document.getElementById("movie_still_img_1").src = splitStills[1];
                   document.getElementById("movie_still_img_2").src = splitStills[2];
               } else if(splitStills.length == 3){
                  document.getElementById("movie_still_img_0").src = splitStills[0];
                   document.getElementById("movie_still_img_1").src = splitStills[1];
                   document.getElementById("movie_still_img_2").src = "${ pageContext.request.contextPath }/resources/img/nullImg.png";
               } else if(splitStills.length == 2){
                  document.getElementById("movie_still_img_0").src = splitStills[0];
                  document.getElementById("movie_still_img_1").src = "${ pageContext.request.contextPath }/resources/img/nullImg.png";
                  document.getElementById("movie_still_img_2").src = "${ pageContext.request.contextPath }/resources/img/nullImg.png";
               } else{
                  document.getElementById("movie_still_img_0").src = "${ pageContext.request.contextPath }/resources/img/nullImg.png";
                  document.getElementById("movie_still_img_1").src = "${ pageContext.request.contextPath }/resources/img/nullImg.png";
                  document.getElementById("movie_still_img_2").src = "${ pageContext.request.contextPath }/resources/img/nullImg.png";
               }
              
         }
      }
      
      var num = 0;
      var maxNum = num+3;
       function nextStill() {
         num++;
         maxNum = num+3;
         document.getElementById("prevBtn").style.display="block";   
         if( maxNum >= splitStills.length ) {
            document.getElementById("nextBtn").style.display="none";                  
         }
         document.getElementById("movie_still_img_0").src = splitStills[num];
         document.getElementById("movie_still_img_1").src = splitStills[num+1];
         document.getElementById("movie_still_img_2").src = splitStills[num+2];
      }
      
      function prevStill() {
         num--;
         document.getElementById("nextBtn").style.display="block";
         if( num <= 0) {
            document.getElementById("prevBtn").style.display="none";   
         }
         document.getElementById("movie_still_img_0").src = splitStills[num];
         document.getElementById("movie_still_img_1").src = splitStills[num+1];
         document.getElementById("movie_still_img_2").src = splitStills[num+2];
      }
      
      
      //--------------요서부터 리뷰 추가 예정--------------------
        
 
    
   </script>


</head>
<body>


		<div id="container" style="width: 57%;">

			<div id="contents">
				<div id="movie_chart">
					<!-- <div id="chart_title"><h4>영화 상세 정보</h4></div> -->

					<div id="show_movie_details_con">

						<div id="movie_first_box">
							<div id="movie_first_box_cover">
								<div id="movie_detail_poster">
									<div id="movie_detail_poster_contain"></div>
									<!-- <input type="button" value="포스터 더 보기" onclick="moreView();"> -->
								</div>

								<div id="movie_detail_infomation">

									<div id="movie_titles">
										<div id="movie_detail_title"></div>
										<div id="movie_detail_titleEng"></div>
									</div>

									<div id="movie_baseInfo">
										<div id="movie_detail_genre"></div>
										<div id="movie_detail_relDate"></div>
										<div id="movie_detail_runtime"></div>

										<div id="movie_detail_directors"></div>
										<div id="movie_detail_actors"></div>
									</div>

									<div id="movie_baseInfo_2">
										<div id="movie_detail_nation"></div>
										<div id="movie_detail_rating"></div>
										<div id="movie_detail_company"></div>
									</div>

								</div>
							</div>
						</div>


						<div id="movie_detail_plots">
							<div id="movie_detail_plot_title">줄거리</div>
							<div id="movie_detail_plot"></div>
						</div>

						<div id="movie_detail_still_box">
							<div id="movie_detail_still_box_position">
								<div id="movie_detail_still_title">스틸컷 / 예고편</div>
								<div id="movie_detail_still">
									<a href="javascript:void(0);" id="prevBtn"
										onclick="prevStill();"><img width="16px"
										src="${ pageContext.request.contextPath }/resources/img/leftArrow.png"></a>
									<a href="javascript:void(0);" id="nextBtn"
										onclick="nextStill();"><img width="16px"
										src="${ pageContext.request.contextPath }/resources/img/rightArrow.png"></a>
									<div id="still_imgs">
										<img id="movie_still_img_0"> <img id="movie_still_img_1">
										<img id="movie_still_img_2">
									</div>
								</div>
							</div>

						</div>


						<c:if test="${type eq '2'}">
							<div id="movie_trailer_box">
								<iframe id="movie_trailer_frame" width="950" height="534" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen
									style="margin-left:71px;"></iframe>
							</div>
						</c:if>

					</div>

				</div>
			</div>
</div>
			<!-- 여기서 부터 review 추가 예정 -->
	


</body>
</html>