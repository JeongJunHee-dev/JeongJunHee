<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/admin/head.jsp" %>


<%
//페이징 처리~~~!
int page_now = 1;// 현제 페이지 변수
int num_per_page = 3;//한페이지당 출력할 게시물 수
int page_per_block = 3; //한페이지당 출력할 링크 수
int first=0; //limit 시작값
int total_page=0;//총 페이지 수  //페이징 처리 2
//검색 여부 따라 게시물수 변경
String field ,search;//검색변수 선언
String sql;
String sql_list;


if(request.getParameter("page_now") != null){
	page_now = Integer.parseInt(request.getParameter("page_now"));	
}else{
	page_now =1;
}
Connection conn = DriverManager.getConnection(url, user, password);
//총 개시물 수 출력하기
if(request.getParameter("search") != null){
	field = request.getParameter("field");
	search = request.getParameter("search");
	sql = "select count(*) as total_count from member3 ";
	sql = sql +  "where "+field+" like '%"+search+"%' ";

	
}else{
	field = "";
	search = "";
	sql = "select count(*) as total_count from member3";
}
	Connection con = DriverManager.getConnection(url, user, password);
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery(sql);//select
	
	int total_record=0;
	if(rs.next()){
	total_record = rs.getInt("total_count");
	}
	total_page = (int)Math.ceil(total_record / (double)num_per_page);
	first = num_per_page * (page_now -1);


//회원 리스트 출력 1 // 검색어 검색/ 회원 페이지 넘기기
	if(request.getParameter("search") !=null){
		field = request.getParameter("field");
		search = request.getParameter("search");
		sql_list = " select * from member3 where "+field+" like '%"+search+"%' order by memberid desc";
		sql_list += " limit "+first+","+num_per_page+"";
	}else{
		search="";
		field="";
		sql_list = " select * from member3 order by memberid desc";
		sql_list += " limit "+first+","+num_per_page+"";
	}
	
	Statement stmt_list = con.createStatement();
	ResultSet rs_list = stmt_list.executeQuery(sql_list);//sel<ect
	int k = total_record -((page_now -1) * num_per_page);
   
%>
<table align="center" border=0>

<tr>
<td>총 회원수: </td>
<td><%=total_record %></td>
<td></td>
<td></td>
</tr>

<tr>
	<td></td>
	<td>아이디</td>
	<td>패스워드</td>
	
	<td>이름</td>
	<td>연락처</td>
</tr>
<%
//회원 리스트 출력2
while(rs_list.next()){
	String memberid = rs_list.getString("memberid");
	String memberpass = rs_list.getString("memberpass");
	String membername = rs_list.getString("membername");
	String phone = rs_list.getString("phone");
%>
<tr>
	<td align=center><%=k %></td>
	<td><%=memberid %></td>
	<td><%=memberpass %></td>
	<td><%=membername %></td>
	<td><%=phone %></td>
	<td><a href="/admin/member/modify.jsp?memberid=<%=memberid%>">회원수정</a></td>
	<td><a href="/admin/member/delete.jsp?memberid=<%=memberid%>">회원삭제</a></td>
</tr>
<%
k--;
}
%>
<tr>
	<td></td>
</tr>

</table>
<%
int total_block =0;//총 블럭수
int block =0;//블럭수
int first_page=0;
int last_page=0;
int direct_page=0;
int my_page=0;

total_block =  (int)Math.ceil(total_page /(double)page_per_block);
block = (int)Math.ceil(page_now / (double)page_per_block);
first_page = (block -1) * page_per_block;
last_page = block * page_per_block;
/*out.print("total_block:"+total_block);
out.print("block:"+block);
out.print("first_page:"+first_page);
out.print("last_page:"+last_page);*/

%>

<table width=600 align=center>
<tr>
	<td >
<% 
//이전 블럭
if(block == 1){
	out.print("[<<]");
}else{
	my_page = first_page;
%>
	<a href="/admin/member/list.jsp?page_now=<%=my_page%>">[<<]</a>
<%	
}
//현재 블럭 페이징 수 출력
for(direct_page=first_page+1; direct_page<=last_page; direct_page++){
	if(page_now == direct_page){
%>
	<b>[<%=direct_page %>]</b>
<%		
	}else{
%>
	<a href="/admin/member/list.jsp?page_now=<%=direct_page%>"><%=direct_page %></a>
<%
	}
}
//다음 블럭
if(block < total_block){
	my_page = last_page + 1;
%>
	<a href="/admin/member/list.jsp?page_now=<%=my_page%>">[>>]</a>
<%	
}else{

	out.print("[>>]");

}	
%>	
	</td>
</tr>
</table>
<table width=600 align=center>
<form  action="/admin/member/list.jsp" method="post">
	<tr>
		<td width=40% align=right>
			<select name="field">
				<option value="memberid">ID</option>
				<option value="membername">이름</option>
				<option value="phone">핸드폰</option>
			</select>
		</td>
 		<td><input name="search" value="<%=search%>"></td>  
		<td width=40% align=left><input type="submit" value="검색"></td>
	</tr>
	</form>
</table>

<%@ include file="/admin/foot.jsp" %>