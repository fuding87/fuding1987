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
	// session check 해서 login 안되어있으면 index.jsp 로 넘기기
	if (session.getAttribute("sessionNick") == null ){
%>	
		<script type="text/javascript">
			location.href = "../member/index.jsp";
		</script>
<%
	}
%>

<%-- 순서1. Post.jsp페이지에서 요청받은 글쓰기 내용을 한글처리 --%>
<%
	request.setCharacterEncoding("UTF-8");
	String board = request.getParameter("board");
%>
<%-- ---------------------------------------- --%>

<%-- 순서2. DB작업 insert 하기위해 dao객체 생성 --%>
	<jsp:useBean id="dao" class="board.BoardDao" />
<%-- ---------------------------------------- --%>

<%-- 순서3. 요청받은 글 내용을 Post.jsp에서 전달받아 BoardDto객체로 포장함 --%>	
	<jsp:useBean id="dto" class="board.BoardDto" />
	<jsp:setProperty property="*" name="dto" />
<%-- ---------------------------------------- --%>

<%-- 순서4. 글쓰기 DB작업을 위해 포장한 DTO객체를 dao클래스의 insertBoard()메소드에 전달 --%>
	<%
		MemDao mdao = new MemDao();
	
		// id 값은 닉값 토대로 받아올것
		dto.setId(mdao.getIdByNick((String)session.getAttribute("sessionNick")));
	
		dao.insertBoard(dto, board);
		//순서5. 게시판에 글쓰기 추가 완성 했다면.. 다시 List.jsp로 페이지 이동
		response.sendRedirect("List.jsp?board=" + board);
	%>
<%-- ---------------------------------------- --%>