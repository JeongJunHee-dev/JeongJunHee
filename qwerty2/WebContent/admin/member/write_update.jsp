<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/head.jsp" %>
<%@page import ="com.oreilly.servlet.*"%>
<%@page import ="com.oreilly.servlet.multipart.*"%>
<%@ page import ="java.util.*"%>
<%@ page import ="java.text.*"%>

<%
if(session_id == null || session_id == ""){// 비회원작성 no
	%>
	<script>
		alert('로그인 후 작성하세요');
		history.back();
	</script>
	<%
}
	
//첨부파일 존재할 경우
String uploadPath= "C:\\jsp\\qwerty2\\WebContent\\upload";
int size = 10 * 1024 *1024;

MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());
		
String code= multi.getParameter("code");
String gongji = multi.getParameter("gongji");
String subject = multi.getParameter("subject");
String comment = multi.getParameter("comment");
String file1 = multi.getParameter("file1");


//첨부파일 처리부분
Enumeration files = multi.getFileNames();
file1 = (String)files.nextElement();
String file1_name =multi.getOriginalFileName(file1); //원본 파일명
String file1_rename =multi.getFilesystemName(file1); //리네임 처리된 파일명

if(file1_name ==null){
	file1_name = "";
	file1_rename = "";
}


//날짜
java.util.Date today = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd");
String signdate = cal.format(today);

Connection conn = DriverManager.getConnection(url, user, password);

//아래댓글 처리 칼럼부분
	
	String sql_max = "select max(fid) as fid_max from "+code+"";
	Statement stmt_max = conn.createStatement();
	ResultSet rs_max = stmt_max.executeQuery(sql_max);//select

int fid = 0;

if(rs_max.next()) {
	if(rs_max.getInt("fid_max")>0){//존재 할 경우
		fid= rs_max.getInt("fid_max") + 1;
	}else{//게시물이 첫글일 경우
		fid=1;
	}
	
}
//디비 접근. 입력
String sql = "insert into "+code+" (id,name,subject,comment,gongji,file1,file1_o,signdate,fid,thread) values ('"+session_id+"','"+session_name+"','"+subject+"','"+comment+"','"+gongji+"','"+file1_name+"','"+file1_rename+"','"+signdate+"',"+fid+",'A')";
Statement stmt = conn.createStatement();
//out.print(sql);
stmt.executeUpdate(sql);// insert,update,delete

stmt.close();
conn.close();
%>

<script>
	location.href="list.jsp?code=<%=code%>"
</script>