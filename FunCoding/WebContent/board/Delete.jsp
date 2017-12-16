<%@page import="board.BoardDto"%>
<%@ page contentType="text/html; charset=UTF-8" %>
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

<%--삭제DB작업할 DAO객체 생성 --%>
<jsp:useBean id="dao" class="board.BoardDao" ></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("utf-8");
	
	//삭제할 글번호 request영역에서 꺼내오기
	int num = Integer.parseInt(request.getParameter("num"));
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");	
	String board = request.getParameter("board");
	String nowPage = request.getParameter("nowPage");
	String nowBlock = request.getParameter("nowBlock");
	String beginPerPage = request.getParameter("beginPerPage");

	dao.deleteBoard(num, board);

	/* response.sendRedirect("List.jsp?board=" + board + "&keyField=" + keyField + "&keyWord=" + keyWord ); */
	/* + "&nowPage=" + nowPage 
	+ "&nowBlock=" + nowBlock + "&beginPerPage=" + beginPerPage */
	// 이걸로 보내니깐 한글이 깨지네 response setcharacter도 했는데 ;; 
	// 어쩔수 없이 자바 스크립트로 보냄
%>

<script type="text/javascript">
	
	location.href="List.jsp?board=<%=board%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>&nowPage=<%=nowPage%>&nowBlock=<%=nowBlock%>";

</script>