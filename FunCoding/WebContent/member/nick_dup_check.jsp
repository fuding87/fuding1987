<%@page import="member.MemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 
****ajax랑 같이 사용 안된다.... 아오 씨바****
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
--%>
<%
request.setCharacterEncoding("utf-8");

String nick = request.getParameter("nick");
MemDao dao = new MemDao();
boolean check = dao.checkNick(nick);
out.println(check);
%>