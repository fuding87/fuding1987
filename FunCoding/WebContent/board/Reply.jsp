<%@page import="board.BoardDto"%>
<%@page import="board.BoardDao"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>

</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	int num = Integer.parseInt(request.getParameter("num"));
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	String board = request.getParameter("board");
	String nowPage = request.getParameter("nowPage");
	String nowBlock = request.getParameter("nowBlock");
	String beginPerPage = request.getParameter("beginPerPage");
	
	BoardDao dao = new BoardDao();
	
	BoardDto dto = dao.getBoard(num, board);
	
	String subject = dto.getSubject();
	String content = dto.getContent();

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

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/default.css" rel="stylesheet" type="text/css" media="all">

<script type="text/javascript" src="../js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="../js/s3Slider.js"></script>
<script type="text/javascript">
	$(document).ready(function() { 
	   	$('#logoslider').s3Slider({ 
	      	timeOut: 3000
	 	}); 
	});
</script>

<title><%=board %>게시판</title>
</head>
<body>

<div id="wrap">
<div class="clear"></div>
<jsp:include page="/member/loginfo.jsp" />

<div class="clear"></div>
<jsp:include page="../inc/header.jsp" />
<div class="clear"></div>
<!-- 헤더파일들어가는 곳 -->
<!-- 아이콘 보드 만들어서 다른 페이지도 삽인할수 있게 할것 -->
<jsp:include page="../inc/iconBoard.jsp" />

<div class="clear"></div>

<center>
<br><br>
<table width=80% cellspacing=0 cellpadding=3>
	<tr>
	  	<td bgcolor=#D0D0D0 height=25 align=center><%=board.substring(0,board.length()-5).toUpperCase()%> 게시판 답변달기 </td>
	</tr>
</table>
<br>
<table width=80% cellspacing=0 cellpadding=3 align=center>

<form name=form method=post action="ReplyProc.jsp" >

<input type="hidden" name="ip" value="<%=request.getRemoteAddr() %>" />

<tr>
	<td align=center>
	   	<table border=0 width=100% align=center>
	
	    <tr>
			<td width=10%>제 목</td>
			<td width=90%><input type=text name=subject size=100 value=""></td>
	    </tr>
	    <tr>
		     <td width=10%>내 용</td>
		     <td width=90%><textarea name=content rows=10 cols=105></textarea></td>
	    </tr>
	    
	   	</table>
	   	<br/>
	   	<div align="right">
		   	<input type=submit value="답변달기" >&nbsp;
			<input type=reset value="다시쓰기">&nbsp;
			<input type=button onclick="cancelToBack();" value="취소">&nbsp;
			<input type="hidden" name="num" value="<%=num%>" /> <!-- 수정하기에서 수정한 화면 바로 볼수 있게끔 - 페이지 고정값이기 때문에  -->
			<input type="hidden" name="board" value="<%=board%>" />
			<input type="hidden" name="keyField" value="<%=keyField %>" />
			<input type="hidden" name="keyWord" value="<%=keyWord %>" />
			<input type="hidden" name="board" value="<%=board %>" />
			<input type="hidden" name="nowPage" value="<%=nowPage %>" />
			<input type="hidden" name="nowBlock" value="<%=nowBlock %>" />
			<input type="hidden" name="beginPerPage" value="<%=beginPerPage %>" />	
		</div>
		<br/>
	</td>
</tr>

</form> 

<!-- 취소하면 원래 글로 복귀 history.back말고 -->
<form name="cancel" method=post action="Read.jsp" >
	<input type="hidden" name="num" value="<%=num %>"/>
	<input type="hidden" name="board" value="<%=board%>" />
	<input type="hidden" name="keyField" value="<%=keyField %>" />
	<input type="hidden" name="keyWord" value="<%=keyWord %>" />
	<input type="hidden" name="board" value="<%=board %>" />
	<input type="hidden" name="nowPage" value="<%=nowPage %>" />
	<input type="hidden" name="nowBlock" value="<%=nowBlock %>" />
	<input type="hidden" name="beginPerPage" value="<%=beginPerPage %>" />	
</form>

</table>
</center>

<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/footer.jsp" />
<!-- 푸터 들어가는 곳 -->
</div>

</body>

<script type="text/javascript">
function cancelToBack(){
	document.cancel.submit();
}
</script>

</html>

