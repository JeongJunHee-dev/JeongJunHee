<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/head.jsp" %>


<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String pass1 = request.getParameter("pass1");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String zipcode = request.getParameter("zipcode");
	String add1 = request.getParameter("addr1");
	String add2 = request.getParameter("addr2");
	String add3 = request.getParameter("addr3");
	String add4 = request.getParameter("addr4");
	String phone = request.getParameter("phone");

	//비밀번호 값이 있다면
	if (!pass.equals(pass1)){
%>
		<script>
		alert("비밀번호를 입력하세요");
		history.go(-1);
		//history.back();
		</script>
<%
	}
	//디비 접근. 입력
	String sql = "";
	if(pass.equals("")) 
	{
		sql = "update member3 set membername='"+name+"', email='"+email+"',zipcode='"+zipcode+"', addr1='"+add1+"',addr2='"+add2+"', addr3='"+add3+"',addr4='"+add4+"' ,phone='"+phone+"' where memberid='"+session_id+"'";
	}else{
		sql = "update member3 set membername='"+name+"', email='"+email+"',zipcode='"+zipcode+"', addr1='"+add1+"',addr2='"+add2+"', addr3='"+add3+"', addr4='"+add4+"',phone='"+phone+"',memberpass='"+pass+"' where memberid='"+session_id+"'";
	}
	//out.print(sql);
	Connection conn = DriverManager.getConnection(url, user, password);
	Statement stmt = conn.createStatement();
	stmt.executeUpdate(sql);
	
%>
<script>
	location.href="/member/member_up.jsp";
</script>
