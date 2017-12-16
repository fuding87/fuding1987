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
<title>회원 가입 페이지</title>

<link href="../css/default.css" rel="stylesheet" type="text/css" media="all">

<script type="text/javascript" src="../js/jquery-1.6.1.min.js"></script>

<script type="text/javascript" src="../js/s3Slider.js"></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script type="text/javascript" src="../js/registerMethod.js"></script>

<script type="text/javascript">
	$(document).ready(function() { 
	   	$('#logoslider').s3Slider({ 
	      	timeOut: 3000
	 	}); 
	});
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
	<form action="registerProc.jsp" method="post" onsubmit="return checkForm();" />

		<div id="reg_wrap_main">
		
		<h1 id="reg_wrap_main_reg_h1"> < 회원가입 > </h1>
		
		<!-- 김정은 그림 삽입 -->
		<div id="reg_wrap_img_register"></div>
		
		<table>
			<tr>
				<th>아 이 디</th>
				<td><input type="email" name="id" id="id" placeholder="Email 계정을 입력하세요" onkeyup="checkId();" required/></td>
				<td><input type="button" name="idCheck" value="메일 인증 받기" width="150" onclick="sendEmail();"/></td>
				<td><span id="idCheck" class="check_status">&nbsp;</span></td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td><input type="password" name="pass" id="pass" onkeyup="checkPass();" required/></td>
			</tr>
			<tr>
				<th>패스워드 확인</th>
				<td><input type="password" name="pass2" id="pass2" onkeyup="checkPass();" required/></td>
				<td><span id="passCheck" class="check_status">&nbsp;</span></td>
			</tr>
			<tr>
				<th>이    름</th>
				<td><input type="text" name="name" /></td>
				
			</tr>
			<tr>
				<th>닉 네 임</th>
				<td><input type="text" name="nick" id="nick" onkeyup="checkNick();" required/></td>
				<td><span id="nickCheck" class="check_status">&nbsp;</span></td>
			</tr>
			<tr>
				<th>주  소</th>
				<td><input type="text" name="postcode" id="postcode" placeholder="우편번호" /></td>&nbsp;<!-- nbsp 하니깐 줄띄워주네 -->
				<td><input type="button" onclick="execDaumPostcode();" value="우편 번호 검색" class="btn" width="150" /></td>
				<span></span>
			</tr>
			<tr>
				<th></th>
				<td><input type="text" name="address" id="address" placeholder="주소" readonly="readonly" /></td>
				<td><input type="text" name="address2" id="address2" placeholder="상세주소" /></td>
			</tr>
		</table>
		<br/>

		</div>
		<table align="center">
			<tr>
				<th></th>
				<td><input type="submit" value="회원추가" width="300" /></td>
				<td><input type="reset" value="다시입력" width="300" /></td>
			</tr>
		</table>
	</form>
	<br/>	

	<!-- 푸터 들어가는 곳 -->
	<jsp:include page="../inc/footer.jsp" />
	<!-- 푸터 들어가는 곳 -->
	</div>
	
	<div class="clear"></div>

</body>
</html>