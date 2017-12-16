<%@page import="member.MemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
	// session check 해서 login 안되어있으면 
	if (session.getAttribute("sessionNick") == null ){
	%>	
		<script type="text/javascript">
			alert("로그인 해야 이력서 요청 할수 있습니다.")
			location.href = "../board/hostInfo.jsp";
		</script>
	<%
	} else {
		
		// 입력값 받음
		MemDao dao = new MemDao();
		String to = "macrozm@naver.com"; 	// 주인장 개인 이메일
		String purpose = "resume"; 			// 이력서 요청 
		// 인증코드 값은 필요가 없어서
		String authNum = "";
		// 이력서 요청한 사람 넣음
		String nick = (String)session.getAttribute("sessionNick");
		String askingMember = dao.getIdByNick(nick);

		int check = dao.sendEmail(to, authNum, purpose, askingMember);
		if(check == 1) {
	%>
		<script type="text/javascript">
			alert("이력서 요청 메일이 발송되었습니다.!");
			location.href="../board/hostInfo.jsp";
		</script>
	<%
		} else {
	%>
		<script type="text/javascript">
			alert("메일 발송 실패! 요청 페이지에 글작성 부탁 드립니다.");
			location.href="../board/hostInfo.jsp";
		</script>
	<%
		}
	
	}
	%>