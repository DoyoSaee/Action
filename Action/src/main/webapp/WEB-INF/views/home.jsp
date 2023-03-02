<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<!-- 모바일 유효 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="utf-8">

<title>Project</title>
<script>
window.onload=function(){
	load_boxOff_list();

    //저장되있는 쿠키 출력
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
 
 //날짜 생성 
 var date = new Date();
 var today = loadDate()-1; //1일에 문제될수있음 해결법 찾지 못함
 var releaseStart = releaseDtStart();
 var releaseEnd = releaseDtEnd();

//------------------rank----------------------------------------------------------

function loading_del(){
    var loadingText = document.getElementById("loadingText");
   if( loadingText.children[0] != undefined ){
      loadingText.removeChild( loadingText.children[0] );                         
   }
}

//박스오피스 호출
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
         document.getElementById("movie_openDt_"+i).value=openDts;//영화 코드(영진위)
         document.getElementById("movie_movieNm_"+i).value=json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;//영화 제목에서 자르기(영진위)
          document.getElementById("movie_rank_movieNm_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;;//영화 제목
          document.getElementById("ticket"+i).href="ticketing.do?m_name="+json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;
          document.getElementById("movie_rank_rank_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].rank+" 위";//순위
          document.getElementById("movie_rank_salesShare_"+i).innerHTML="예매율 : "+json[0].boxOfficeResult.dailyBoxOfficeList[i].salesShare+" %";//예매율
          document.getElementById("movie_rank_audiAcc_"+i).innerHTML="누적관객수 : "+json[0].boxOfficeResult.dailyBoxOfficeList[i].audiAcc+"명";//누적관객수
          document.getElementById("movie_rank_openDt_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].openDt+"개봉";//개봉일
      }
      load_poster();
      loading_del();      
   }      
}

//박스오피스의  DB에서 포스터 가져오기
function load_poster(){
   var url2 ="moviePosterLoad.do";
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


function detailRank( releaseDts, title, trailer ){
   return location.href="movieInfoDetailRank.do?releaseDts="+releaseDts+"&title="+encodeURIComponent(title)+"&trailer="+trailer;
}


</script>
</head>
<body>


	<!-- Home Slider  -->
	<section id="home">
		<div id="home-carousel" class="carousel slide" data-interval="false">
			<ol class="carousel-indicators">
				<li data-target="#home-carousel" data-slide-to="0" class="active"></li>
				<li data-target="#home-carousel" data-slide-to="1"></li>
				<li data-target="#home-carousel" data-slide-to="2"></li>
			</ol>
			<!--/.carousel-indicators-->

			<div class="carousel-inner"
				style="height: 750px; width: 88%; margin: auto">

				<div class="item active"
					style="background: linear-gradient(to top, rgba(0, 0, 0, 0) 70%, rgba(0, 0, 0, 0.8) 90%, rgba(0, 0, 0, 1) 100%),
                                                                 linear-gradient(to bottom,rgba(0, 0, 0, 0) 70%,rgba(0, 0, 0, 1) 80%),
                                                                 url('${ pageContext.request.contextPath }/resources/img/slider/Action.jpg'); 
                                                                 background-size:auto;">
					<div class="carousel-caption">
						<div class="animated bounceInLeft">
							<h1>제목</h1>
							<br>
							<h2>소제목</h2>
							<p>1. 하루하루를 마지막이라고 생각하라. 그러면 예측할 수 없는 시간은 그대에게 더 많은 시간을 줄
								것이다.</p>
						</div>
					</div>
				</div>

				<div class="item"
					style="background: linear-gradient(to top, rgba(0, 0, 0, 0) 70%, 
                                                                                    rgba(0, 0, 0, 0.8) 90%, 
                                                                                    rgba(0, 0, 0, 1) 100%),
                                                                linear-gradient(to bottom,rgba(0, 0, 0, 0) 70%, 
                                                                                    rgba(215, 215, 215, 1) 80%, 
                                                                                    rgba(215, 215, 215, 1) 80%),
                                                                                    url('${ pageContext.request.contextPath }/resources/img/slider/Action.jpg');     
                                                                                    background-size:auto;">
					<div class="carousel-caption">
						<div class="animated bounceInLeft">
							<h1>제목</h1>
							<br>
							<h2>소제목</h2>
							<p>2. 꿈을 계속 간직하고 있으면 반드시 실현할 때가 온다</p>
						</div>
					</div>
				</div>

				<div class="item"
					style="background: linear-gradient(to top, rgba(0, 0, 0, 0) 70%, 
                                                                                rgba(0, 0, 0, 0.8) 90%, 
                                                                                rgba(0, 0, 0, 1) 100%),
                                                            linear-gradient(to bottom,rgba(0, 0, 0, 0) 70%, 
                                                                                rgba(215, 215, 215, 1) 80%, 
                                                                                rgba(215, 215, 215, 1) 80%),
                                                                                url('${ pageContext.request.contextPath }/resources/img/slider/Action.jpg');     
                                                                                background-size:auto;">
					<div class="carousel-caption">
						<div class="animated bounceInLeft">
							<h1>제목</h1>
							<br>
							<h2>소제목</h2>
							<p>3. 내일이란 오늘의 다른 이름일 뿐이다.</p>
						</div>
					</div>
				</div>
			</div>
			<!--/.carousel-inner-->
			<nav id="nav-arrows"
				class="nav-arrows hidden-xs hidden-sm visible-md visible-lg">
				<a class="sl-prev hidden-xs" href="#home-carousel" data-slide="prev">
					<i class="fa fa-angle-left fa-3x"></i>
				</a> <a class="sl-next" href="#home-carousel" data-slide="next"> <i
					class="fa fa-angle-right fa-3x"></i>
				</a>
			</nav>

		</div>
	</section>
	<!--  End #home Slider -->


	<!-- #2 -->
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<!--  #3 -->
	<section class="bg">
		<div class="container">
			<div class="row">

				<div class="section-title text-center wow fadeInUp">
					<h1>
						<strong>현재 상영작 BEST4</strong>
					</h1>
					<p>전국 영화관 통계입니다</p>

				</div>

				<div class="about-us text-center wow fadeInDown">
					<img
						src="${ pageContext.request.contextPath }/resources/img/about.png"
						alt="About Us" class="img-responsive">
				</div>
			</div>
		</div>

		<!-- End #3  -->

		<!--  #count -->

		<section id="count">
			<div class="container">
				<div class="row">


					<div class="counter-section clearfix">
						<ul id="movie_list">




							<c:forEach var="n" begin="0" end="2" step="1">
								<li id="movie_list_${n}">
									<div id="movie_rank_box_one">
										<input type="hidden" id="movie_openDt_${n}"> <input
											type="hidden" id="movie_movieNm_${n}"> <input
											type="hidden" id="ticket${n}">


										<div id="movie_rank_poster_${n}">
											<div class="poster_box">
												<img id="movie_rank_poster_${n}_img">
												<div class="poster_hover">
													<div class="poster_hover_text">
														<div class="poster_hover_text_1">
															<a href="javascript:void(0);"
																onclick="detailRank(movie_openDt_${n}.value, movie_movieNm_${n}.value, movie_trailer_src_${n}.value);">상세보기</a>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="col-md-6 col-sm-6 col-xs-12 wow fadeInLeft"
											data-wow-delay="0.5s">
											<div class="movie_title_box">
												<div>
													<c:choose>
														<c:when test="${n eq 0 }">
															<p style="width: 40px; float: left;"
																id="movie_rank_rank_${n}"></p>
															<img style="width: 25px; height: 32px;"
																src="${ pageContext.request.contextPath }/resources/img/maedal_one.png">
														</c:when>

														<c:when test="${n eq 1 }">
															<div style="width: 40px; float: left;"
																id="movie_rank_rank_${n}"></div>
															<img style="width: 25px; height: 32px;"
																src="${ pageContext.request.contextPath }/resources/img/maedal_two.png">
														</c:when>

														<c:when test="${n eq 2 }">
															<div style="width: 40px; float: left;"
																id="movie_rank_rank_${n}"></div>
															<img style="width: 25px; height: 32px;"
																src="${ pageContext.request.contextPath }/resources/img/maedal_three.png">
														</c:when>

														<c:otherwise>
															<div style="width: 40px; float: left;"
																id="movie_rank_rank_${n}"></div>
														</c:otherwise>
													</c:choose>
												</div>
											</div>
										</div>
										<br> <br> <br> <br>
										<div class="fact-item text-center">
											<span id="movie_rank_movieNm_${n}" style="font-size: 25px;"></span>
											<div class="movie_rank_infos">
												<div id="movie_rank_salesShare_${n}"></div>
												<div id="movie_rank_audiAcc_${n}"></div>
											</div>
											<input type="hidden" id="movie_rank_openDt_${n}"> <input
												type="hidden" id="movie_trailer_src_${n}">
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>


			</div>
		</section>
	</section>
	<!-- End #count  -->
	<br>
	<br>
	<br>
	<br>
	<br>
	<hr style="border: 0; height: 14px; background: #8b8b8b;">
	<br>
	<br>
	<section class="bg">
		<br>
		<section id="portfolio"
			style="width: 65%; height: 100%; margin: auto;">
			<br> <br> <br> <br> <br> <br> <br>
			<br>

			<div style="width: 100%; height: 1200px; margin: auto;">
				<div class="section-title text-center wow fadeInDown"
					style="margin-top: 0%; margin-bottom: -2%;">
					<h1 style="color: white;">
						<strong>장르 별 영화</strong>
					</h1>
					<p>겨울이 오면 봄이 멀지 않으리</p>
					<br> <br> <br>
				</div>
				<nav class="project-filter clearfix text-center wow fadeInLeft"
					data-wow-delay="0.4s">
					<ul class="list-inline">
						<li><a href="javascript:;" class="filter" data-filter="all">전체</a></li>
						<li><a href="javascript:;" class="filter" data-filter=".app">한국액션</a></li>
						<li><a href="javascript:;" class="filter"
							data-filter=".photography">외국액션</a></li>
						<li><a href="javascript:;" class="filter" data-filter=".web">다시보기</a></li>
						<li><a href="javascript:;" class="filter"
							data-filter=".print">로맨스</a></li>
					</ul>
				</nav>
				<div id="projects" class="clearfix">

					<figure class="mix portfolio-item app">
						<img class="img-responsive"
							src="${ pageContext.request.contextPath }/resources/img/portfolio/1.jpg"
							alt="Portfolio Item">
						<a
							href="${ pageContext.request.contextPath }/resources/img/portfolio/1.jpg"
							title="Title One" rel="portfolio" class="fancybox"><span
							class="plus"></span></a>
						<figcaption class="mask">
							<h3>범죄도시</h3>
							<span>Photography</span>
						</figcaption>
					</figure>

					<figure class="mix portfolio-item photography">
						<img class="img-responsive"
							src="${ pageContext.request.contextPath }/resources/img/portfolio/2.jpg"
							alt="Portfolio Item">
						<a
							href="${ pageContext.request.contextPath }/resources/img/portfolio/2.jpg"
							title="Title Two" rel="portfolio" class="fancybox"><span
							class="plus"></span></a>
						<figcaption class="mask">
							<h3>킬러의보디가드</h3>
							<span>Photography</span>
						</figcaption>
					</figure>

					<figure class="mix portfolio-item web">
						<img class="img-responsive"
							src="${ pageContext.request.contextPath }/resources/img/portfolio/3.jpg"
							alt="Portfolio Item">
						<a
							href="${ pageContext.request.contextPath }/resources/img/portfolio/3.jpg"
							title="Title Three" rel="portfolio" class="fancybox"><span
							class="plus"></span></a>
						<figcaption class="mask">
							<h3>킹스맨</h3>
							<span>Photography</span>
						</figcaption>
					</figure>

					<figure class="mix portfolio-item print">
						<img class="img-responsive"
							src="${ pageContext.request.contextPath }/resources/img/portfolio/4.jpeg"
							alt="Portfolio Item">
						<a
							href="${ pageContext.request.contextPath }/resources/img/portfolio/4.jpeg"
							title="Title Four" rel="portfolio" class="fancybox"><span
							class="plus"></span></a>
						<figcaption class="mask">
							<h3>비긴어게인</h3>
							<span>Photography</span>
						</figcaption>
					</figure>

					<figure class="mix portfolio-item app">
						<img class="img-responsive"
							src="${ pageContext.request.contextPath }/resources/img/portfolio/5.jpg"
							alt="Portfolio Item">
						<a
							href="${ pageContext.request.contextPath }/resources/img/portfolio/5.jpg"
							title="Title Five" rel="portfolio" class="fancybox"><span
							class="plus"></span></a>
						<figcaption class="mask">
							<h3>범죄도시2</h3>
							<span>Photography</span>
						</figcaption>
					</figure>

					<figure class="mix portfolio-item photography">
						<img class="img-responsive"
							src="${ pageContext.request.contextPath }/resources/img/portfolio/6.jpg"
							alt="Portfolio Item">
						<a
							href="${ pageContext.request.contextPath }/resources/img/portfolio/6.jpg"
							title="Title Six" rel="portfolio" class="fancybox"><span
							class="plus"></span></a>
						<figcaption class="mask">
							<h3>매드맥스</h3>
							<span>Photography</span>
						</figcaption>
					</figure>

					<figure class="mix portfolio-item web app">
						<img class="img-responsive"
							src="${ pageContext.request.contextPath }/resources/img/portfolio/7.jpg"
							alt="Portfolio Item">
						<a
							href="${ pageContext.request.contextPath }/resources/img/portfolio/7.jpg"
							title="Title Seven" rel="portfolio" class="fancybox"><span
							class="plus"></span></a>
						<figcaption class="mask">
							<h3>베테랑</h3>
							<span>Photography</span>
						</figcaption>
					</figure>

					<figure class="mix portfolio-item print web">
						<img class="img-responsive"
							src="${ pageContext.request.contextPath }/resources/img/portfolio/8.jpg"
							alt="Portfolio Item">
						<a
							href="${ pageContext.request.contextPath }/resources/img/portfolio/8.jpg"
							title="Title Eight" rel="portfolio" class="fancybox"><span
							class="plus"></span></a>
						<figcaption class="mask">
							<h3>어바웃타임</h3>
							<span>Photography</span>
						</figcaption>
					</figure>
				</div>
			</div>
		</section>
	</section>
	<!-- end #2 -->
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<!--  #4  -->
	<hr style="border: 0; height: 14px; background: #8b8b8b;">
	<br>
	<br>
	<br>
	<br>
	<section class="bg">
		<section id="pricing">
			<br> <br> <br> <br> <br> <br> <br>


			<div class="container">
				<div class="row">
					<div class="section-title text-center wow fadeInUp">

						<h1 style="color: black;">
							<strong>예매권</strong>
						</h1>
						<br>
						<p>좌석,요일에 따른 요금 변동이 있습니다.</p>
					</div>

					<div class="col-md-4 col-sm-7 col-xs-12 wow fadeInUp">
						<div class="pricing-table text-center">
							<div class="price">
								<span class="value"><strong>BASIC</strong></span> <span
									class="plan"><strong>2D</strong><strong>3D</strong></span>

							</div>
							<table class="tg">
								<thead>
									<tr>
										<td class="tg-yj5y">모닝<br>(10시 이전)
										</td>
										<td class="tg-c3ow">7,000원</td>
										<td class="tg-0lax">9,000원</td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="tg-yj5y">브런치<br>(10~13시)
										</td>
										<td class="tg-c3ow">8,000원</td>
										<td class="tg-0lax">10,000원</td>
									</tr>
									<tr>
										<td class="tg-yj5y">데이라이트<br>(13~16시)
										</td>
										<td class="tg-c3ow">9000원</td>
										<td class="tg-0lax">11,000원</td>
									</tr>
									<tr>
										<td class="tg-yj5y">프라임<br>(16~22시)
										</td>
										<td class="tg-c3ow">10,000원</td>
										<td class="tg-0lax">12,000원</td>
									</tr>
									<tr>
										<td class="tg-kftd">문라이트<br>(22~24시)
										</td>
										<td class="tg-0lax">9,000원</td>
										<td class="tg-0lax">11,000원</td>
									</tr>
									<tr>
										<td class="tg-yj5y">나이트<br>(24시 이후)
										</td>
										<td class="tg-c3ow">8,000원</td>
										<td class="tg-0lax">10,000원</td>
									</tr>
								</tbody>
							</table>
							<a href="#" class="btn btn-price">예매하기</a>
						</div>
					</div>

					<div class="col-md-4 col-sm-7 col-xs-12 wow fadeInUp"
						data-wow-delay="0.3s">
						<div class="pricing-table text-center">
							<div class="price">
								<span class="value"><strong>IMAX</strong></span> <span
									class="plan"><strong>2D</strong><strong>3D</strong></span>
							</div>
							<ul class="text-center">
								<li>모닝(10시 이전) 11,000원 14,000원</li>
								<li>브런치(10~13시) 13,000원 17,000원</li>
								<li>데이라이트(13~16시) 13,000원 17,000원</li>
								<li>프라임(16~22시) 14,000원 18,000원</li>
								<li>문라이트(22~24시) 14,000원 18,000원</li>
								<li>나이트(24시 이후) 12,000원 6,000원</li>
							</ul>
							<a href="#" class="btn btn-price">예매하기</a>
						</div>
					</div>

					<div class="col-md-4 col-sm-7 col-xs-12 wow fadeInUp"
						data-wow-delay="0.6s">
						<div class="pricing-table text-center">
							<div class="price">
								<span class="value"><strong>4DX</strong></span> <span
									class="plan"><strong>2D</strong><strong>3D</strong></span>
							</div>
							<ul class="text-center">
								<li>모닝(10시 이전) 10,000원 13,000원</li>
								<li>브런치(10~13시) 14,000원 18,000원</li>
								<li>데이라이트(13~16시) 14,000원 18,000원</li>
								<li>프라임(16~22시) 15,000원 19,000원</li>
								<li>문라이트(22~24시) 15,000원 19,000원</li>
								<li>나이트(24시 이후) 13000원 17000원</li>
							</ul>
							<a href="#" class="btn btn-price">예매하기</a>
						</div>
					</div>
				</div>
				<br>
				<div class="col-md-12 wow fadeInUp">
					<div class="special-plan text-center" style="margin-top: 0px;">
						<a href="#" class="btn btn-blue">자세히보기</a>
					</div>
				</div>
			</div>
		</section>
	</section>

	<!-- End #4  -->

	<hr style="border: 0; height: 14px; background: #8b8b8b;">

	<section class="bg">
		<!--  #1  -->
		<section id="service" style="margin-top: -6%;">
			<br> <br> <br> <br> <br> <br> <br>
			<br> <br> <br>
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="section-title text-center wow fadeInDown">
							<h1>스토어</h1>
							<p>5.마음만을 가지고 있어서는 안 된다. 반드시 실천하여야 한다.</p>

						</div>
					</div>
				</div>
				<div class="row">

					<div class="col-md-6 col-sm-12 wow fadeInLeft">
						<div class="media">
							<a href="#" class="pull-left"> <img
								src="${ pageContext.request.contextPath }/resources/img/icons/monitor.png"
								class="media-object" alt="Monitor">
							</a>
							<div class="media-body">
								<h3>Fontawesome.1</h3>
								<p>오늘이라는 날은 두 번 다시 오지 않는다는 것을 잊지 말라.</p>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-sm-12 wow fadeInRight"
						data-wow-delay="0.2s">
						<div class="media">
							<a href="#" class="pull-left"> <img
								src="${ pageContext.request.contextPath }/resources/img/icons/cog.png"
								alt="Cog">
							</a>
							<div class="media-body">
								<h3>Fontawesome.2</h3>
								<p>오늘이란 신어야 할 신발과 같은 것이다.</p>
							</div>
						</div>
					</div>

					<div class="col-md-6 col-sm-12 wow fadeInLeft">
						<div class="media">
							<a href="#" class="pull-left"> <img
								src="${ pageContext.request.contextPath }/resources/img/icons/ruler.png"
								alt="Ruler">
							</a>
							<div class="media-body">
								<h3>Fontawesome.3</h3>
								<p>건강에 대한 지나친 걱정만큼 건강에 치명적인 것은 없다.</p>
							</div>
						</div>
					</div>

					<div class="col-md-6 col-sm-12 wow fadeInRight"
						data-wow-delay="0.2s">
						<div class="media">
							<a href="#" class="pull-left"> <img
								src="${ pageContext.request.contextPath }/resources/img/icons/camera.png"
								alt="Camera">
							</a>
							<div class="media-body">
								<h3>Fontawesome.4</h3>
								<p>아침에 상쾌한 기분으로 일찍 일어나는 사람은 드물다. 대부분의 사람들은 그냥 일찍 일어날 뿐이다.</p>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-sm-12 wow fadeInLeft">
						<div class="media">
							<a href="#" class="pull-left"> <img
								src="${ pageContext.request.contextPath }/resources/img/icons/monitor.png"
								class="media-object" alt="Monitor">
							</a>
							<div class="media-body">
								<h3>Fontawesome.1</h3>
								<p>오늘이라는 날은 두 번 다시 오지 않는다는 것을 잊지 말라.</p>
							</div>
						</div>

					</div>

					<div class="col-md-6 col-sm-12 wow fadeInRight"
						data-wow-delay="0.2s">
						<div class="media">
							<a href="#" class="pull-left"> <img
								src="${ pageContext.request.contextPath }/resources/img/icons/cog.png"
								alt="Cog">
							</a>
							<div class="media-body">
								<h3>Fontawesome.2</h3>
								<p>오늘이란 신어야 할 신발과 같은 것이다.</p>
							</div>
						</div>

					</div>

					<div class="col-md-6 col-sm-12 wow fadeInLeft">
						<div class="media">
							<a href="#" class="pull-left"> <img
								src="${ pageContext.request.contextPath }/resources/img/icons/ruler.png"
								alt="Ruler">
							</a>
							<div class="media-body">
								<h3>Fontawesome.3</h3>
								<p>건강에 대한 지나친 걱정만큼 건강에 치명적인 것은 없다.</p>
							</div>
						</div>
					</div>

					<div class="col-md-6 col-sm-12 wow fadeInRight"
						data-wow-delay="0.2s">
						<div class="media">
							<a href="#" class="pull-left"> <img
								src="${ pageContext.request.contextPath }/resources/img/icons/camera.png"
								alt="Camera">
							</a>
							<div class="media-body">
								<h3>Fontawesome.4</h3>
								<p>아침에 상쾌한 기분으로 일찍 일어나는 사람은 드물다. 대부분의 사람들은 그냥 일찍 일어날 뿐이다.</p>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-sm-12 wow fadeInLeft">
						<div class="media">
							<a href="#" class="pull-left"> <img
								src="${ pageContext.request.contextPath }/resources/img/icons/monitor.png"
								class="media-object" alt="Monitor">
							</a>
							<div class="media-body">
								<h3>Fontawesome.1</h3>
								<p>오늘이라는 날은 두 번 다시 오지 않는다는 것을 잊지 말라.</p>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-sm-12 wow fadeInRight"
						data-wow-delay="0.2s">
						<div class="media">
							<a href="#" class="pull-left"> <img
								src="${ pageContext.request.contextPath }/resources/img/icons/cog.png"
								alt="Cog">
							</a>
							<div class="media-body">
								<h3>Fontawesome.2</h3>
								<p>오늘이란 신어야 할 신발과 같은 것이다.</p>
							</div>
						</div>
					</div>

					<div class="col-md-6 col-sm-12 wow fadeInLeft">
						<div class="media">
							<a href="#" class="pull-left"> <img
								src="${ pageContext.request.contextPath }/resources/img/icons/ruler.png"
								alt="Ruler">
							</a>
							<div class="media-body">
								<h3>Fontawesome.3</h3>
								<p>건강에 대한 지나친 걱정만큼 건강에 치명적인 것은 없다.</p>
							</div>
						</div>
					</div>

					<div class="col-md-6 col-sm-12 wow fadeInRight"
						data-wow-delay="0.2s">
						<div class="media">
							<a href="#" class="pull-left"> <img
								src="${ pageContext.request.contextPath }/resources/img/icons/camera.png"
								alt="Camera">
							</a>
							<div class="media-body">
								<h3>Fontawesome.4</h3>
								<p>아침에 상쾌한 기분으로 일찍 일어나는 사람은 드물다. 대부분의 사람들은 그냥 일찍 일어날 뿐이다.</p>
							</div>
						</div>
					</div>
				</div>

			</div>
		</section>
	</section>
	<!--  End #1 -->
	<hr style="border: 0; height: 14px; background: #8b8b8b;">
	<!-- #service-bottom  -->
	<br>
	<br>
	<section id="service-bottom" style="margin-top: 10%">

		<br> <br> <br> <br> <br> <br> <br>
		<br>
		<div class="container">
			<div class="mobile-device">
				<img data-wow-delay="0.2s"
					class="img-responsive black  wow fadeInLeftBig"
					src="${ pageContext.request.contextPath }/resources/img/icons/팝콘.png"
					alt="iPhone Black"> <img data-wow-delay="0.5s"
					class="img-responsive white  wow fadeInLeftBig"
					src="${ pageContext.request.contextPath }/resources/img/icons/배경.png"
					alt="iPhone White">
			</div>
			<div class="service-features wow fadeInRight">
				<h1>공지사항</h1>
				<ul>
					<li>내일은 내일의 태양이 뜬다</li>
					<li>피할수 없으면 즐겨라</li>
					<li>한번의 실패와 영원한 실패를 혼동하지 마라</li>
					<li>돈이란 바닷물과도 같다. 그것은 마시면 마실수록 목이 말라진다y</li>
				</ul>
			</div>
		</div>
	</section>
	<!-- End #service-bottom -->

	</section>
	
	<!--  End #Portfolio -->



	<!--  #about-us -->
	<section class="bg">
		<div class="container">
			<div class="row">
				<div class="col-md-5 col-md-offset-1 wow fadeInLeft">
					<div class="subtitle text-center">
						<h2>영화 리뷰어</h2>
						<p>관람객들의 실시간 반응</p>
					</div>
					<div id="testimonial">
						<div class="tst-item clearfix">
							<div class="tst-single clearfix">
								<img
									src="${ pageContext.request.contextPath }/resources/img/client/1.png"
									alt="Client" class="img-circle">
								<div class="tst-content">
									<p>사람이 적어서 쾌적하게 봤어요</p>
									<span>안녕하는 춘식이</span>
								</div>
							</div>

							<div class="tst-single clearfix">
								<img
									src="${ pageContext.request.contextPath }/resources/img/client/2.png"
									alt="Client" class="img-circle">
								<div class="tst-content">
									<p>이 집 팝콘 맛집이네</p>
									<span>잘먹은 춘식이</span>
								</div>
							</div>
						</div>

						<div class="tst-item">
							<div class="tst-single clearfix">
								<img
									src="${ pageContext.request.contextPath }/resources/img/client/3.png"
									alt="Client" class="img-circle">
								<div class="tst-content">
									<p>누가 영화관에서 회를 먹어요...</p>
									<span>우는 춘식이</span>
								</div>
							</div>
							<div class="tst-single clearfix">
								<img
									src="${ pageContext.request.contextPath }/resources/img/client/1.png"
									alt="Client" class="img-circle">
								<div class="tst-content">
									<p>아바타 : 물의길 보면서 먹는 회가 꿀맛...!</p>
									<span>활어회빌런 춘식이</span>
								</div>
							</div>
						</div>

						<div class="tst-item">
							<div class="tst-single clearfix">
								<img
									src="${ pageContext.request.contextPath }/resources/img/client/2.png"
									alt="Client" class="img-circle">
								<div class="tst-content">
									<p>왔노라 보았노라 먹었노라</p>
									<span>배부른 춘식이</span>
								</div>
							</div>
							<div class="tst-single clearfix">
								<img
									src="${ pageContext.request.contextPath }/resources/img/client/3.png"
									alt="Client" class="img-circle">
								<div class="tst-content">
									<p>치킨을 왜 먹냐구요...</p>
									<span>울부짖는 춘식이</span>
								</div>
							</div>
						</div>

					</div>
					<!-- end #testimonial -->
				</div>
				<!-- end .col-md-5 -->

				<div class="col-md-5 col-md-offset-1 wow fadeInRight">

					<div class="subtitle text-center">
						<h1>영화관 만족도 조사</h1>
						<p>영화별 만족도 조사입니다.</p>
					</div>

					<div class="progress-bars">

						<span>BASIC - <small>96%</small></span>
						<div class="progress" data-progress="95">
							<div class="bar"></div>
						</div>
						<span>IMAX - <small>97%</small></span>
						<div class="progress" data-progress="93">
							<div class="bar"></div>
						</div>
						<span>4DX - <small>98%</small></span>
						<div class="progress" data-progress="85">
							<div class="bar"></div>
						</div>
						<span>mySQL - <small>87%</small></span>
						<div class="progress kill-margin" data-progress="87">
							<div class="bar"></div>
						</div>

					</div>
					<!-- progress-bars -->

				</div>
				<!-- end .col-md-5 -->

			</div>
		</div>
	</section>
	<!-- End #about-us -->

	<!--  #quotes -->
	<section id="quotes">
		<div class="container">
			<div class="row wow zoomIn">
				<div class="col-lg-12">
					<div class="call-to-action text-center">
						<p>“관람시 불편했던 점...”</p>
						<span>추후 참고조치하겠습니다.</span>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End #quotes -->




	<!-- #subscribe  -->
	<section id="subscribe">
		<div class="container">
			<div class="row">

				<div class="col-md-7 wow fadeInLeft">
					<form action="#" method="post" class="subscription-form">
						<i class="fa fa-envelope-o fa-lg"></i> <input type="email"
							name="subscribe" class="subscribe" placeholder="YOUR MAIL"
							required=""> <input type="submit" value="SUBSCRIBE"
							id="mail-submit">
					</form>
				</div>

				<div class="col-md-4 text-left wow fadeInRight">
					<p>
						익명으로 남겨지는 이메일 입니다.<br>영화 관리실에 전달됩니다.
					</p>
				</div>
			</div>
		</div>
	</section>
	<!-- End #subscribe -->


	<!--  #5  -->
	<section class="bg">
		<div class="container">
			<div class="row">

				<div class="section-title text-center wow fadeInDown">
					<h1>시사회 신청란</h1>
				</div>

				<div class="col-md-12 col-sm-9 wow fadeInLeft">
					<div class="contact-form clearfix">
						<form action="index.html" method="post">
							<div class="input-field">
								<input type="text" class="form-control" name="name"
									placeholder="Your Name" required="">
							</div>
							<div class="input-field">
								<input type="email" class="form-control" name="email"
									placeholder="Your Email" required="">
							</div>
							<div class="input-field message">
								<textarea name="message" class="form-control"
									placeholder="Your Message" required></textarea>
							</div>
							<input type="submit" class="btn btn-blue pull-right"
								value="SEND MESSAGE" id="msg-submit">
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>

</body>
</html>
