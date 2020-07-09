<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/head.jsp" %>
   <%
    request.setCharacterEncoding("utf-8");
    
    String username = request.getParameter("username"); 
    String pass = request.getParameter("password"); 

	String sql = "select * from member3 where memberid = '" + username + "' and memberpass = '"+pass+"'";
	Connection conn = DriverManager.getConnection(url, user, password);
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(sql);//select
	
	String memberid = "";
	String memberpass = "";
	String membername = "";
	String memberlevel = "";
	if(rs.next()) {
		memberid = rs.getString("memberid");
		memberpass = rs.getString("memberpass");
		membername = rs.getString("membername");
		memberlevel = rs.getString("level");
	}
	out.print(memberid);
	
	if(memberid.equals("")){
	%>		
	<script>
	alert("아이디가 없거나 비밀번호가 일치하지 않습니다.");
	</script>
	<%
	}else{
		session.setAttribute("id", memberid);
		session.setAttribute("name", membername);
		session.setAttribute("level", memberlevel);
	}
    %>
    <script>
    location.href="/";
    
    </script>
  