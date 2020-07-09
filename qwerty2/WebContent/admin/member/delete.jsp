<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/admin/head.jsp" %>

<%

Connection conn = DriverManager.getConnection(url, user, password);
String memberid=request.getParameter("memberid");

//파일삭제
String sql_f = "delete from member3 where memberid='"+memberid+"'";
Statement stmt_f = conn.createStatement();
stmt_f.executeUpdate(sql_f);

String file1_name = "";

%>

<script>
location.href ="/admin/member/list.jsp";
</script>