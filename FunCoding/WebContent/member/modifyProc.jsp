<%@page import="java.net.URLEncoder"%>
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
	dao.updateMember(dto);

	// 바뀐 정보를 session 에 다시 담아 주기
	session.setAttribute("dto", dto);
	
	// 닉값도 변경해주기
	// cookieNick 이 있으면 cookieNick을 변경해주고 sessionNick도 함께 변경해주고
	// cookieNick 이 없으면 sessionNick만 변경해줄것
	Cookie[] cookies = request.getCookies();
	String CookieNick = dao.getCookieValue(cookies,"CookieNick");
	
	if (CookieNick != null){ //autoLogin 체크
		// cookieNick 값 변경
		// 한글처리 해줄것
		Cookie nickCookie = new Cookie("CookieNick",URLEncoder.encode(dto.getNick(), "UTF-8"));
		nickCookie.setMaxAge(60*60*24*365); /* 1년 설정 해놓음 */
		response.addCookie(nickCookie);
		// session 값 변경
		session.setAttribute("sessionNick", dto.getNick());

	} else {// cookieNick 이 없으면 즉! autoLogin 체크가 안되어있으면
		// session 값 변경
		session.setAttribute("sessionNick", dto.getNick());
	}

%>

<script type="text/javascript">
	alert("정보 수정 성공");
	location.href="index.jsp";
</script>