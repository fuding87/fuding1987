<%@page import="java.util.Vector"%>
<%@page import="member.MemDao"%>
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

<%	
	request.setCharacterEncoding("utf-8");
	String name = (String)session.getAttribute("name");
	Vector v = (Vector)session.getAttribute("v");
%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 정보 찾기 페이지</title>

<style type="text/css">

#name{
	border-left: 0px;
	border-right: 0px;
	border-top: 0px;
	border-left: 2px;
	border-bottom-color: red;
	height: 30px;
}
#btn{
	width: 100px;
	height: 30px;
	border-radius: 10px;
}
#search_in_txt{
	color : blue;
}
#emailAddress{
	font-size: 120%;
}

h3{
	margin: 10px 0 0 0;
	font-size: 150%;
}
h4{
	margin: 10px 0 0 0;
	font-size: 120%;
}
#emailAddress:hover{color: #F90}

</style>

</head>

<body>

	<form action="../member/searchIdPwProc.jsp" id="search_form">
		<h2>이름을 입력하세요</h2>
		<div>
			<input type="text" name="name" id="name" />
			<input type="submit" id="btn" value="Email 찾기" />
		</div>
		<div>
			<span id="search_in_txt">이름을 입력하면 메일 주소 목록이 조회됩니다.</span><br/>
			<span id="search_in_txt">아래 화면에서 자신의 Email을 선택하면 </span><br/>
			<span id="search_in_txt">선택된 Email로 비밀번호를 보내 드립니다.</span><br/>
		</div>
		<hr/>
		<h3>Email 목록</h3>
		<h4>검색 이름 : <%=name %></h4>
	 	<%
	 		
	 		// name 이 null 이 아니면 mail list 보여줄것
			if (name != null){
				if(v.isEmpty()){
		%>			
					<span id="emailAddress" > 검색 값이 없습니다. <br/>
					이름 또는 가입 여부 확인하세요 </span>
		<%					
				} else {
					for(int i=0; i<v.size(); i++){
						String emailAddress = (String)v.get(i);
		%>			
						<%=i+1 %>번. <a class="atag" href="../member/sendEmailToFindPw.jsp?to=<%=emailAddress %>"
											id="emailAddress" > <%=emailAddress %> </a><br/>
		<%
					}
				}		
			}
		%>	
			
	</form>
</body>

<style type="text/css">
	.atag{
		text-decoration: none;
	}
</style>

</html>