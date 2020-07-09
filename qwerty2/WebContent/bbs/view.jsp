<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/head.jsp" %>

<%
String code = request.getParameter("code");
String uid = request.getParameter("uid");
%>



<%
Connection conn = DriverManager.getConnection(url, user, password);

//조회수 +1 처리
String sql_up = "update "+code+" set ref = ref + 1 where uid = "+uid+"";
Statement stmt_up = conn.createStatement();
stmt_up.executeUpdate(sql_up);//update

//상세페이지 처리
String sql = "select * from "+code+" where uid = "+uid+"";
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);//select

String gongji = "";
String gongji_title = "";
String subject = "";
String comment = "";
String file1_o = "";
String list_id = "";

if(rs.next()){
	list_id = rs.getString("id");
	gongji = rs.getString("gongji");
	subject = rs.getString("subject");
	comment = rs.getString("comment");
	file1_o = rs.getString("file1_o");
	comment = comment.replace("\n","<br>");//개행처리
	
	if(gongji.equals("1")){
		gongji_title = "공지글";
	}else if(gongji.equals("2")){
		gongji_title = "일반글";
	}else{
		gongji_title = "비밀글";
	}
}

//비밀글일 경우
if(!list_id.equals(session_id) && gongji.equals("3")){
%>
	<script>
	alert("다시 확인하세요");
	location.href="/";
	</script>
<%		
}
%>

<table width=600 align=center>
	
</table>
<table width=600 align=center border=0>
	<tr>
		<td width=80>옵션</td>
		<td><%=gongji_title %></td>
	</tr>
	<tr>
		<td width=80>제목</td>
		<td><%=subject %></td>
	</tr>
	<tr>
		<td>내용</td>
		<td>
		<%=comment %></td>
	</tr>
	<tr>
		<td>첨부</td>
		<td>
		<%if(file1_o.equals(null) || file1_o.equals("")){ %>
			첨부없음
		<%}else{ %>
			<a href="/upload/<%=file1_o%>" download><%=file1_o%></a>
		<%} %>
		</td>
	</tr>
</table>



<table width=600 align=center border=0>
	<tr>
		<td align=left><a href="list.jsp?code=<%=code%>">[목록]</a></td>
		<td align=right>
			<a href="reply.jsp?code=<%=code%>&uid=<%=uid%>">[답변]</a>  
			<a href="modify.jsp?code=<%=code%>&uid=<%=uid%>">[수정]</a> 
			<a href="/bbs/delete.jsp?code=<%=code%>&uid=<%=uid%>">[삭제]</a>
			
		</td>
	</tr>
</table>


<%@ include file="/foot.jsp" %>