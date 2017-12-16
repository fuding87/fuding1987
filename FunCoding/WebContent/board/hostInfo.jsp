<%@page import="member.MemDao"%>
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
<title>주인장 소개 페이지</title>

<link href="../css/default.css" rel="stylesheet" type="text/css" media="all">

<script type="text/javascript" src="../js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="../js/s3Slider.js"></script>

<script type="text/javascript">

$(document).ready(function() { 
   	$('#logoslider').s3Slider({ 
      	timeOut: 3000
 	}); 
});

function askResume(){
	document.resume.submit();
}
</script>

<style type="text/css">
	#imagejyh {
		border-radius: 10px;
		margin: 10px 10px 10px 10px;
		margin-top: -130px;
	}
	#borderBottomSet td{
/* 	    border-bottom-width: 1px;
	    border-bottom-style: dotted;
	    border-bottom-color: #999;
	    
	   	border-left-width: 1px;
	    border-left-style: dotted;
	    border-left-color: #999; */
	    
	    border-width: 1px;
	    border-style: dotted;
	    border-color: #999;
	}
	#mainTxt{
		height: 30px;
		font-size: 150%;
		font-weight: bold;
	}
	#queryTxt{
		height: 25px;
		font-size: 120%;
		font-weight: 900;
	}

</style>

</head>
<body>
	
<div id="wrap">

<div class="clear"></div>
<jsp:include page="/member/loginfo.jsp" />
<!-- 헤더파일들어가는 곳 -->
<div class="clear"></div>
<jsp:include page="../inc/header.jsp" />
<div class="clear"></div>
<jsp:include page="../inc/iconBoard.jsp" />

<div class="clear"></div>

<center>
	<table>
		<tr>
			<td >
				<img alt="" src="../images/jyh.jpg" id="imagejyh" width="300" >
			</td>
			<td>
				<table border="1" width="500">
					<tr>
						<td colspan="4" align="center" id="mainTxt" >자 기 소 개</td>
					</tr>
					<tr>
						<td width="60px" align="center" id="queryTxt">이  름</td>
						<td width="100px" align="center">정영현</td>
						<td width="100px" align="center" id="queryTxt">나  이</td>
						<td width="80px" align="center">31세(1987년생)</td>
					</tr>
					<tr>
						<td align="center" id="queryTxt">약  력</td>
						<td colspan="3">
							<table id="borderBottomSet" width="427px">
								<tr>
									<td width=90>&nbsp;2012년 02월</td><td>&nbsp;경남정보대학 기계설계과 졸업</td>
								</tr>								
								<tr>
									<td>&nbsp;2012년 09월</td><td>&nbsp;LG 이노텍 입사</td>
								</tr>
								<tr>									
									<td>&nbsp;2012년 11월</td><td>&nbsp;LG 이노텍 퇴사 (전공분야로 재취업하기위해)</td>
								</tr>
								<tr>									
									<td>&nbsp;2013년 01월</td><td>&nbsp;(주)쏘테크 배관설계 엔지니어 입사</td>
								</tr>
								<tr>									
									<td>&nbsp;2016년 07월</td><td>&nbsp;사내 프로그램 개발 부서로 전배</td>
								</tr>
								<tr>									
									<td>&nbsp;2016년 08월</td><td>&nbsp;학점은행제 기계공학사 학위 취득</td>
								</tr>								
								<tr>									
									<td>&nbsp;2017년 06월</td><td>&nbsp;(주)쏘테크 퇴사 (진로 개척을 위한 퇴사)</td>
								</tr>
								<tr>									
									<td>&nbsp;~ 현재까지</td><td>&nbsp;아이티윌 학원에서 JAVA, JSP 교육 수강 중</td>
								</tr>
							</table>
						</td>
					</tr>		
					<tr>
						<td align="center" id="queryTxt">보유기술</td>
						<td colspan="3">
							<table id="borderBottomSet" width="427px">
								<tr>
									<td width=90>&nbsp;영어</td><td>&nbsp;OPIc IM 2</td>
									<td>&nbsp;JSP</td><td>&nbsp;초급</td>
								</tr>								
								<tr>									
									<td>&nbsp;JAVA</td><td>&nbsp;초급</td>
									<td>&nbsp;JavaScript</td><td>&nbsp;초급</td>
								</tr>
								<tr>									
									<td>&nbsp;CSS</td><td>&nbsp;초급</td>
									<td>&nbsp;JQuery</td><td>&nbsp;초급</td>
								</tr>	
								<tr>									
									<td>&nbsp;JSON</td><td>&nbsp;초급</td>
									<td>&nbsp;AJAX</td><td>&nbsp;초급</td>
								</tr>
								<tr>									
									<td>&nbsp;SQL</td><td>&nbsp;초급</td>
									<td>&nbsp;PML</td><td>&nbsp;고급</td>
								</tr>
							</table>							
						</td>
					</tr>
					<tr>
						<td align="center" id="queryTxt">수상내역</td>
						<td colspan="3">
							<table id="borderBottomSet" width="427px">
								<tr>
									<td width=90>&nbsp;2012년 02월</td><td>&nbsp;경남정보대학 졸업 성적우수상(과 1등)</td>
								</tr>								
								<tr>									
									<td>&nbsp;2014년 06월</td><td>&nbsp;헌혈 유공자 포장증(은장)</td>
								</tr>
								<tr>
									<td>&nbsp;2015년 09월</td><td>&nbsp;헌혈 유공자 포장증(금장)</td>
								</tr>								
								<tr>									
									<td>&nbsp;2016년 04월</td><td>&nbsp;삼성중공업 주최 기능경기대회 해양 CAD 부분 동상</td>
								</tr>
								<tr>									
									<td>&nbsp;2016년 12월</td><td>&nbsp;사내 우수사원 표창</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td align="center" id="queryTxt">개발계기</td>
						<td colspan="3">
							&nbsp; CAD 프로그램을 이용하다 보면 단순업무를 macro를 만들어 사용함으로써<br/> 
							&nbsp; 업무의 효율성을 좋게 할때가 있습니다. 처음에는 취미로 macro를 만들면서<br/> 
							&nbsp; 주변 사람들에게 배포하였고 점점 macro 를 넘어 oop프로그램을 만들었고,<br/>
							&nbsp; 배포한 프로그램을 삼성 직영 개발 과장님이 보시고 개발에 소질이 있다고<br/>
							&nbsp; 개발부서로 추천을 해주셨습니다. <br/>
						</td>
					</tr>	
					<tr>
						<td align="center" id="queryTxt">이력서<br/>요 청</td>
						<td colspan="2">
							&nbsp;저에 대해 더 알고싶으시면 오른쪽 LINK 클릭하세요. <br/>
							&nbsp;클릭하면 주인장에게 이력서가 요청되고<br/>
						 	&nbsp;확인후 가입하신 이메일로 이력서를 보내드립니다.
						</td>
						<td>
							<a id="queryTxt" class="atag" href="" onclick="askResume(); return false;" title="주인장 이력서 요청하기">
								&nbsp;&nbsp;&nbsp;이력서 요청
							</a>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<br/>
</center>

<form action="askResume.jsp" name="resume" method="post">
</form>

<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/footer.jsp" />
<!-- 푸터 들어가는 곳 -->
</div>

</body>

</html>