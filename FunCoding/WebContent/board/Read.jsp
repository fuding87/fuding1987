<%@page import="java.util.Vector"%>
<%@page import="member.MemDao"%>
<%@page import="board.BoardDto"%>
<%@page import="board.BoardDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=UTF-8"%>


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

<%
	request.setCharacterEncoding("UTF-8");

	//순서1. 글조회수 증가, 글상세보기 DB작업을 할 DAO객체 생성
	BoardDao dao = new BoardDao();
	
	//순서2. List.jsp페이지에서 글제목을 클릭했을때.. 전달받는 3개의 값 저장
	int num = Integer.parseInt(request.getParameter("num"));
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	String board = request.getParameter("board");
	String nowPage = request.getParameter("nowPage");
	String nowBlock = request.getParameter("nowBlock");
	String beginPerPage = request.getParameter("beginPerPage");
	
	// 이전글 다음글을 위해서 
	Vector prevInfo = dao.getPrevNextInfo(num,board);
	String prevNum = (String)prevInfo.get(0);
	String prevSubject = (String)prevInfo.get(1); 
	String nextNum = (String)prevInfo.get(2);
	String nextSubject = (String)prevInfo.get(3);
	
	//수정하게 되면 페이지는 수정완료된 페이지를 보여주면서 카운트는 안올리는 식으로
	if(request.getParameter("count")==null){
		//update 를 하게 되면  updateProc에서 넘어온
		//request.getParameter("count") 가 false 로 지정되어있을거다 
		//update 를 하게 되면 counting 안되게
		//counting
		dao.count(num, board);
	}

	//순서3. 글상세보기 DB작업후 반환받는 DTO객체 저장하는 getBoard()메소드 호출
	BoardDto dto = dao.getBoard(num, board);
	
	MemDao mdao = new MemDao();
	
	//순서4. 전달받은 하나의 글 정보를 저장하고 있는 DTO객체 정보 얻기
	String nick = mdao.getNickById(dto.getId());
	if("".equals(nick.trim())){
		nick = "탈퇴함";
	}	
	
	Timestamp regdate = dto.getRegdate();
	//화면에 적은 엔터키값을 <br>로 처리 하겠다는 뜻
	String content = dto.getContent().replace("\n", "<br/>");
	String ip = dto.getIp();
	int count = dto.getCount();
	String subject = dto.getSubject();
%>

<html>
<head>
<title> <%=board%> 게시판 </title>

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

<br><br>
<table align=center width=70% border=0 cellspacing=3 cellpadding=0>
 <tr>
  <td bgcolor=9CA2EE height=25 align=center class=m>글읽기</td>
 </tr>
 <tr>
  <td colspan=2>
   <table border=0 cellpadding=3 cellspacing=0 width=100%> 
    <tr> 
	 <td align=center bgcolor=#dddddd width=10%> 글번호 </td>
	 <td bgcolor=#ffffe8>&nbsp;<%=num %></td>    
	 <td align=center bgcolor=#dddddd width=10%> 닉네임 </td>
	 <td bgcolor=#ffffe8>&nbsp;<%=nick %></td>
	 <td align=center bgcolor=#dddddd width=10%> 등록날짜 </td>
	 <td bgcolor=#ffffe8>&nbsp;<%=regdate %></td>
	 <td align=center bgcolor=#dddddd width=10%> 조회수 </td>
	 <td bgcolor=#ffffe8 width=40 align=right><%=count %>&nbsp;</td>	 
	</tr>
    <tr> 
     <td align=center bgcolor=#dddddd> 제 목</td>
     <td bgcolor=#ffffe8 colspan=7>&nbsp;<%=subject %></td>
   </tr>
   <tr height=15>
   <!-- 줄뛰움 효과 주려고 -->
   </tr>
   <tr> 
    <td colspan=8>&nbsp;<%=content %></td>
   </tr>
   <tr height=15>
   <!-- 줄뛰움 효과 주려고 -->
   </tr>   
   
	<!-- hr -->
	<tr>
		<td colspan=8>-----------------------------------------------------------------------------------------------------</td>
	</tr>
	 <!-- 이전글  -->
	 <tr>
		
		<td>이전글 :</td>
		<%
		if (prevSubject == ""){
		%>
			<td colspan="7">이전글이 없습니다.</td>
		<%			
		} else {
		%>
			<td colspan="7"><a class="atag" onclick="goPrev();"><%=prevSubject %></a></td>
		<%
		}
		%>
		
		
	 </tr>
	
	  <!-- 다음글  -->
	 <tr>
		<td colspan="1">다음글 :</td>
		<%
		if (nextSubject == ""){
		%>
			<td colspan="7">다음글이 없습니다.</td>
		<%			
		} else {
		%>
			<td colspan="7"><a class="atag" onclick="goNext();"><%=nextSubject %></a></td>
		<%
		}
		%>

	 </tr>   
   </table>
  </td>
 </tr>
 

 <tr>
  <td align=center colspan=2> 
	<hr size=1>
	<%-- 목록버튼 눌렀을때.. List.jsp페이지로 이동하는 링크 --%>
	[ <a class="atag" href="" onclick="fnList(); return false;">목 록</a> | 
	<a class="atag" href="" onclick="fnUpdate('<%=num %>'); return false;">수 정</a> |
	
	<a class="atag" href="" onclick="fnReply('<%=num%>'); return false;">답변</a> | 
	<!-- return false; 이게 중요하네 페이지 리로딩 안해주고 끝 -->
	
	<a class="atag" href="" onclick="fnDel('<%=num %>'); return false;">삭 제</a> ]<br>
  </td>
 </tr>
</table>

 	<script type="text/javascript">
		function fnList(){
			document.list.submit();
		}
		
		function fnUpdate(num){
			<% 
				if (session.getAttribute("sessionNick") == null || !session.getAttribute("sessionNick").equals(nick)){  
					// 작성글의  nick 과 sessionNick (현재 로그인된 nick) 이 일치 하지 않으면 수정 금지
			%>
					alert("로그인한뒤 본인의 글만 수정할수 있습니다.");
			<%
				} else {
			%>
					document.update.num.value = num;
					document.update.submit();
			<%
				}
			%>
		}
		
		function fnDel(num){
			<%	
				if (session.getAttribute("sessionNick") == null || !session.getAttribute("sessionNick").equals(nick)){ 
					// 작성글의  nick 과 sessionNick (현재 로그인된 nick) 이 일치 하지 않으면 수정 금지
			%>
					alert("로그인한뒤 본인의 글만 삭제할수 있습니다.");
			<%
				} else {
			%>	
 					if (confirm("정말 삭제 하시겠습니까?")){
						document.del.num.value = num;
						document.del.submit();
					} 
			<%
				} 
			%>	

		}
		
		
		function fnReply(num){
			
			<% 
				
				if (session.getAttribute("sessionNick") == null ){ 
					// 작성글의  nick 과 sessionNick (현재 로그인된 nick) 이 일치 하지 않으면 수정 금지
			%>
					alert("로그인하셔야 답변글을 달수 있습니다.");
			<%
				} else {
			%>	
					document.reply.num.value = num;
					document.reply.submit();
			<%
				} 
			%>	
		}
		function goPrev(){
			document.prev.submit();
		}
		function goNext(){
			document.next.submit();	
		}
/* 		comment 추후 반영 할 것
		commentTxt = document.getElementsByName("comment")[0]
		function fnInputComment(){
			if (commentTxt.value == "Comment 를 입력하세요!"){
				commentTxt.value="";
			}
		} 

		function fnChangeComment(){
			alreadyTxt = document.getElementsByName("comment")[0].value;
			commentTxt.value = alreadyTxt + " - DB전송 완료";
		}
*/

	</script>
	
<%-- comment 추후 반영 할 것
	<form action="commentPro.jsp" name="commentPro" method="post">
		<input type="text" name="comment" value="Comment 를 입력하세요!" onclick="fnInputComment();" onchange="fnChangeComment();" />
		<input type="hidden" name="keyField" value="<%=keyField %>" />
		<input type="hidden" name="keyWord" value="<%=keyWord %>" />
		<input type="hidden" name="board" value="<%=board %>" />
	</form> 
--%>
<!-- 글수정이나 답글에 필요하고 필요안한 속성은 가감할것 -->
	<form action="List.jsp" name="list" method="post">
		<input type="hidden" name="keyField" value="<%=keyField %>" />
		<input type="hidden" name="keyWord" value="<%=keyWord %>" />
		<input type="hidden" name="board" value="<%=board %>" />
		<input type="hidden" name="nowPage" value="<%=nowPage %>" />
		<input type="hidden" name="nowBlock" value="<%=nowBlock %>" />
		<input type="hidden" name="beginPerPage" value="<%=beginPerPage %>" />
	</form>
	
	<form action="Update.jsp" name="update" method="post">
		<input type="hidden" name="num" />
		<input type="hidden" name="keyField" value="<%=keyField %>" />
		<input type="hidden" name="keyWord" value="<%=keyWord %>" />
		<input type="hidden" name="board" value="<%=board %>" />
		<input type="hidden" name="nowPage" value="<%=nowPage %>" />
		<input type="hidden" name="nowBlock" value="<%=nowBlock %>" />
		<input type="hidden" name="beginPerPage" value="<%=beginPerPage %>" />
		<input type="hidden" name="reload" value="false" />	
	</form>
	
	<form action="Reply.jsp" name="reply" method="post">
		<input type="hidden" name="num" />
		<input type="hidden" name="keyField" value="<%=keyField %>" />
		<input type="hidden" name="keyWord" value="<%=keyWord %>" />
		<input type="hidden" name="board" value="<%=board %>" />
		<input type="hidden" name="nowPage" value="<%=nowPage %>" />
		<input type="hidden" name="nowBlock" value="<%=nowBlock %>" />
		<input type="hidden" name="beginPerPage" value="<%=beginPerPage %>" />
	</form>
	
	<form action="Delete.jsp" name="del" method="post">
		<input type="hidden" name="num" />
		<input type="hidden" name="keyField" value="<%=keyField %>" />
		<input type="hidden" name="keyWord" value="<%=keyWord %>" />
		<input type="hidden" name="board" value="<%=board %>" />
		<input type="hidden" name="nowPage" value="<%=nowPage %>" />
		<input type="hidden" name="nowBlock" value="<%=nowBlock %>" />
		<input type="hidden" name="beginPerPage" value="<%=beginPerPage %>" />	
	</form>
	
	<form action="Read.jsp" name="prev" method="post">
		<input type="hidden" name="num" value="<%=prevNum %>"/>
		<input type="hidden" name="keyField" value="<%=keyField %>" />
		<input type="hidden" name="keyWord" value="<%=keyWord %>" />
		<input type="hidden" name="board" value="<%=board %>" />
		<input type="hidden" name="nowPage" value="<%=nowPage %>" />
		<input type="hidden" name="nowBlock" value="<%=nowBlock %>" />
		<input type="hidden" name="beginPerPage" value="<%=beginPerPage %>" />	
	</form>
	<form action="Read.jsp" name="next" method="post">
		<input type="hidden" name="num" value="<%=nextNum %>"/>
		<input type="hidden" name="keyField" value="<%=keyField %>" />
		<input type="hidden" name="keyWord" value="<%=keyWord %>" />
		<input type="hidden" name="board" value="<%=board %>" />
		<input type="hidden" name="nowPage" value="<%=nowPage %>" />
		<input type="hidden" name="nowBlock" value="<%=nowBlock %>" />
		<input type="hidden" name="beginPerPage" value="<%=beginPerPage %>" />
	</form>
	
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/footer.jsp" />
<!-- 푸터 들어가는 곳 -->
</div>
	
</body>
</html>
