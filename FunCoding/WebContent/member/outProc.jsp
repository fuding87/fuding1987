<%@page import="java.net.URLDecoder"%>
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
</head>
<body>
<%	
	MemDao dao = new MemDao();
	Cookie[] cookies = request.getCookies();
	String CookieNick = dao.getCookieValue(cookies,"CookieNick");
	
	if (CookieNick != null){ //autoLogin 체크 되어있으면 // cookie nick 기준으로 탈퇴 // 창 닫았다가 다음날 접속하면 session 값이 없기 때문
		CookieNick = URLDecoder.decode(dao.getCookieValue(cookies,"CookieNick"), "utf-8");
		dao.closeAccount(CookieNick);
	} else { // session nick 기준으로 탈퇴
		String nick = (String)session.getAttribute("sessionNick");
		dao.closeAccount(nick);
	}
%>
<!-- logoutProc 로 이동하면 session값과 cookie값 자동으로 삭제 해주고 index페이지로 이동 -->
<script type="text/javascript">
	location.href = "../member/logoutProc.jsp";
</script>

</body>
</html>