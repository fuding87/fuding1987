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

<%
	// session check 해서 login 안되어있으면 index.jsp 로 넘기기
	if (session.getAttribute("sessionNick") == null ){
%>	
		<script type="text/javascript">
			location.href = "../member/index.jsp";
		</script>
<%
	}
%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 정보 수정 페이지</title>

<link href="../css/default.css" rel="stylesheet" type="text/css" media="all">

<script type="text/javascript" src="../js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="../js/s3Slider.js"></script>

<script type="text/javascript">
	$(document).ready(function() { 
	   	$('#logoslider').s3Slider({ 
	      	timeOut: 3000
	 	}); 
	});

	function goIndex(){
		location.href = "index.jsp";
	}

</script>

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
 
	<!-- 직원추가 디자인 화면 (아마추어페이지) -->
	<form action="checkPwPage_modify.jsp" method="post" />

		<div id="reg_wrap_main">
		
		<h1 id="reg_wrap_main_modify_h1"> < 회원 정보 수정 > </h1>
		
		<!-- 김정은 그림 삽입 -->
		<div id="reg_wrap_img_modify"></div>
			<br/>
			<span id="reg_wrap_main_th">비밀번호 체크</span> &nbsp;&nbsp;
			<input type="password" id="pw" name="pw" required> &nbsp;&nbsp;
			<input type="submit" value="비밀 번호 확인" > &nbsp;&nbsp;
			<input type="button" value="수정 취소" onclick="goIndex();"> &nbsp;&nbsp;
		</div>
	</form>
	<br/>	

	<!-- 푸터 들어가는 곳 -->
	<jsp:include page="../inc/footer.jsp" />
	<!-- 푸터 들어가는 곳 -->
	</div>
	
	<div class="clear"></div>

</body>
</html>