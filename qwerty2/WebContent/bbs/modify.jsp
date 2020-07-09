<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/head.jsp" %>

<%
String code = request.getParameter("code");
String uid = request.getParameter("uid");
%>



<%
Connection conn = DriverManager.getConnection(url, user, password);
String sql = "select * from "+code+" where uid = "+uid+"";
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);//select

String gongji = "";
String subject = "";
String comment = "";
String file1_o = "";

if(rs.next()){
	gongji = rs.getString("gongji");
	subject = rs.getString("subject");
	comment = rs.getString("comment");
	file1_o = rs.getString("file1_o");
}
%>

<script>
	function send(){
		if(document.bbs.subject.value == ""){
			alert("제목 입력하세요.");
			document.bbs.subject.focus();
			return;
		}
		if(document.bbs.comment.value == ""){
			alert("내용 입력하세요.");
			document.bbs.comment.focus();
			return;
		}
		document.bbs.submit();
	}
</script>
<table width=600 align=center>
	
</table>
<table width=600 align=center border=0>
	<form name="bbs" action="modify_update.jsp" method="post" enctype="multipart/form-data">
	<input type="hidden" name="code" value="<%=code%>">
	<input type="hidden" name="uid" value="<%=uid%>">
	<tr>
		<td width=80>옵션</td>
		<td>
			<%if(session_level.equals("10")){//관리자 %>
			<input type="radio" name="gongji" value="1" <%if(gongji.equals("1")){%>checked<%}%>>공지 
			<%} %>
			<input type="radio" name="gongji" value="2" <%if(gongji.equals("2")){%>checked<%}%>>일반 
			<input type="radio" name="gongji" value="3" <%if(gongji.equals("3")){%>checked<%}%>>비밀 
		</td>
	</tr>
	<tr>
		<td width=80>제목</td>
		<td><input type="text" name="subject" value="<%=subject %>" style="width:100%"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea name="comment" style="width:100%; height:150px;"><%=comment %></textarea></td>
	</tr>
	<tr>
		<td>첨부</td>
		<td><input type="file" name="file1" value=""><%=file1_o %></td>
	</tr>
	</form>
	<tr>
		<td></td>
		<td>
			<%if(session_id == null || session_id == ""){ %>
			<button onclick="alert('로그인후 작성하세요.')">글쓰기</button>
			<%}else{ %>
			<button onclick="send()">글쓰기</button>
			<%} %>
		</td>
	</tr>
</table>



