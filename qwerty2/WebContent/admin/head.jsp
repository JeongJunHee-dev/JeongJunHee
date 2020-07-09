<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "java.sql.*"%>
<%@ page import = "java.io.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.text.*"%>

<%@ include file = "/dbconnect.jsp" %>

<%
//post,get넘어온 값 한글처리
request.setCharacterEncoding("utf-8");
%>

<%
//세션 유지 시간 설정
//session.setMaxInactiveInterval(1*60); //1분
//세션값 처리
String session_id = "";
String session_name = "";
String session_level = "";

if(session.getAttribute("id") != null){
	session_id = (String)session.getAttribute("id");//아이디
	session_name = (String)session.getAttribute("name");//이름
	session_level = (String)session.getAttribute("level");//레벨
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/basic2.css"/>
</head>
<body>


<table width=100% height=80 border=1>
	<tr>
		<td width=30% align=center>
			<div class="threesteps">
             	<a href="https://airlinedispatcher.com/">
              	<img class="mk-desktop-logo dark-logo " title="Airline Dispatcher School in the US" alt="Airline Dispatcher School in the US" src="https://airlinedispatcher.com/wp-content/uploads/2018/09/logo-ifod-400-196px.png"> </a> 
         	</div> 
        </td>
        
		<td width=40% align=center>
			<h1>
				<a href="/admin/index.jsp">Air Dispatcher Decision Support & Program
				</a>
			</h1>
		</td>
		
		<td width=30% align=center>
			<div class="threestrps">
            	<a href="https://www.adtcdallas.com/">
           		<img id="comp-jdowcu79imgimage" alt="" data-type="image" itemprop="image" src="https://static.wixstatic.com/media/69147d_107faacfd0484c87ba61dfd1a1d7c572~mv2.png/v1/fill/w_173,h_165,al_c,q_80,usm_0.66_1.00_0.01/69147d_107faacfd0484c87ba61dfd1a1d7c572~mv2.webp" style="width: 173px; height: 165px; object-fit: cover;"> </a> 
            </div>
        </td>
	</tr>

</table>

<table width=100% height=40 border=1>
	<tr>
		<td align=center>
		 	<form>
           		<h1>운항관리 의사지원 시스템</h1>
            	<span><b>구글검색 : </b></span>
            	
            	<script async src="https://cse.google.com/cse.js?cx=005162728813009484516:qfys9q9i86p">
       			</script>
				<div class="gcse-search">
				</div>
            
        	</form>
		</td>
		
		<td>
			 <fieldset>
         		<legend><span><b>Log in Box</b></span></legend>
         			<table>
            	 
          				 <td align="right">  
          				 
          				 	<%if(session_id.equals("")) {//로그인 전%>
                				<a href="member/login.jsp">
                				<input type="button" style="color: #fff; background: gray; font-size: 1.3em; border-radius: 0.5em; padding: 5px 20px;"value="로그인이 필요합니다.">
                				</a><%}else{//로그인 후 %>
                					<a href="/member/logout.jsp">
                					<input type="button" style="color: #fff; background: gray; font-size: 1.3em; border-radius: 0.5em; padding: 5px 20px;"value="로그아웃은 여기입니다.">
                					</a>
                					
                					<a href="/member/member_up.jsp">
                					<input type="button" style="color: #fff; background: gray; font-size: 1.3em; border-radius: 0.5em; padding: 5px 20px;"value="회원수정은 여기입니다.">
                					</a>
                					<p>
                					<input type="box" style="color: #fff; background: gray; font-size: 1.3em; border-radius: 0.5em; padding: 5px 50px; width:350px;"value="아이디 : <%=session_id %>&nbsp 이름 : <%=session_name %>&nbsp 레벨 : <%=session_level %>" disabled="disabled">
                					<p><input type="button" style="color: #fff; background: gray; font-size: 1.3em; border-radius: 0.5em; padding: 5px 20px;"value="관리자 모드" disabled="disabled">
                					
                					<a href="/admin/member/list.jsp?code=notice">
                					<input type="button" style="color: #fff; background: gray; font-size: 1.3em; border-radius: 0.5em; padding: 5px 20px;"value="회원 관리는 여기입니다.">
                					</a>
                				
                			<% }%>
                				
           				</td>
                
         			</table>
         
     		</fieldset>
		</td>
	</tr>
	
</table>

