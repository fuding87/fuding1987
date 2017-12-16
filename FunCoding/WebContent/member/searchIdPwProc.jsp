<%@page import="java.util.Vector"%>
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
    
<%	
	request.setCharacterEncoding("utf-8");
	MemDao dao = new MemDao();

	// page 이동할때 전달할 값 필요하기 때문에 저장 (ruquest 에 저장하니깐 안되네;; 그래서 session에 저장했음)
	String name = request.getParameter("name");
	session.setAttribute("name", name);

	Vector v = dao.getEmailList(name);
	session.setAttribute("v", v);
	
	String getName = (String)session.getAttribute("name");
%>

<script type="text/javascript">
	location.href = "../member/searchIdPw.jsp";
</script>