<%@page import="member.MemDto"%>
<%@page import="member.MemDao"%>
<%@page import="java.net.URLEncoder"%>

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

String id = request.getParameter("loginId");
String pass = request.getParameter("loginPass");
String autoLogin = request.getParameter("autoLogin");

MemDao dao = new MemDao();

String sessionNick = dao.loginUser(id, pass);
String CookieNick = URLEncoder.encode(sessionNick, "UTF-8"); //한글처리로 인한 에러 발생
if (autoLogin != null && !"".equals(sessionNick.trim())){ //null 이 아니면 선택된것, 그리고 sessionNick이  빈것이 아닌것
	// 쿠키에 저장
	Cookie nickCookie = new Cookie("CookieNick",CookieNick);
	nickCookie.setMaxAge(60*60*24*365); /* 1년 설정 해놓음 */
	response.addCookie(nickCookie);
}

if(sessionNick != "") {

	session.setAttribute("sessionNick", sessionNick);
	// 회원 정보 수정등을 대비해서 dto 객체에 정보 담아놓고 session에 저장해놓기
	MemDto dto = dao.getMember(sessionNick);
	session.setAttribute("dto", dto);
	%>
	<script type="text/javascript">
		location.href = "index.jsp";
	</script>
	<%
} else {

	if ("".equals(id.trim()) && "".equals(pass.trim())){
	%>
		<script type="text/javascript">
			alert("아이디와 비밀번호를 입력하세요.");
			location.href = "index.jsp";
		</script>
	<%	
	} else if (id != null && pass != null){
	%>
		<script type="text/javascript">
			alert("아이디 또는 비밀번호가 틀립니다.");
			location.href = "index.jsp";
		</script>
	<%
	} 
}
%>

