<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/head.jsp" %>

<%
String code= request.getParameter("code");
String uid= request.getParameter("uid");

String sql = "select * from "+code+" where uid = "+uid+"";
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);//select


String subject = "";
String comment = "";
int fid = 0;
String thread = "";

if(rs.next()){
	subject = rs.getString("subject");
	comment = rs.getString("comment");
	fid = rs.getInt("fid");
	thread = rs.getString("thread");
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

<table width=600 align=center border=0>
	<form name="bbs" action="reply_update.jsp" method="post" enctype="multipart/form-data">
	<input type="hidden" name="code" value="<%=code%>">
	<input type="hidden" name="uid" value="<%=uid%>">
	<input type="hidden" name="fid" value="<%=fid%>">
	<input type="hidden" name="thread" value="<%=thread%>">
		<tr>
		<td width=80>옵션</td>
		<%if(session_level.equals("10")){//관리자 %>
		<td><input type="radio" name="gongji" value="1">공지
		<%} %>
			<input type="radio" name="gongji" value="2" checked>일반
			<input type="radio" name="gongji" value="3">비밀
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
		<td><input type="file" name="file1" value=""></td>
	</tr>
	</form>
	<tr>
		<td></td>
		<td>
		<%if(session_id == null || session_id =="") {%>
			<button onclick="alert('로그인 후 작성하세요')">답변쓰기</button>
			<%}else{ %>
			<button onclick="send()">답변쓰기</button>
			<%} %>
		</td>
	</tr>
</table>

<%@ include file="/foot.jsp" %>