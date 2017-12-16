
<%@page import="board.BoardDao"%>
<%@page import="member.MemDao"%>
<%@page import="board.BoardDto"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//Reply.jsp에서 전달받은 답변내용들을 한글 처리
	request.setCharacterEncoding("UTF-8");
%>

<%-- 요청받은 답변내용을 Reply.jsp에서 전달받아 BoardDto에 저장 --%>	
	<jsp:useBean id="dto" class="board.BoardDto" />
	<jsp:setProperty property="*" name="dto" />
	
<%-- 답변달기 DB작업을 위한 DAO객체 생성 --%>
	<jsp:useBean id="dao" class="board.BoardDao" />
	
	<%
	
/* 		//dto에 추가적으로 답변글 작성한 시간 저장 => 이거 안할거면 sql에서 now() 입력할 것
		dto.setRegdate(new Timestamp(System.currentTimeMillis())); */

		int num = Integer.parseInt(request.getParameter("num"));
		MemDao mdao = new MemDao();
		
		String board = request.getParameter("board");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
		String keyField = request.getParameter("keyField");
		String keyWord = request.getParameter("keyWord");
		String nowPage = request.getParameter("nowPage");
		String nowBlock = request.getParameter("nowBlock");
		String beginPerPage = request.getParameter("beginPerPage");
		
		//부모글번호를 전달하여 부모글 정보 얻기
		BoardDto ParentDto = dao.getBoard(num, board);
		
		//부모글에 대한 pos값 넘겨서..
		//부모글보다 큰 pos값에 1을 더해서 수정 하기
		dao.replyUpPos(ParentDto.getPos(), board);
		
		//위에 생성한 답변글 dto객체에  부모글의 pos값과 depth값을 저장하기
		dto.setPos(ParentDto.getPos());
		dto.setDepth(ParentDto.getDepth());
		// id값 가져오기
		dto.setId(mdao.getIdByNick((String)session.getAttribute("sessionNick")));
		//부모글의 pos,depth값을 저장한 답변글정보(dto)객체 전달 하여...
		//답변달기
		dao.replyBoard(dto, board);
		
		// num 최대값이 지금 막 작성한 답변글 번호이다.
		BoardDao bdao = new BoardDao();
		int reNum = bdao.getMaxNum(board);

	%>
	
<form action="Read.jsp" name="read" method="post">
	<input type="hidden" name="num" value="<%=reNum %>"/> <!-- 답글번호 페이지 -->
	<input type="hidden" name="keyField" value="<%=keyField %>" />
	<input type="hidden" name="keyWord" value="<%=keyWord %>" />
	<input type="hidden" name="board" value="<%=board %>" />
	<input type="hidden" name="nowPage" value="<%=nowPage %>" />
	<input type="hidden" name="nowBlock" value="<%=nowBlock %>" />
	<input type="hidden" name="beginPerPage" value="<%=beginPerPage %>" />
	<input type="hidden" name="reload" value="false" />
</form>


<script type="text/javascript">
	alert("답글이 등록 되었습니다.")
	document.read.submit();
</script>
	