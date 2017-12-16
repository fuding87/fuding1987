<%@page import="member.MemDao"%>
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

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String to = request.getParameter("to");
	
	// 입력값 받음
	MemDao dao = new MemDao();
	String purpose = "findpw";
	// 인증코드 값은 필요가 없어서
	String authNum = "";
	// 이력서 요청한 사람 넣음
	String askingMember = "";
	int check = dao.sendEmail(to, authNum, purpose, askingMember);
	
	if(check == 1) {
	%>
		<script type="text/javascript">
			alert("비번 메일 발송!");
			window.close();
		</script>
	<%
	} else {
	%>
		<script type="text/javascript">
			alert("인증 메일 발송 실패! 관리자에게 연락하세요");
			window.close();
		</script>
	<%
	}
%>
</body>
</html>