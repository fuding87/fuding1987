<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>

<%
	// 현재 게시판 이름 획득
	String board = request.getParameter("board");
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
			alert("로그인 해야 글 작성할수 있습니다.")
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
	  	<td bgcolor=#D0D0D0 height=25 align=center><%=board.substring(0,board.length()-5).toUpperCase()%> 게시판 글쓰기</td>
	</tr>
</table>
<br>
<table width=80% cellspacing=0 cellpadding=3 align=center>

<form name=post method=post action="PostProc.jsp?board=<%=board%>" >

<%--추가1. 요청한 클라이언트의 ip정보를 PostProc.jsp에 요청 --%>
<input type="hidden" name="ip" value="<%=request.getRemoteAddr() %>" />

<tr>
	<td align=center>
	   	<table border=0 width=100% align=center>
	
	    <tr>
			<td width=10%>제 목</td>
			<td width=90%><input type=text name=subject size=100></td>
	    </tr>
	    <tr>
		     <td width=10%>내 용</td>
		     <td width=90%><textarea name=content rows=10 cols=105></textarea></td>
	    </tr>
	    
	   	</table>
	   	<br/>
	   	<div align="right">
		   	<input type=submit value="등록" >&nbsp;
			<input type=reset value="다시쓰기">&nbsp;
			<input type=button onclick="location.href='List.jsp?board=<%=board%>'" value="목록으로">&nbsp;
		</div>
		<br/>
	</td>
</tr>



</form> 
</table>
</center>

<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/footer.jsp" />
<!-- 푸터 들어가는 곳 -->
</div>

</body>
</html>