<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>

	<head>
		<title>GURUME365</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="<c:url value="/resources/css/main.css"/>">
		<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/jquery.scrolly.min.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/jquery.scrollex.min.js"/>"></script>
		<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false&key=AIzaSyAD_AQLECL4Gnp6L3gYZzFz8litKmsVZt8"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/skel.min.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/util.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/main.js"/>"></script>
		
		<script type="text/javascript">
			var stmnLEFT = 10;//오른쪽여백
			var stmnGAP1 = 0;//위쪽 여백
			var stmnGAP2 = 150;//스크롤시 브라우저 위쪽과 떨어지는 거리
			var stmnBASE = 150;//스크롤 시작위치
			var stmnActivateSpeed = 35;//스크롤을 인식하는 딜레이(숫자 클수록 느림)
			var stmnScrollSpeed = 20;//스크롤 속도(클수록 느림)
			var stmnTimer;
			
			function RefreshStaticMenu() {
				var stmnStartPoint,stmnEndPoint;
				stmnStartPoint = parseInt(document.getElementById('STATICMENU').style.top, 10);
				stmnEndPoint = Math.max(document.documentElement.scrollTop, document.body.scrollTop)+stmnGAP2;
				if (stmnEndPoint < stmnGAP1) stmnEndPoint = stmnGAP;
				if (stmnStartPoint != stmnEndPoint) {
					stmnScrollAmount = Math.ceil(Math.abs(stmnEndPoint - stmnStartPoint)/15);
					document.getElementById('STATICMENU').style.top = parseInt(document.getElementById('STATICMENU').style.top,10)+((stmnEndPoint < stmnStartPoint)?-stmnScrollAmount : stmnScrollAmount)+'px';
					stmnRefreshTimer = stmnScrollSpeed;
				}
				stmnTimer = setTimeout("RefreshStaticMenu();",stmnActivateSpeed);
			}
			function InitializeStaticMenu() {
				document.getElementById('STATICMENU').style.right = stmnLEFT + 'px';
				document.getElementById('STATICMENU').style.top = document.body.scrollTop + stmnBASE + 'px';
				RefreshStaticMenu();
			}		
			function current_address(){
				if(navigator.geolocation){
					navigator.geolocation.getCurrentPosition(function(pos){
						
						GoogleMap.initialize(pos.coords.latitude, pos.coords.longitude);
					},function(e){
						console.log({
							0: '현재 위치 정보가 올바르지 않습니다.(msg:'+e.message+')',
							1: '현재 페이지에서 사용자가 위치 정보 검색을 거부하였습니다',
							2: '브라우저가 위치 정보를 검색하지 못했습니다.(msg:'+e.message+')',
							3: '브라우저의 위치 정보 검색 시간이 초과되었습니다.'	
						}[e.code]);
						
					},{
						enableHeighAccuracy:true,
						timeout:30000,
						maximumAge: 0
					});	
				}
				GoogleMap={
					initialize: function(latitude, longitude){
						var geocoder=new google.maps.Geocoder();
						geocoder.geocode({'latLng':new google.maps.LatLng(latitude,longitude)},
					function(results,status){
						if(status==google.maps.GeocoderStatus.OK){
							console.log(results);
							alert('당신의 위치는 현재'+results[2].formatted_address+'입니다.');
						}	
					}			
						);
					}				
				}			
			}
		</script>
	</head>

	
	<body onload="InitializeStaticMenu();">
		<!-- Banner -->
		<div id="STATICMENU">
			<!-- 배너 코드 -->
		</div>

		<!-- Header -->
			<header id="header" class="alt">
				<a href="<c:url value=""/>">홈으로</a>
				<a href="<c:url value="/join/joinPermission" />">회원가입</a>
				<a href="<c:url value="/login/loginForm" />">로그인</a>
				<a href="<c:url value="/logout" />">Logout</a>
				<a href="#menu">Menu</a>
			</header>
		<!-- Nav -->
			<nav id="menu">
				<ul class="links">
					<li><a href="">Home</a></li>
					<li><a href="<c:url value="/join/joinPermission" />">Join</a></li>
					<li><a href="<c:url value="/login/loginForm" />">Login</a></li>
					<li><a href="<c:url value="/join/joinInfoPage"/>">Info</a></li>
					<li><a href="<c:url value="/join/companyInfo" />">Company</a></li>
					<li><a href="<c:url value="/floor/floor_edit" />">floor-edit</a></li>
				</ul>
			</nav>

		<!-- Banner -->
			<section id="banner">
				<div class="inner">
					<header>
						<h1>GURUME 365</h1>
						<p>당신의 미식(美食)을 책임집니다!</p>
					</header>
					<a href="#main" class="button big scrolly">시작하기</a>
				</div>
			</section>

		<!-- Main -->
			<div id="main">

				<!-- Section -->
					<section class="wrapper style1">
						<div class="inner">
							<header class="align-center">
								<div style=" display:inline-block;">
								<input type="text" style="float: left" id="searchAddress">
								<button id="current_address" onclick="current_address();">◎</button><button>검색</button>
								</div>
								<br><br><br><br>
								<p>지금 가게를 확인하세요!</p>
							</header>
							<div class="flex flex-3">
								<div class="col align-center">
									<div class="image round fit">
										<a href=""><img src="<c:url value="/resources/img/1.jpg"/>" alt="" /></a>
									</div>
									<p>가게설명1</p>
									<a href="#" class="button">Learn More</a>
								</div>
								<div class="col align-center">
									<div class="image round fit">
										<a href=""><img src="<c:url value="/resources/img/1.jpg"/>" alt="" /></a>
									</div>
									<p>가게설명2</p>
									<a href="#" class="button">Learn More</a>
								</div>
								<div class="col align-center">
									<div class="image round fit">
										<a href=""><img src="<c:url value="/resources/img/1.jpg"/>" alt="" /></a>
									</div>
									<p>가게설명3</p>
									<a href="#" class="button">Learn More</a>
								</div>
							</div>
						</div>
					</section>

			</div>

		<!-- Footer -->
			<footer id="footer">
				<div class="copyright">
					<ul class="icons">
						<li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
						<li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
						<li><a href="#" class="icon fa-instagram"><span class="label">Instagram</span></a></li>
						<li><a href="#" class="icon fa-snapchat"><span class="label">Snapchat</span></a></li>
					</ul>
					<p>&copy; GURUME365. All rights reserved.</p>
				</div>
			</footer>

		<!-- Scripts -->
			






<!--  
<h1>Home!</h1>

<sec:authorize access="isAnonymous()">
<p><a href="<c:url value="/login/loginForm" />">로그인</a></p>
<p><a href="<c:url value="/join/joinPermission" />">회원가입</a></p>
</sec:authorize>
<sec:authorize access="isAuthenticated()">
<form:form action="${pageContext.request.contextPath}/logout" method="POST">
    <input type="submit" value="로그아웃" />
</form:form>
</sec:authorize>
<h3>
    [<a href="<c:url value="/intro/introduction" />">소개 페이지</a>]
    [<a href="<c:url value="/admin/adminHome" />">관리자 홈</a>]
</h3>
-->
</body>
</html>
