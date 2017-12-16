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

<%
	session.removeAttribute("sessionNick");
	session.removeAttribute("dto");
	
	request.setCharacterEncoding("utf-8");
	Cookie nickCookie = new Cookie("CookieNick",null);
	nickCookie.setMaxAge(0); /* 로그아웃이니깐 0초로 설정  */
	response.addCookie(nickCookie);

%>

<script type="text/javascript">
	location.href = "../member/index.jsp";
</script>