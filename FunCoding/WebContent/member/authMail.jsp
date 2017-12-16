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
<title>이메일 인증 페이지</title>

<%
	request.setCharacterEncoding("utf-8");
	String to = request.getParameter("to");
	
	// 입력값 받음
	MemDao dao = new MemDao();
	String authNum = dao.randomNum();
	String purpose = "cert";
	// 이력서 요청한 사람 넣음
	String askingMember = "";
	int check = dao.sendEmail(to, authNum, purpose, askingMember);

if(check == 1) {
%>
<script type="text/javascript">
	alert("인증 메일 발송!");
</script>
<%
} else {
%>
<script type="text/javascript">
	alert("인증 메일 발송 실패! 메일 주소를 다시 확인해주세요.");
	window.close();
</script>
<%
}
%>

<script type="text/javascript">
	function check() {
		var code = document.getElementById("code").value;
		var authNum = <%=authNum %>;
		
		if(!code) {
			alert("인증번호를 입력하세요.");
			return false;
		}
		
		if(authNum == code) {
			alert("인증 성공!");
			opener.idCheck.innerHTML = "인증 완료";
			opener.id_Check = true;
			window.close();
		} else {
			alert("인증번호가 틀립니다. 다시 입력해 주세요.");
			return false;
		}
	}
</script>

<style type="text/css">

#code{
	border-left: 0px;
	border-right: 0px;
	border-top: 0px;
	border-left: 2px;
	border-bottom-color: red;
	height: 50px;
}
#codebtn{
	width: 50px;
	height: 50px;
	border-radius: 10px;
}
</style>

</head>
<body>
	<form id="reg_form" onsubmit="return check();">
		<h2>인증번호</h2>
		<div>
			<input type="text" name="code" id="code" />
			<input type="submit" id="codebtn" value="확인"/>
		</div>
	</form>
</body>

</html>