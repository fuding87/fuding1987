<%@page import="member.MemDao"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardDto"%>
<%@page import="board.BoardDao"%>
<%@page import="java.util.Vector"%>
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

<title>재밌고 달콤한 Fuding 입니다.</title>

<link href="../css/default.css" rel="stylesheet" type="text/css" media="all">

<script type="text/javascript" src="../js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="../js/s3Slider.js"></script>
<script type="text/javascript">
	$(document).ready(function() { 
	   	$('#logoslider').s3Slider({
	      	timeOut: 3000
	 	});
		$('#s3slider').s3Slider({ 
			timeOut: 3500
		}); 
	});
</script>


</head>

<body>
<div id="wrap">

<div class="clear"></div>
<jsp:include page="/member/loginfo.jsp" />

<div class="clear"></div>
<jsp:include page="../inc/header.jsp" />
<!-- 헤더파일들어가는 곳 -->

<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>

<jsp:include page="../inc/slide.jsp" />
<div class="clear"></div>

<!-- 아이콘 보드 만들어서 다른 페이지도 삽인할수 있게 할것 -->
<jsp:include page="../inc/iconBoard.jsp" />

<div class="clear"></div>
<br/>

<%
	// previewboard 에 뿌릴 게시글
	BoardDao dao = new BoardDao();
	Vector<BoardDto> vjava = dao.getBoardList("", "", "javaboard");
	Vector<BoardDto> vjsp = dao.getBoardList("", "", "jspboard");
	Vector<BoardDto> vproject = dao.getBoardList("", "", "projectboard");
	Vector<BoardDto> vask = dao.getBoardList("", "", "askboard");

%>
<!-- 메인 콘텐츠 들어가는 곳 -->
<article>
	<center>
	<table>
		<tr>
		
			<!-- 1번 게시판 Java -->
			<td id="previewMargin">
				<a class="atag" href="../board/List.jsp?board=javaboard" title="JAVA 게시판 이동">
					<h3 id="previewBoard_back">JAVA</h3>
				</a>
				<table width="400px" height="150px">
				<tr>
					<td width="60px">번호</td><td width="240px">제목</td><td width="100px">글쓰닉</td>
				</tr>
				
				<%	
					for(int i=0; i<5; i++){
						String num = "none";
						String subject = "none";
						String nick = "none";
						try {
							BoardDto tmp = (BoardDto)vjava.get(i);
							num = String.valueOf(tmp.getNum());
							subject = tmp.getSubject();
							MemDao mdao = new MemDao();
							nick = mdao.getNickById(tmp.getId());
							if("".equals(nick.trim())){
								nick = "탈퇴함";
							}
				%>
							<tr id="previewContxt">
								<td><%=num %></td>
								<td>
									<a class="atag" href="" onclick="goBoard('<%=num%>','javaboard'); return false;">
										<%=subject %>
									</a>
								</td>
								<td><%=nick %></td>
							</tr>
				<%							
						} catch (Exception e) {
				%>
							<tr id="previewContxt">
								<td></td>
								<td><%=subject %></td>
								<td></td>
							</tr>
				<%
						}

					}
					
				%>
				</table>
			</td>
			
			<!-- 2번 게시판 Jsp -->
			<td id="previewMargin">
				<a class="atag" href="../board/List.jsp?board=jspboard" title="JSP 게시판 이동">
					<h3 id="previewBoard_back">JSP</h3>
				</a>
				<table width="400px" height="150px">
				<tr>
					<td width="60px">번호</td><td width="240px">제목</td><td width="100px">글쓰닉</td>
				</tr>
				<%	
					for(int i=0; i<5; i++){
						String num = "none";
						String subject = "none";
						String nick = "none";
						try {
							BoardDto tmp = (BoardDto)vjsp.get(i);
							num = String.valueOf(tmp.getNum());
							subject = tmp.getSubject();
							MemDao mdao = new MemDao();
							nick = mdao.getNickById(tmp.getId());
							if("".equals(nick.trim())){
								nick = "탈퇴함";
							}							
				%>
							<tr id="previewContxt">
								<td><%=num %></td>
								<td>
									<a class="atag" href="" onclick="goBoard('<%=num%>','jspboard'); return false;">
										<%=subject %>
									</a>
								</td>
								<td><%=nick %></td>
							</tr>
				<%							
						} catch (Exception e) {
				%>
							<tr id="previewContxt">
								<td></td>
								<td><%=subject %></td>
								<td></td>
							</tr>
				<%
						}

					}
					
				%>
					
				</table>
			</td>
		</tr>
		<tr>
			<!-- 3번 게시판 project-->
			<td id="previewMargin">
				<a class="atag" href="../board/List.jsp?board=projectboard" title="Project 게시판 이동">
					<h3 id="previewBoard_back">Project</h3>
				</a>
				<table width="400px" height="150px">
				<tr>
					<td width="60px">번호</td><td width="240px">제목</td><td width="100px">글쓰닉</td>
				</tr>
				<%	
					for(int i=0; i<5; i++){
						int num = 0;
						String subject = "none";
						String nick = "none";
						try {
							BoardDto tmp = (BoardDto)vproject.get(i);
							num = tmp.getNum();
							subject = tmp.getSubject();
							MemDao mdao = new MemDao();
							nick = mdao.getNickById(tmp.getId());
							if("".equals(nick.trim())){
								nick = "탈퇴함";
							}							
				%>
							<tr id="previewContxt">
								<td><%=num %></td>
								<td>
									<a class="atag" href="" onclick="goBoard('<%=num%>','projectboard'); return false;">
										<%=subject %>
									</a>
								</td>
								<td><%=nick %></td>
							</tr>
				<%							
						} catch (Exception e) {
				%>
							<tr id="previewContxt">
								<td></td>
								<td><%=subject %></td>
								<td></td>
							</tr>
				<%
						}

					}
					
				%>
						
				</table>			
			</td>
			<!-- 4번 게시판 ask -->
			<td id="previewMargin">
				<a class="atag" href="../board/List.jsp?board=askboard" title="요청 게시판 이동">
					<h3 id="previewBoard_back">요청</h3>
				</a>
				<table width="400px" height="150px">
				<tr>
					<td width="60px">번호</td><td width="240px">제목</td><td width="100px">글쓰닉</td>
				</tr>
				<%	
					for(int i=0; i<5; i++){
						String num = "none";
						String subject = "none";
						String nick = "none";
						try {
							BoardDto tmp = (BoardDto)vask.get(i);
							num = String.valueOf(tmp.getNum());
							subject = tmp.getSubject();
							MemDao mdao = new MemDao();
							nick = mdao.getNickById(tmp.getId());
							if("".equals(nick.trim())){
								nick = "탈퇴함";
							}							
				%>
							<tr id="previewContxt">
								<td><%=num %></td>
								<td>
									<a class="atag" href="" onclick="goBoard('<%=num%>','askboard'); return false;">
										<%=subject %>
									</a>
								</td>
								<td><%=nick %></td>
							</tr>
				<%							
						} catch (Exception e) {
				%>
							<tr id="previewContxt">
								<td></td>
								<td><%=subject %></td>
								<td></td>
							</tr>
				<%
						}

					}
					
				%>
			
				</table>			
			</td>
		</tr>
	</table>
	</center>
</article>


<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/footer.jsp" />
<!-- 푸터 들어가는 곳 -->
<div class="clear"></div>


</div>

<form action="../board/Read.jsp" name="read" method="post">
	<input type="hidden" name="num" />
	<input type="hidden" name="board" />
	<input type="hidden" name="keyField" value="" />
	<input type="hidden" name="keyWord" value="" />
	<input type="hidden" name="nowPage"  value=0 />
	<input type="hidden" name="nowBlock" value=0 />

</form>

<script type="text/javascript">
	function goBoard(num,board){
		document.read.num.value = num;
		document.read.board.value = board;
		document.read.submit();
	}
</script>

</body>
</html>
