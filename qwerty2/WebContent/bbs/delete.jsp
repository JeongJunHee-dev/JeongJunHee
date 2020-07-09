<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/head.jsp" %>
<%@ page import = "java.io.*" %>

<%
String code= request.getParameter("code");
String uid= request.getParameter("uid");

Connection conn = DriverManager.getConnection(url, user, password);

//파일삭제
String sql_f = "select * from "+code+" where uid = "+uid+"";
Statement stmt_f = conn.createStatement();
ResultSet rs = stmt_f.executeQuery(sql_f);//select

String file1_name = "";

if(rs.next()) {
	file1_name = rs.getString("file1_o");
}


String uploadPath= "C:\\jsp\\qwerty2\\WebContent\\upload";

File f = new File(uploadPath + "\\" + file1_name);		
		if(f.exists()){
			f.delete();
			System.out.print(file1_name);
			System.out.print("파일 삭제 됨");
		}
		
//디비 삭제
String sql = "delete from "+code+" where uid="+uid+"";
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>

<script>
	location.href="list.jsp?code=<%=code%>";
</script>