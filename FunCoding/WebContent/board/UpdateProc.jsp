<%@page import="board.BoardDao"%>
<%@page import="board.BoardDto"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	int num = Integer.parseInt(request.getParameter("num"));
	
	String board = request.getParameter("board");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	String nowPage = request.getParameter("nowPage");
	String nowBlock = request.getParameter("nowBlock");
	String beginPerPage = request.getParameter("beginPerPage");
	
	
	BoardDto dto = new BoardDto();
	
	// 세가지 값만 있으면 수정 가능
	dto.setNum(num);
	dto.setContent(content);
	dto.setSubject(subject);
	
	BoardDao dao = new BoardDao();
	dao.updateBoard(dto, board);

%>

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
			location.href = "../board/List.jsp?board=<%=board%>";
		</script>
<%
	}
%>

<form action="Read.jsp" name="update" method="post">
	<input type="hidden" name="num" value="<%=num %>"/>
	<input type="hidden" name="keyField" value="<%=keyField %>" />
	<input type="hidden" name="keyWord" value="<%=keyWord %>" />
	<input type="hidden" name="board" value="<%=board %>" />
	<input type="hidden" name="nowPage" value="<%=nowPage %>" />
	<input type="hidden" name="nowBlock" value="<%=nowBlock %>" />
	<input type="hidden" name="beginPerPage" value="<%=beginPerPage %>" />
	<input type="hidden" name="reload" value="false" />
	<input type="hidden" name="count" value="false" />
</form>


<script type="text/javascript">
	alert("수정이 완료 되었습니다.")
	document.update.submit();
</script>
