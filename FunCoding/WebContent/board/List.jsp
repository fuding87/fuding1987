<%@page import="member.MemDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardDto"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<HTML>
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
<title>Board</title>
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
	//현재 List.jsp페이지의 검색란에 검색어를 입력 했다면 그 검색어 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 현재 게시판 이름 획득
	String board = request.getParameter("board");
%>

</head>
<script>
	function check(){
		if(document.search.keyWord.value == ""){
			alert("검색어를 입력하세요.");
			document.search.keyWord.focus();
			return;
		}
		document.search.submit();
	}
	
	function fnList(){
		document.list.action = "List.jsp?board=<%=board%>";
		document.list.submit();
	}
	
	function fnRead(num) {
		document.read.num.value = num;
		document.read.submit();
	}
	
</script>

<style type="text/css">
	#imageText{
		font-size: 70px;
	}
	.tdmaring{
		margin: 0 0 0 0;
	}
</style>
<BODY>

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
<%-- 순서1. 추가! DB작업을 하기 위해서 BoardDao객체 생성 --%>
<jsp:useBean id="dao" class="board.BoardDao" />
<%-- -----------------------순서1. 끝----------------------- --%>

<%-- 순서2. 추가!! ----------------------- --%>
<%
	String keyWord="", keyField="";
	//[1] 페이징을 위한 변수 선언
	int totalRecord = 0; //게시판에 저장된 전체 글의 갯수[2]
	int numPerPage = 10;//한페이지당 보여질 글의 갯수
	int pagePerBlock =3;//한블럭당 묶여질 페이지수 
	
	int totalPage = 0; //전체 페이지 수[4]
	int totalBlock = 0; //전체 블럭수[9]
	int nowPage = 0; //현재 보여질 페이지 번호 저장[7]
	int nowBlock = 0; //현재 보여질 페이지의 블럭위치를 저장[8]
	int beginPerPage = 0; //각 페이지의 시작 글 번호를 저장하는 변수[10]
	//===============================================[1]끝
%>
<%	
	//만약 검색어가 입력 되었다면?
	if(request.getParameter("keyWord")!=null){

		//검색기준값 받아와서 저장
		keyField = request.getParameter("keyField");
		//검색어 받아와서 저장
		keyWord = request.getParameter("keyWord");
	}
	//[처음으로]링크를 클릭했을때...(List.jsp페이지를 재요청했을때..)
	//input태그의 hidden으로 요청한 name이 reload인 값이 존재하고!
	if(request.getParameter("reload")!=null){
		//만약 List.jsp페이지로 다시 요청 받은 값이 true와 같을때..
		if(request.getParameter("reload").equals("true")){
			keyWord = ""; //검색어를 비워둔다.
		}
	}
	Vector v = dao.getBoardList(keyField, keyWord, board);
	Vector vTotal = dao.getBoardList(keyField, "", board); //전체글수 표시를 위해서
	totalRecord = v.size();

	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);
	
	//[9] 전체 클릭 수 구하기 = 전체 페이지수 / 한 블럭당 묶어질 페이지수	
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);

	if(request.getParameter("nowPage") != null){
		//1 2 3 4 5 중에서 현재 선택한 페이지 번호를 얻어서 저장
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}

	//[8] 현재 보여질 블럭 번호 구하기 ~~ 
	if(request.getParameter("nowBlock")!=null){
		nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	}
	
	beginPerPage = nowPage * numPerPage;
	//위의 변수를 구하는 이유 : 각페이지마다 보여질 글들을 분할해서 보여주기 위해 구했음

%>
<br/>
<table>
	<tr>
		<td><img class="tdmaring" alt="" src="../images/<%=board%>.png" width="200px" height="100px"></td>
		<td><h1 id="imageText" class="tdmaring" >&nbsp;게시판</h1></td>
	</tr>
</table>
<br/>

<table align=center border=0 width=80%>
<tr>
	<%-- [3] 게시판에 저장된 전체글 개수 totalRecord --%>
	<td align=left>Total : <%=totalRecord %>  Articles(
					<%--[6]현재 보여지는 페이지 번호 / [5] 전체 페이지수  --%>
		<font color=red>  <%=nowPage + 1 %> /  <%=totalPage %> Pages </font>)
	</td>
</tr>
</table>

<table align=center width=80% border=0 cellspacing=0 cellpadding=3>
<tr>
	<td align=center colspan=2>
		<table border=1 width=100% cellpadding=2 cellspacing=0>
			<tr align=center bgcolor=#D0D0D0 height=120%>
				<th width="40"> No. </th>
				<td width="400"> 제목 </td>
				<td width="100"> 글쓰닉 </td>
				<td width="100"> 날짜 </td>
				<td width="40"> 조회 </td>
			</tr>	

			<%
				//날짜형식을 지정할수 있는 객체
				SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd");
				
				//만약 벡터안에 글들(DTO객체들)이 하나라도 존재하지 않으면?
				if(v.isEmpty()){ //비어있다면?
			%>
			<tr>
				<td colspan="5" align="center">등록된 글이 없습니다.</td>
			</tr>
			<%
				}else{
			
					for (int i=beginPerPage; i<(beginPerPage + numPerPage); i++){
						//만약 i가 총글의 개수와 같아지면, 반복문 중지!!
						if(i==totalRecord){
							break;
						}

						BoardDto dto = (BoardDto)v.get(i); //object 타입으로 반환하기 때문에 class 캐스팅 가능

						int depth = dto.getDepth();
						
						MemDao mdao = new MemDao(); // id값을 이용해서 닉값을 반환받기 위해서
						
			%>
						<tr>
							<td align="left">&nbsp;<%=dto.getNum() %>  </td>
							<!-- Read 1.게시판 글리스트중에서 글제목 링크를 클릭했을때.. 함수호출시 글번호 전달하여 form 태그 실행 -->
							<td align="left">&nbsp;<%=dao.useDepth(depth) %>
								<a class="aTag" href="Read.jsp" onclick="fnRead('<%=dto.getNum() %>'); return false;">
									&nbsp;<%=dto.getSubject() %>
								</a>  
							</td>
							<td align="left">&nbsp;<%=mdao.getNickById(dto.getId()) %>  </td> 
							<td align="left">&nbsp;<%=s.format(dto.getRegdate()) %>  </td> 
							<td align="left">&nbsp;<%=dto.getCount() %>  </td>
						</tr>
			<%
					}
				}
			%>
			
		</table>
		<hr/>
			<tr>
				<td colspan="5" align="center">전체 등록된 글이 <%=vTotal.size() %> 개 입니다.</td>
				<!-- colspan="5" 하나의 td 가 5td개의 td 사이즈로 인식 -->
			</tr>
	</td>
</tr>

<tr>
	<td align="left">Go to Page 
	<%
		//[15] 게시판에 글이 하나라도 존재 하고..
		if(totalBlock>0){//현재블럭의 위치가 적어도 0보다 클때.. 이전으로 이동할 블럭이 있다는 뜻이므로..
			//◀◀◀ 이전 링크를 나타나게 할수 있음
			if(nowBlock>0){
	%>
				<%--[16] 이전 3개 링크를 눌렀을때.. 이전 블럭번호와 이전블럭의 시작페이지번호를 
				List.jsp에 넘겨준다. --%>
				<a class="atag" href="List.jsp?board=<%=board%>&nowBlock=<%=nowBlock-1%>&nowPage=<%=(nowBlock-1)*pagePerBlock%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>">
					이전 <%=pagePerBlock %>개◀◀◀
				</a>
	<% 		
			}

		}
	%>	

	<%
		for(int cnt=0; cnt<pagePerBlock; cnt++){ //3번씩 반복
			//현재 보여질 페이지 번호가 == 전체 페이지 수와 같을때.. 3번 반복하지 않고 빠져나감
			if((nowBlock * pagePerBlock)+cnt==totalPage){
				break;
			}
	%>

		<a class="atag" href="List.jsp?board=<%=board%>&nowBlock=<%=nowBlock%>&nowPage=<%=(nowBlock*pagePerBlock)+cnt%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>"> 
		<%=(nowBlock*pagePerBlock)+1+cnt%>
		</a>
	<%
			if((nowBlock*pagePerBlock)+1+cnt == totalRecord){
				break;
			}//if 문 끝
		} // for문 끝
	%>
	
	<%

		if(totalBlock>nowBlock+1){//전체블럭이 더크므로.. 이동할 블럭이 있으면?
	%>
			<a class="atag" href="List.jsp?board=<%=board%>&nowBlock=<%=nowBlock+1%>&nowPage=<%=(nowBlock+1)*pagePerBlock%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>">
				▶▶▶ 다음 <%=pagePerBlock %> 개
			</a>
	<% 
		}
	%>	
	
	</td>
	<td align=right>
		<a  class="aTag"  href="Post.jsp?board=<%=board%>">[새글작성]</a>
		<a  class="aTag"  href="" onclick="fnList(); return false;">[전체글]</a>
	</td>
</tr>
</table>

<form action="List.jsp?board=<%=board%>" name="search" method="post">
	<table border=0 width=527 align=center cellpadding=4 cellspacing=0>
	<tr>
		<td align=center valign=bottom>
			<select name="keyField" size="1">
				<option value="nick"> 닉네임
				<option value="subject"> 제목
				<option value="content"> 내용
			</select>

			<input type="text" size="16" name="keyWord" value="<%=keyWord%>">
			<input type="button" value="찾기" onClick="check()">
			<input type="hidden" name="page" value= "0">
		</td>
	</tr>
	</table>
	
</form>
</center>	

<form name="list" method="post">
	<input type="hidden" name="reload" value="true" />
</form>

<form action="Read.jsp" name="read" method="post">
	<input type="hidden" name="num" />
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
</BODY>
</HTML>