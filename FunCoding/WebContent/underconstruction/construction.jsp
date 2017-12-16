<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!-- 뒤로가기 했을때 로그인 정보값 없애기 위해서 -->
<% 
	response.setHeader ("Pragma", "No-cache"); 
	response.setDateHeader ("Expires", 0); 
	response.setHeader ("Cache-Control", "no-store"); 
%> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<meta http-equiv="Cache-Control" content="No-Store"> 
<meta http-equiv="pragma" content="No-cache"> 
<meta http-equiv="expires" content="0"> 

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="../js/jquery-3.2.1.js"></script>

<link href="../css/default.css" rel="stylesheet" type="text/css" media="all">

<script type="text/javascript" src="../js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="../js/s3Slider.js"></script>

<style type="text/css">
			
	#characterImg {
		background-image: url("consimages/FuDingFinal.png");
		background-repeat: no-repeat;
		width: 300px;
		height: 220px;
		background-size: 8cm;
		margin: 0 auto;
	}

	#hammerDiv {
		width: 330px;
		height: 280px;
		margin: 0 auto;
	}

	#textImgDiv {
		width: 300px;
		height: 100px;
		margin: 0 auto;
	}
	.text1{
		color : blue;
		font-size: 15pt;
	}
	.text2{
		font-size: 13pt;
	}
	.text3{
		color : red;
		font-size: 20pt;
		font-weight: bold;
	}
	
</style>

</head>
<body>

<div id="wrap">

<div class="clear"></div>
<jsp:include page="/member/loginfo.jsp" />

<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>

<!-- 아이콘 보드 만들어서 다른 페이지도 삽인할수 있게 할것 -->
<jsp:include page="../inc/iconBoard.jsp" />

<div class="clear"></div>
	<a href="../member/index.jsp">
		<div id="characterImg"></div>
	</a>
	<div id="text" align="center">
		<span class="text1">반갑습니다. 재미있는 코딩 </span><span class="text3">Fu</span><span class="text2">n co</span>
		<span class="text3">Ding, FuDing</span> <span class="text1">입니다.</span> <br/><br/>
		
		<span class="text1">푸딩 처럼 달콤하고 중독성있는 코딩이야기 곧 시작합니다.</span> <br/><br/>
		
		<span class="text1">Coming Soon!!</span>
	</div>
	
	<div id="hammerDiv" >
		<img src="consimages/hammer_1.png" id="hammerImg"/>
	</div>
	
	<div id="textImgDiv" >
		<img src="consimages/readyToOpen_1.png" id="readyToOpenImg"/>
	</div>
	
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/footer.jsp" />
<!-- 푸터 들어가는 곳 -->
</div>
</body>

<script type="text/javascript">
	
	var count = 1;

	function forceRotate(){

		document.getElementById("hammerImg").src = "consimages/hammer_" + count + ".png"
		document.getElementById("readyToOpenImg").src = "consimages/readyToOpen_" + count + ".png" 
		
		if (count == 1) {
			IsChange = true;
		} else if (count == 4) {
			IsChange = false;
		}
		
		if (IsChange){
			count++;
		} else {
			count--;
		}
		
	}
	
	setInterval("forceRotate();", 100);	
	
</script>

</html>