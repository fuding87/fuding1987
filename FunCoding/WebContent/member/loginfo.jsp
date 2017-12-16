<%@page import="java.net.URLDecoder"%>
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

<header id="logHeader">

<div id="login">
<%
	// 내가 잘못 한 걸수도 있는데 자동로그인 로직 구동을 위해서는 
	// login 관련 페이지가 한 폴더 안에 있어야 된다... 왜그런지는 모르겠다 우연히 된건지 어쩐지는 일단 여기서 넘어감
	MemDao dao = new MemDao();
	Cookie[] cookies = request.getCookies();
	String CookieNick = dao.getCookieValue(cookies,"CookieNick");
	if ( CookieNick != null ){
		CookieNick = URLDecoder.decode(dao.getCookieValue(cookies,"CookieNick"), "utf-8"); 
		// sessionNick 기준으로 정보조회 탈퇴 로직 만들어야 하므로 sessionNick은 항상 있어야 한다
		session.setAttribute("sessionNick", CookieNick);
	}
	if  ( CookieNick != null ){
%>		
		<span id="nickPosition"><%=CookieNick %></span> 
		<span> 님 환영합니다. </span>			&nbsp;&nbsp;&nbsp;
											&nbsp;&nbsp;&nbsp;
		<a href="../member/modify_pwCheck.jsp" >회원 정보 수정</a> |
		<a href="../member/logoutProc.jsp">로그 아웃</a> |
		<a href="../member/out.jsp">탈퇴</a>		
<%		
	} else {
		
		// 로그인 되어있는 상태
		if (session.getAttribute("sessionNick") != null){

			String sessionNick = (String)session.getAttribute("sessionNick");
%>	
			<span id="nickPosition"><%=sessionNick %></span> 
			<span> 님 환영합니다. </span>			&nbsp;&nbsp;&nbsp;
												&nbsp;&nbsp;&nbsp;	
			<a href="../member/modify_pwCheck.jsp" >회원 정보 수정</a> |
			<a href="../member/logoutProc.jsp">로그 아웃</a> |
			<a href="../member/out.jsp">탈퇴</a>
<%
		} else {
			// 로그인 안되어있는 상태
%>
		<form method="post" name="loginInputForm" style="margin-bottom: 0px;" >
			자동 로그인 <input type="checkbox" name="autoLogin" id="autoLogin" > |
			아이디 <input type="email" id="loginId" name="loginId" placeholder="Email 계정을 입력하세요"/>  
			비밀번호 <input type="password" id="loginPass" name="loginPass"/>
			<a href="#" onclick="goLoginPage();">로그인</a> |
			<a href="#" onclick="goSearchPage();" id="searchIdPw">로그인정보 찾기</a> | 
			<a href="../member/register.jsp">회원가입</a>
		</form>
<%
		}
 } 
%>

	<hr>
	
</div>
<script type="text/javascript">
function goLoginPage(){
/* 	location.href = "../member/loginProc.jsp?id=" + document.getElementById("loginId").value +
					"&pass=" + document.getElementById("loginPass").value; */ 
					/* 상기 방식은 get 방식으로 로그인 정보가 남아서 비추천 */
	document.loginInputForm.action="../member/loginProc.jsp";
	document.loginInputForm.submit();
}

function goSearchPage(){
	var width = 380;
	var height = 350;
	var winL = (screen.width - width) / 2;
	var winT = (screen.height - height) / 2;
	var property = "width=" + width + "," + "height=" + height + "," 
					+ "left=" + winL + "," + "top=" + winT + " menubar=no";

	window.open("../member/searchIdPw.jsp", "로그인 정보 찾기 페이지", property);
}
</script>
	
</header>
