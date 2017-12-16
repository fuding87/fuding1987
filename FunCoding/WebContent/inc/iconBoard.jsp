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

<!-- 전부다 list.jsp 페이지로 이동시키는데 ../board/List.jsp?page= 이런식으로 넘겨준다.-->
<div id="iconBoard">
	<table>
		<tr>
			<td>
				<a href="../board/List.jsp?board=javaboard" title="자바 관련">
					<img src="../images/javaboard.png" width="60px" height="30px" id="javaicon" />
				</a>
			</td>
			<td>
				<a href="../board/List.jsp?board=jspboard" title="JSP 관련">
					<img src="../images/jspboard.png" width="60px" height="30px" id="jspicon" />
				</a>
			</td>
			<td>
				<a href="../board/List.jsp?board=sqlboard" title="SQL 관련">
					<img src="../images/sqlboard.png" width="60px" height="30px" id="sqlicon" />
				</a>
			</td>
			<td>
				<a href="../board/List.jsp?board=itnewsboard" title="IT 소식 관련 ">
					<img src="../images/itnewsboard.png" width="60px" height="30px" id="itnewsicon" />
				</a>
			</td>			
			<td>
				<a href="../board/List.jsp?board=algorithmboard" title="알고리즘 관련 ">
					<img src="../images/algorithmboard.png" width="60px" height="30px" id="algorithmicon" />
				</a>
			</td>
			<td>
				<a href="../board/List.jsp?board=galleryboard" title="갤러리 게시판">
					<img src="../images/galleryboard.png" width="60px" height="30px" id="galleryicon" />
				</a>
			</td>
			<td>
				<a href="../board/List.jsp?board=databoard" title="자료실">
					<img src="../images/databoard.png" width="60px" height="30px" id="dataroomicon" />
				</a>
			</td>				
			<td>
				<a href="../board/List.jsp?board=projectboard" title="개인 프로젝트 소개 ">
					<img src="../images/projectboard.png" width="60px" height="30px" id="projecticon" />
				</a>
			</td>
			<td>
				<a href="../board/List.jsp?board=askboard" title="주인장에게 요청하기">
					<img src="../images/askboard.png" width="60px" height="30px" id="askicon" />
				</a>
			</td>				
			<td>
				<a href="../board/List.jsp?board=etcboard" title="잡담 게시판">
					<img src="../images/etcboard.png" width="60px" height="30px" id="etcicon" />
				</a>
			</td>
			<td>
				<a href="../underconstruction/construction.jsp" title="유용한 사이트 연결">
					<img src="../images/link.png" width="60px" height="30px" id="lingicon" />
				</a>
			</td>				
			<td>
				<a href="../board/hostInfo.jsp" title="주인장 소개 페이지">
					<img src="../images/hostinfo.png" width="60px" height="30px" id="hostinfoicon" />
				</a>
			</td>
		</tr>
	</table>
</div>