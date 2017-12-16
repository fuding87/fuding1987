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

<header id="mainHeader">

<!-- 로고들어가는 곳 -->
<div id="logo_img">
	<div id="logoslider">
		<a href="../member/index.jsp">
		<ul id="logosliderContent">
			<li class="logosliderImage">
				<img src="../images/fuding_1.png" width="600" height="150">
				<span></span>
			</li>
			<li class="logosliderImage">
				<img src="../images/fuding_2.png" width="600" height="150">
				<span></span>
			</li>
			<!-- 시간 조절용으로 없으면 사진이 -1개로 적용됨 -->
			<li class="logosliderImage">
			</li>
		</ul>
		</a>
	</div>
</div>

<!-- 로고들어가는 곳 -->

</header>