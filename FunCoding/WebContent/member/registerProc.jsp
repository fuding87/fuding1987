<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
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
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="member.MemDao"/>
<jsp:useBean id="dto" class="member.MemDto"/>
<jsp:setProperty property="*" name="dto"/>

<%
	dao.insertMember(dto);
%>

<script type="text/javascript">
	alert("회원가입 성공");
	location.href="index.jsp";
</script type="text/javascript">