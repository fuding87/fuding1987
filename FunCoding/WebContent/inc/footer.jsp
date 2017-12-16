<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
 
<footer>
<hr>
<div>
	<a href="../member/index.jsp" title="메인페이지로 이동">
		<img src="../images/fuding_under.png" width="180px" height="70px" id="logoSmall" style="margin-left:20px;"/>
	</a>
</div>
<div id="copy">
	All contents Copyright 2017 YoungHyun.Jeong all rights reserved.<br>
	Contact Mail : <span id="enhanceText">macrozm@naver.com</span> <br>
	Phone Number : <span id="enhanceText">+82 010 8480 8466</span>, KakaoTalk ID : <span id="enhanceText">tbpi</span>
</div>
<div id="searchEngineIcon">
	<a href="http://www.naver.com" title="네이버로 이동">
		<img src="../images/navericon.png" width="70px" height="50px" id="navericon" />
	</a>
	<a href="http://www.google.com" title="구글로 이동">
		<img src="../images/googleicon.png" width="70px" height="50px" id="googleicon" />
	</a>
	<a href="http://www.daum.net" title="다음으로 이동">
		<img src="../images/daumicon.png" width="70px" height="50px" id="daumicon" />
	</a>
	<a href="http://cafe.naver.com/learntimes" title="아이티윌 카페로 이동">
		<img src="../images/itwillicon.png" width="70px" height="50px" id="itwillicon" />
	</a>
</div>
</footer>




