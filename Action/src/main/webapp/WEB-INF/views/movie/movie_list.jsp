<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Action</title> 
<link rel="stylesheet"	href="${ pageContext.request.contextPath }/resources/css/movie_rank.css">
<link rel="stylesheet"	href="${ pageContext.request.contextPath }/resources/css/movie_release.css">
<link rel="stylesheet"	href="${ pageContext.request.contextPath }/resources/css/movie_query.css">
<style type="text/css">
body {
	background-image:
		url(${ pageContext.request.contextPath }/resources/img/m_list_bg.png);
}
.bg {
	background-color: #121116a6;
	padding-bottom: 90px;
}
#back-top {
			position: fixed;
			bottom: 30px;
			margin-left: -150px;
		}

		#back-top a {
			width: 108px;
			display: block;
			text-align: center;
			font: 11px/100% Arial, Helvetica, sans-serif;
			text-transform: uppercase;
			text-decoration: none;
			color: #bbb;
			
			/* transition */
			-webkit-transition: 1s;
			-moz-transition: 1s;
			transition: 1s;
		}
		#back-top a:hover {
			color: #000;
		}
		
		/* arrow icon (span tag) */
		#back-top span {
			width: 108px;
			height: 108px;
			display: block;
			margin-bottom: 7px;
			background: #ddd url(up-arrow.png) no-repeat center center;
			
			/* rounded corners */
			-webkit-border-radius: 15px;
			-moz-border-radius: 15px;
			border-radius: 15px;
			
			/* transition */
			-webkit-transition: 1s;
			-moz-transition: 1s;
			transition: 1s;
		}
		#back-top a:hover span {
			background-color: #777;
		}
        
        #header .nav > h2 > img{ width:100%; height:70px;   
			animation: main_bg 0.7s linear infinite;
			animation-iteration-count: 2;}
		@keyframes main_bg{
		    50% {opacity:0.2;}
		    100% {opacity:1;}
		}
		
.dropdown {
	position: relative;
	display: inline-block;
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: black;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(255, 255, 255, 0.9);
	padding: 12px 16px;
	z-index: 1;
}

.dropdown:hover .dropdown-content {
	display: block;
}
</style>
   <script type="text/javascript">
   
      window.onload=function(){
         load_release_list();

         //??????????????? ?????? ??????
         for(var i = 0; i < 3 ; i++){
            var st = getCookie("id"+i);
            if( st != undefined ){
               document.getElementById("recent_query_data_"+i).value = st;
               document.getElementById("recent_query_"+i).innerHTML = st;
               document.getElementById("del_icon_"+i).style.display = "block";
            }
         }
         
         if( getCookie("check") == 'yes' ){
            queryMovie();
            deleteCookie("check");
            
         }
      };
      
      //?????? ?????? 
      var date = new Date();
      
      var today = loadDate()-1;//1?????? ??????????????????
      var releaseStart = releaseDtStart();
      var releaseEnd = releaseDtEnd();

      var moreCount = 1;//????????? ????????? 
   
      function more_list(){
         moreCount++;
         document.getElementById("select_movie_lists_release_"+moreCount).style.display="block";
         if(moreCount == 4){
            var moreButton = document.getElementById("movie_release_list_moreSee");
            moreButton.removeChild( moreButton.children[0] );
         }
      }
      //??????????????? ??????
      function boxOfficeView(){
         load_boxOff_list();
         document.getElementById("contents_release").style.display="none";
         document.getElementById("contents_query").style.display="none";
         document.getElementById("contents_rank").style.display="block";
      }
      //??????????????? ??????
      function scheduledScreenView(){
         load_release_list();
         document.getElementById("contents_rank").style.display="none";
         document.getElementById("contents_query").style.display="none";
         document.getElementById("contents_release").style.display="block";
      }
      //????????????
      function queryMovie(){
         document.getElementById("contents_release").style.display="none";
         document.getElementById("contents_rank").style.display="none";
         document.getElementById("contents_query").style.display="block";
      }
      //????????? ????????? ????????????
      function cutPoster(posters) {
           if (posters.indexOf("|") !== -1) {
             posters = posters.substring(0, posters.indexOf("|"));
           }
           if (posters === "") {
             posters = "${ pageContext.request.contextPath }/resources/img/nullImg.png";
           }
           return posters;
      }
      
      //?????? ????????? ????????? ???????????? ??????
      function load_release_list(){
         var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
         var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&releaseDts='+releaseStart+'&releaseDte=2'+releaseEnd+'&listCount=10';
         console.log(releaseStart + "/"+releaseEnd+"/");
         sendRequest( url, param, resultFnRel, "GET" );
      }
      
      function resultFnRel(){   
         if( xhr.readyState == 4 && xhr.status == 200 ){      
            var data = xhr.responseText;
            var json = eval("["+data+"]");      
            
            for(var i=0 ; i<json[0].Data[0].Result.length ; i++){
               
                var moviePoster = cutPoster(json[0].Data[0].Result[i].posters);//json???????????? ????????? ?????? ???????????? ???????????? ?????? ????????? ???????????? ?????????
                var releaseTitle = json[0].Data[0].Result[i].title;
                if( releaseTitle == null ){
                   releaseTitle = '???????????? ??????';
                }
                document.getElementById("movie_release_movieId_"+i).value=json[0].Data[0].Result[i].movieId;//?????? ??????1
                document.getElementById("movie_release_movieSeq_"+i).value=json[0].Data[0].Result[i].movieSeq;//?????? ??????2
                var td = document.getElementById("movie_release_title_data_"+i);
                td.value=releaseTitle;//?????? ??????
                document.getElementById("movie_release_title_"+i).innerHTML=releaseTitle;//?????? ??????
                document.getElementById("movie_release_poster_"+i+"_img").src=moviePoster;//?????????
                
                //???????????? ??????
                var releaseY = json[0].Data[0].Result[i].repRlsDate.substring(0,4);
                var releaseM = json[0].Data[0].Result[i].repRlsDate.substring(4,6);
                var releaseD = json[0].Data[0].Result[i].repRlsDate.substring(6,8);
                var releaseDate = releaseY+"."+releaseM+"."+releaseD+" ??????";
                if(releaseD=="00"){
                   releaseDate =  releaseY+"."+releaseM+". ??????";
                }
                
                document.getElementById("movie_release_relDate_"+i).innerHTML=releaseDate;//?????????
                document.getElementById("movie_release_runtime_"+i).innerHTML=json[0].Data[0].Result[i].runtime+"???";//????????????
                var movie_add_button=document.getElementById("movie_action_button_text_"+i); 
                if(movie_add_button.children[0] == undefined ){
                   if(today >= json[0].Data[0].Result[i].repRlsDate-2){
                       var aTag=document.createElement("a");
                       aTag.href="ticketing.do?m_name="+releaseTitle; 
                       aTag.innerHTML="????????????";
                       movie_add_button.appendChild(aTag);
                      /* document.getElementById("movie_action_button_text_"+i).innerHTML="??????"; */
                   } else{
                       var pTag=document.createElement("p");
                       pTag.innerHTML="????????????";
                       movie_add_button.appendChild(pTag);
                   }
                }
            }      
         }
      }
      
      //?????? ?????? ??????????????? ?????????(?????? ???????????? ?????????)
      function detail( movieId, movieSeq, m_name ){
         return location.href="movieInfoDetail?movieId="+movieId+"&movieSeq="+movieSeq+"&m_name="+encodeURIComponent(m_name);
      }
      
//------------------rank----------------------------------------------------------
      function loading_del(){
          var loadingText = document.getElementById("loadingText");
         if( loadingText.children[0] != undefined ){
            loadingText.removeChild( loadingText.children[0] );                         
         }
      }
      
      //?????????????????? ???????????? ??????
      function load_boxOff_list(){
         var url ='http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json';
         var param = 'key=a7c6bfb2e16d4d1ae14730f90bc6726a&targetDt='+today;
         sendRequest( url, param, resultFnRank, "GET" );   
      }
      
      
      function resultFnRank(){
         if( xhr.readyState == 4 && xhr.status == 200 ){
            var data = xhr.responseText;
            var json = eval("["+data+"]");   
            var movie_list =document.getElementById("movie_list");
            for(var i=0 ; i<json[0].boxOfficeResult.dailyBoxOfficeList.length ; i++){

               var openDts = noFormDates(json[0].boxOfficeResult.dailyBoxOfficeList[i].openDt);
               document.getElementById("movie_openDt_"+i).value=openDts;//?????? ??????(?????????)
               document.getElementById("movie_movieNm_"+i).value=json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;//?????? ???????????? ?????????(?????????)
                document.getElementById("movie_rank_movieNm_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;;//?????? ??????
                document.getElementById("ticket"+i).href="ticketing.do?m_name="+json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;
                document.getElementById("movie_rank_rank_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].rank+" ???";//??????
                document.getElementById("movie_rank_salesShare_"+i).innerHTML="????????? : "+json[0].boxOfficeResult.dailyBoxOfficeList[i].salesShare+" %";//?????????
                document.getElementById("movie_rank_audiAcc_"+i).innerHTML="??????????????? : "+json[0].boxOfficeResult.dailyBoxOfficeList[i].audiAcc+"???";//???????????????
                document.getElementById("movie_rank_openDt_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].openDt+"??????";//?????????
            }
            load_poster();
            loading_del();      
         }      
      }
      
      //??????????????????  DB?????? ????????? ????????????
      function load_poster(){
         var url2 ="moviePosterLoad";
         var param2 = "";
         sendRequest( url2, param2 , resultFnPos, "GET");
      }
      
      function resultFnPos(){            
         if( xhr.readyState == 4 && xhr.status == 200 ){
            var data = xhr.responseText;
            var json = eval(data);
            
            outer : for( var i = 0; i < json.length ; i++){
               var jsonLoadMovieNm = json[i].movieNm.trim();
               var jsonLoadPoster=json[i].posterNm;
               var jsonLoadTrailer=json[i].trailerSrc;
               for(var j = 0; j < 10 ; j++){
                   if( jsonLoadMovieNm == document.getElementById("movie_movieNm_"+j).value.trim() ){
                      document.getElementById("movie_rank_poster_"+j+"_img").src=jsonLoadPoster;
                      document.getElementById("movie_trailer_src_"+j).value=jsonLoadTrailer;
                      continue outer;
                   }               
               }
            }
         }
      }
      
      function detailRank( releaseDts, title ){
         return location.href="movieInfoDetailRank?releaseDts="+releaseDts+"&title="+encodeURIComponent(title)+"&trailer="+trailer;
      }
      //---------------------query---------------------------------------------------
      //?????? ??????
      function setCookie(cookie_name, value, days) {
         var exdate = new Date();
         exdate.setDate(exdate.getDate() + days);
         
         var cookie_value = escape(value) + ((days == null) ? '' : '; expires=' + exdate.toUTCString());
         document.cookie = cookie_name + '=' + cookie_value;
      }
      //?????? ????????????
      function getCookie(cookie_name) {
         var x, y;
         var val = document.cookie.split(';');

         for (var i = 0; i < val.length; i++) {
            x = val[i].substr(0, val[i].indexOf('='));
            y = val[i].substr(val[i].indexOf('=') + 1);
            x = x.replace(/^\s+|\s+$/g, ''); // ?????? ?????? ?????? ????????????
            if (x == cookie_name) {
               return unescape(y); // unescape??? ????????? ??? ??? ??????
            }
         }
      }
      //????????????
      var deleteCookie = function(name) {
         document.cookie = name + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;';
      }
      
      //?????? ????????? ???????????????? ????????? ?????? ?????????
      function text_del(){
          var delText = document.getElementById("searchText");
          delText.removeChild( delText.children[0] );
      }
      
      //?????? ????????? ????????? ?????? Ajax?????????
      function load_Query( f ){
         var query = f.query.value.trim();
         var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
         var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&sort=prodYear,1&listCount=6&query='+query;
         sendRequest( url, param, resultFnQu, "GET" );
      }
      
      function load_Query2( query ){
         var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
         var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&sort=prodYear,1&listCount=6&query='+query;
         sendRequest( url, param, resultFnQu, "GET" );
      }
      
      function resultFnQu(){
         
         if( xhr.readyState == 4 && xhr.status == 200 ){
            var data = xhr.responseText;
            var json = eval("["+data+"]");      
            
            //?????? ??? ??????
            var gc0 = getCookie("id"+0);
            var gc1 = getCookie("id"+1);
            var gc2 = getCookie("id"+2);
            
            //?????? ?????? ??? ??????
            if( gc0 != undefined ){
               if(gc1 != undefined ){
                  setCookie("id"+2, gc1, '1');                  
               }
               setCookie("id"+1, gc0, '1');
            }
            setCookie("id"+0, json[0].Query, '1');
            document.cookie;
            record_query("id"+0, json[0].Query);
            
            //?????? ??????
            for(var i = 0; i < 3 ; i++){
               var st = getCookie("id"+i);
               if( st != undefined ){
                  document.getElementById("recent_query_data_"+i).value = st;
                  document.getElementById("recent_query_"+i).innerHTML = st;
                  document.getElementById("del_icon_"+i).style.display = "block";
               }
            } 

            for(var i=0 ; i<json[0].Data[0].Result.length ; i++){

                var moviePoster = cutPoster(json[0].Data[0].Result[i].posters);//json???????????? ????????? ?????? ???????????? ???????????? ?????? ????????? ???????????? ?????????
                var queryTitle = json[0].Data[0].Result[i].title;
                if( queryTitle == null ){
                	queryTitle = '???????????? ??????';
                }
                document.getElementById("movie_movieId_"+i).value=json[0].Data[0].Result[i].movieId;//?????? ??????1
                document.getElementById("movie_movieSeq_"+i).value=json[0].Data[0].Result[i].movieSeq;//?????? ??????2
                document.getElementById("movie_query_list_title_"+i).innerHTML=queryTitle;//?????? ??????
                var td = document.getElementById("movie_query_title_data_"+i);
                td.value=queryTitle;//?????? ??????
                document.getElementById("movie_query_list_poster_"+i+"_img").src=moviePoster;//?????????
                
                //???????????? ??????
                var releaseYq = json[0].Data[0].Result[i].repRlsDate.substring(0,4);
                var releaseMq = json[0].Data[0].Result[i].repRlsDate.substring(4,6);
                var releaseDq = json[0].Data[0].Result[i].repRlsDate.substring(6,8);
                var releaseDateq = releaseYq+"."+releaseMq+"."+releaseDq+" ??????";
                if(releaseDq=="00"){
                   releaseDateq =  releaseYq+"."+releaseMq+". ??????";
                }
                
                document.getElementById("movie_query_list_relDate_"+i).innerHTML=releaseDateq;//?????????
                document.getElementById("movie_query_list_runtime_"+i).innerHTML=json[0].Data[0].Result[i].runtime+"???";//????????????
            }
            
            document.getElementById("question_box").style.top="20px";
            
            for(var i = 0 ; i <json[0].Data[0].Result.length; i++ ){
               document.getElementById("result_inv_movie_"+i).style.display="block";
            }

            text_del();//????????? ?????????
         }
      }
      
      //?????? ?????? ??????
      function recent_del( i ){
         deleteCookie("id"+i);
         setCookie("check", "yes", '1');
         //????????????
         location.reload(true);
         location.href = location.href;
         history.go(0);
         
      }
      
      //DB??? ???????????? ??????
      function record_query( userId, queryContent ){
         var url3 ="movieQueryRecord.do";
         var param3 = "userId="+userId+"&queryContent="+queryContent;/* userId??? SessionId??? ????????????*/
         sendRequest( url3, param3 , resultFnRec, "GET");
      }
      function resultFnRec(){
         if( xhr.readyState == 4 && xhr.status == 200 ){

         }   
      }
      
      //????????? ?????? ??????
      function inputEnter(f){
         if(event.keyCode == 13){
            load_Query( f );
         }
      }

   </script> 
</head>
<body>
  
    <div id="container">
		<div id="container_inner" >
			<div id="page_title">?????? ??????</div>
      
      <div id="movie_list_nav">
         <div class="movie_list_nav1"><a href="javascript:void(0);" onclick="boxOfficeView();">???????????????</a></div><!-- /movie/movieRankList -->
         <div class="movie_list_nav2"><a href="javascript:void(0);" onclick="scheduledScreenView();">?????? ?????????</a></div><!-- /movie/movieReleaseList-->
         <div class="movie_list_nav3"><a href="javascript:void(0);" onclick="queryMovie();">?????? ??????</a></div><!-- /movie/movieQuery -->
      </div>
      
      
<!--    ???????????????    -->

      <div id="contents_release">
         <div id="movie_chart_release">
            <div id="select_movie_lists_release">
               <c:forEach var="n" begin="0" end="7" step="1">
                  <div id="movie_release_list_${n}">
                     <input type="hidden" id="movie_release_movieId_${n}">
                     <input type="hidden" id="movie_release_movieSeq_${n}">
                     <input type="hidden" id="movie_release_title_data_${n}">
                     
                     
                     <div id="movie_release_poster_${n}">
                        <div class="poster_box">
                           <img id="movie_release_poster_${n}_img">
                           <div class="poster_hover">
                              <div class="poster_hover_text">
                                 <div class="poster_hover_text_2"><div id="movie_action_button_text_${n}"></div></div>      
                                 <div class="poster_hover_text_1"><a href="javascript:void(0);" onclick="detail(movie_release_movieId_${n}.value, movie_release_movieSeq_${n}.value, movie_release_title_data_${n}.value);">????????????</a></div>
                              </div>
                           </div>
                        </div>
                     </div>
                     
                     <div class="movie_title_box">
                        <div id="movie_release_title_${n}"></div>
                     </div>  
                     
                     <div class="movie_infos">
                     	<div class="movie_release_rel">
	                        <div id="movie_release_relDate_${n}"></div>
                     	</div>
                        <div id="movie_release_runtime_${n}"></div>
                     </div>
                     
                  </div>
               </c:forEach>
            </div>
            
            <div id="select_movie_lists_release_2">
               <c:forEach var="n" begin="8" end="15" step="1">
                  <div id="movie_release_list_${n}">
                     <input type="hidden" id="movie_release_movieId_${n}">
                     <input type="hidden" id="movie_release_movieSeq_${n}">
                     <input type="hidden" id="movie_release_title_data_${n}">
                     
                     <div id="movie_release_poster_${n}">
                        <div class="poster_box">
                           <img id="movie_release_poster_${n}_img">
                           <div class="poster_hover">
                              <div class="poster_hover_text">
                                 <div class="poster_hover_text_1"><a href="javascript:void(0);" onclick="detail(movie_release_movieId_${n}.value, movie_release_movieSeq_${n}.value, movie_release_title_data_${n}.value);">????????????</a></div>
                              </div>
                           </div>
                        </div>
                     </div>
                     
                     <div class="movie_title_box">
                        <div id="movie_release_title_${n}"></div> 
                     </div>
                     
                     <div class="movie_infos">
                     	<div class="movie_release_rel">
	                        <div id="movie_release_relDate_${n}"></div>
                     	</div>
                        <div id="movie_release_runtime_${n}"></div>
                     </div>

                  </div>
               </c:forEach>
            </div>
            
            <div id="select_movie_lists_release_3">
               <c:forEach var="n" begin="16" end="23" step="1">
                  <div id="movie_release_list_${n}">
                     <input type="hidden" id="movie_release_movieId_${n}">
                     <input type="hidden" id="movie_release_movieSeq_${n}">
                     <input type="hidden" id="movie_release_title_data_${n}">
                     
                     <div id="movie_release_poster_${n}">
                        <div class="poster_box">
                           <img id="movie_release_poster_${n}_img">
                           <div class="poster_hover">
                              <div class="poster_hover_text">
                                 <div class="poster_hover_text_1"><a href="javascript:void(0);" onclick="detail(movie_release_movieId_${n}.value, movie_release_movieSeq_${n}.value,  movie_release_title_data_${n}.value);">????????????</a></div>
                              </div>
                           </div>
                        </div>
                     </div>
                     
                     <div class="movie_title_box">
                        <div id="movie_release_title_${n}"></div>
                     </div>
                     
                     <div class="movie_infos">
                     	<div class="movie_release_rel">
	                        <div id="movie_release_relDate_${n}"></div>
                     	</div>
                        <div id="movie_release_runtime_${n}"></div>
                     </div>

                  </div>
               </c:forEach>
            </div>
            
            <div id="select_movie_lists_release_4">
               <c:forEach var="n" begin="24" end="31" step="1">
                  <div id="movie_release_list_${n}">
                     <input type="hidden" id="movie_release_movieId_${n}">
                     <input type="hidden" id="movie_release_movieSeq_${n}">
                     <input type="hidden" id="movie_release_title_data_${n}">
                     <div id="movie_release_poster_${n}">
                        <div class="poster_box">
                           <img id="movie_release_poster_${n}_img">
                           <div class="poster_hover">
                              <div class="poster_hover_text">
                                 <div class="poster_hover_text_1"><a href="javascript:void(0);" onclick="detail(movie_release_movieId_${n}.value, movie_release_movieSeq_${n}.value,  movie_release_title_data_${n}.value);">????????????</a></div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="movie_title_box">
                        <div id="movie_release_title_${n}"></div>
                     </div>
                     <div class="movie_infos">
                     	<div class="movie_release_rel">
	                        <div id="movie_release_relDate_${n}"></div>
                     	</div>
                        <div id="movie_release_runtime_${n}"></div>
                     </div>

                  </div>
               </c:forEach>
            </div>
            
            <div id="movie_release_list_moreSee">
            	<!-- <input type="button" value="?????????" onclick="more_list();"> -->
             	<button class="btn-1" onclick="more_list();">see more</button>
            </div>
         </div>
      </div>
<!-- ??????????????? ???       -->


<!-- ?????? ????????? -->

      <div id="contents_rank">
         <div id="select_movie_list">
            <ul id="movie_list">
               <c:forEach var="n" begin="0" end="5" step="1">
 <!-- 	1???	 -->
               <c:choose>
	           	<c:when test="${n eq 0 }">
                  <li id="movie_list_${n}">
                     <div id="movie_rank_box_one">
                        <input type="hidden" id="movie_openDt_${n}">
						<input type="hidden" id="movie_movieNm_${n}">
						<input type="hidden" id="movie_trailer_src_${n}">
						<input type="hidden" id="ticket${n}" >  
                        <div id="movie_rank_poster_${n}">
                          <div class="poster_box">
							<img id="movie_rank_poster_${n}_img" src="http://file.koreafilm.or.kr/poster/99/17/80/DPF025823_01.jpg" >
                           </div>
                        </div>
                        <div class="movie_title_box">
                        <div>
	                        <div style="width:60px; float:left;" id="movie_rank_rank_${n}"></div>
	                        <img style="width:25px; height:32px;" src="${ pageContext.request.contextPath }/resources/img/maedal_one.png"><br>
                        </div>
                           <div id="movie_rank_movieNm_${n}"></div>
                        </div>
                        <div class="movie_rank_infos">
                           <div id="movie_rank_salesShare_${n}"></div>
                           <div id="movie_rank_audiAcc_${n}"></div>
                        </div>
                        <input type="hidden" id="movie_rank_openDt_${n}">
                        <input type="hidden" id="movie_trailer_src_${n}">
                     </div>
                 	 </li>
                   </c:when>
                </c:choose>
  <!--     2  ??? -->             
                <c:choose>
	           	<c:when test="${n eq 1 }">
                  <li id="movie_list_${n}">
                     <div id="movie_rank_box_one">
                        <input type="hidden" id="movie_openDt_${n}">
                        <input type="hidden" id="movie_movieNm_${n}">
                        <div id="movie_rank_poster_${n}">
                           <div class="poster_box">
                              <img id="movie_rank_poster_${n}_img" src="http://file.koreafilm.or.kr/poster/99/17/95/DPK020222_01.jpg" >
                              <div class="poster_hover">
                                 <div class="poster_hover_text">
                                   <input type="hidden" id="ticket${n}" >   
			                    </div>
                              </div>
                           </div>
                        </div>
                        <div class="movie_title_box">
                        <div>
	                        <div style="width:60px; float:left;" id="movie_rank_rank_${n}"></div>
	                        <img style="width:25px; height:32px;" src="${ pageContext.request.contextPath }/resources/img/maedal_two.png"><br>
                        </div>
                           <div id="movie_rank_movieNm_${n}"></div>
                        </div>
                        
                        <div class="movie_rank_infos">
                           <div id="movie_rank_salesShare_${n}"></div>
                           <div id="movie_rank_audiAcc_${n}"></div>
                        </div>
                        <input type="hidden" id="movie_rank_openDt_${n}">
                        <input type="hidden" id="movie_trailer_src_${n}">
                     </div>
                 	 </li>
                   </c:when>
                </c:choose>
 <!--     3  ??? -->             
                <c:choose>
	           	<c:when test="${n eq 2 }">
                  <li id="movie_list_${n}">
                     <div id="movie_rank_box_one">
                        <input type="hidden" id="movie_openDt_${n}">
                        <input type="hidden" id="movie_movieNm_${n}">
                        <div id="movie_rank_poster_${n}">
                           <div class="poster_box">
                              <img id="movie_rank_poster_${n}_img" src="http://file.koreafilm.or.kr/poster/99/17/90/DPF026474_01.jpg" >
												 <div class="poster_hover">
                                 <div class="poster_hover_text">
                                   <input type="hidden" id="ticket${n}" >   
			                    </div>
                              </div>
                           </div>
                        </div>
                        <div class="movie_title_box">
                        <div>
	                        <div style="width:60px; float:left;" id="movie_rank_rank_${n}"></div>
	                        <img style="width:25px; height:32px;" src="${ pageContext.request.contextPath }/resources/img/maedal_three.png"><br>
                        </div>
                           <div id="movie_rank_movieNm_${n}"></div>
                        </div>
                        
                        <div class="movie_rank_infos">
                           <div id="movie_rank_salesShare_${n}"></div>
                           <div id="movie_rank_audiAcc_${n}"></div>
                        </div>
                        <input type="hidden" id="movie_rank_openDt_${n}">
                        <input type="hidden" id="movie_trailer_src_${n}">
                     </div>
                 	 </li>
                   </c:when>
                </c:choose>              
  <!--     4  ??? -->             
                <c:choose>
	           	<c:when test="${n eq 3 }">
                  <li id="movie_list_${n}">
                     <div id="movie_rank_box_one">
                        <input type="hidden" id="movie_openDt_${n}">
                        <input type="hidden" id="movie_movieNm_${n}">
                        <div id="movie_rank_poster_${n}">
                           <div class="poster_box">
                               <img id="movie_rank_poster_${n}_img" src="http://file.koreafilm.or.kr/poster/99/17/97/DPF026871_01.jpg" >
							   <div class="poster_hover">
                                 <div class="poster_hover_text">
                                   <input type="hidden" id="ticket${n}" >   
			                    </div>
                              </div>
                           </div>
                        </div>
                        <div class="movie_title_box">
                        <div>
	                        <div style="width:60px; float:left;" id="movie_rank_rank_${n}"></div>
                        </div><br>
                           <div id="movie_rank_movieNm_${n}"></div>
                        </div>
                        
                        <div class="movie_rank_infos">
                           <div id="movie_rank_salesShare_${n}"></div>
                           <div id="movie_rank_audiAcc_${n}"></div>
                        </div>
                        <input type="hidden" id="movie_rank_openDt_${n}">
                        <input type="hidden" id="movie_trailer_src_${n}">
                     </div>
                 	 </li>
                   </c:when>
                </c:choose>             
  <!--     5  ??? -->             
                <c:choose>
	           	<c:when test="${n eq 4 }">
                  <li id="movie_list_${n}">
                     <div id="movie_rank_box_one">
                        <input type="hidden" id="movie_openDt_${n}">
                        <input type="hidden" id="movie_movieNm_${n}">
                        <div id="movie_rank_poster_${n}">
                           <div class="poster_box">
                              <img id="movie_rank_poster_${n}_img" src="http://file.koreafilm.or.kr/poster/99/17/98/DPA001705_01.jpg" >
                              <div class="poster_hover">
                                 <div class="poster_hover_text">
                                   <input type="hidden" id="ticket${n}" >   
			                    </div>
                              </div>
                           </div>
                        </div>
                        <div class="movie_title_box">
                        <div>
	                        <div style="width:60px; float:left;" id="movie_rank_rank_${n}"></div>
                        </div><br>
                           <div id="movie_rank_movieNm_${n}"></div>
                        </div>
                        
                        <div class="movie_rank_infos">
                           <div id="movie_rank_salesShare_${n}"></div>
                           <div id="movie_rank_audiAcc_${n}"></div>
                        </div>
                        <input type="hidden" id="movie_rank_openDt_${n}">
                        <input type="hidden" id="movie_trailer_src_${n}">
                     </div>
                 	 </li>
                   </c:when>
                </c:choose>             
    <!--     6  ??? -->             
                <c:choose>
	           	<c:when test="${n eq 5 }">
                  <li id="movie_list_${n}">
                     <div id="movie_rank_box_one">
                        <input type="hidden" id="movie_openDt_${n}">
                        <input type="hidden" id="movie_movieNm_${n}">
                        <div id="movie_rank_poster_${n}">
                           <div class="poster_box">
                              <img id="movie_rank_poster_${n}_img" src="http://file.koreafilm.or.kr/poster/99/17/96/DPK020250_01.jpg" >
                             	<div class="poster_hover">
                                 <div class="poster_hover_text">
                                   <input type="hidden" id="ticket${n}" >   
			                    </div>
                              </div>
                           </div>
                        </div>
                        <div class="movie_title_box">
                        <div>
	                        <div style="width:60px; float:left;" id="movie_rank_rank_${n}"></div>
                        </div><br>
                           <div id="movie_rank_movieNm_${n}"></div>
                        </div>
                        <div class="movie_rank_infos">
                           <div id="movie_rank_salesShare_${n}"></div>
                           <div id="movie_rank_audiAcc_${n}"></div>
                        </div>
                        <input type="hidden" id="movie_rank_openDt_${n}">
                        <input type="hidden" id="movie_trailer_src_${n}">
                     </div>
                 	 </li>
                   </c:when>
                </c:choose>           
               </c:forEach>
            </ul>
         </div>
      </div>

      
      
<!--    ??????????????? ???    -->
      
      
      
<!--   ????????????     -->
      <div id="contents_query">
         
         <div id="question_box" style="z-index:3;">
               <div id="recent_query_box">
                  <div id="recent_query_title">?????? ????????? : </div>
                  <c:forEach var="i" begin="0" end="2" step="1">
                     <div id="recent_querys">
                        <form>
                           <input id="recent_query_data_${i}" value="" type="hidden">
                           <a id="recent_query_${i}" href="javascript:void(0);" onclick="load_Query2(recent_query_data_${i}.value);"></a>
                           <div id="del_img_box">
                              <img id="del_icon_${i}" onclick="recent_del(${i});" style="width:20px" src="${ pageContext.request.contextPath }/resources/img/iconDelwhite.png">
                           </div>
                        </form>
                        
                     </div>
                  </c:forEach>
               </div>
            
            <div id="query_input_box">
               <form id="search_form" name="searchForm" onsubmit="return false;" method="post">
                  <div id="query_widnow">
                     <img id="query_icon" src="${ pageContext.request.contextPath }/resources/img/queryicon.png">
                     <input name="query" id="query" autocomplete="off" onkeypress="inputEnter(this.form);" style="border:none; color:black;'">
                     <input id="btn" type="button" value="??????" onclick="load_Query(this.form);">
                  </div>
                  
                  <div id="searchText"><h3>?????? ????????? ???????????????? </h3></div>
               </form>
            </div>
         </div>
         
         <div id="movie_query_list_container">
            <ul id="movie_query_list">
               <c:forEach var="n" begin="0" end="9" step="1">
                  <li id="movie_query_list_${n}">
                     
                     <div id="result_inv_movie_${n}">
                        <div id="movie_query_box_one">
                           <div class="movie_query_result_box_${n}">
                              <input type="hidden" id="movie_movieId_${n}">
                              <input type="hidden" id="movie_movieSeq_${n}">
                              <input type="hidden" id="movie_query_title_data_${n}">
                              
                              <div id="movie_query_list_title_${n}"></div>
                              <div id="movie_query_list_poster_${n}">
                                 <div class="poster_box"> 
                                    <img id="movie_query_list_poster_${n}_img">
                                    <div class="poster_hover">
                                       <div class="poster_hover_text">   
                                          <div class="poster_hover_text_3"><a href="javascript:void(0);" onclick="detail(movie_movieId_${n}.value, movie_movieSeq_${n}.value, movie_query_title_data_${n}.value);">????????????</a></div>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                              
                              <div class="movie_query_rel_run">
                                  <div class="movie_query_rel">
		                              <div id="movie_query_list_relDate_${n}"></div>
                                  </div>
	                              <div id="movie_query_list_runtime_${n}"></div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </li>
               </c:forEach>
            </ul>
         </div>
      	</div>
      	
      	
<!--       	??????????????? -->

      </div>
   </div>
   
</body>
</html>