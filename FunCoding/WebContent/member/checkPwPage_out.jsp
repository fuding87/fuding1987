<%@page import="java.net.URLDecoder"%>
<%@page import="member.MemDto"%>
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
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String inputpw = request.getParameter("pw");
		
		MemDao dao = new MemDao();
		Cookie[] cookies = request.getCookies();
		String CookieNick = dao.getCookieValue(cookies,"CookieNick");
		
		MemDto dto = new MemDto();
		
		if (CookieNick != null){ //autoLogin 체크 되어있으면 // cookie nick 기준으로 탈퇴 // 창 닫았다가 다음날 접속하면 session 값이 없기 때문
			CookieNick = URLDecoder.decode(dao.getCookieValue(cookies,"CookieNick"), "utf-8");
			dto = dao.getMember(CookieNick);
		} else { // session nick 기준으로 탈퇴
			dto  = (MemDto)session.getAttribute("dto");
		}
		// 로그인시 session에 저장되어있는 dto 를 이요해서 pw를 가져와서 위의 pw 값과 비교한다
		String dtopw = dto.getPass();

		if (dtopw.equals(inputpw)){ //비밀번호가 같으면 탈퇴
	%>
			<script type="text/javascript">
				alert("탈퇴 되었습니다.");
				location.href = "outProc.jsp";
			</script>
	<%
		} else { //다르면 go out.jsp로 
	%>
			<script type="text/javascript">
				alert("비밀번호가 틀립니다.");
				location.href = "out.jsp";
			</script>	
	<%
		}
	%>
</body>
</html>