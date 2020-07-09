<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/head.jsp" %>

<%
String code = request.getParameter("code");//테이블 명
%>



<%
//페이징 처리 1
int page_now = 1;//현재 페이지 변수
int num_per_page = 5;//한 페이지당 출력할 게시물 수
int page_per_block = 2;//한 블럭당 출력할 링크 수
int first = 0;//limit 시작 값
int total_page = 0;//총 페이지 수
int total_record = 0;//총 게시물 수 변수
//검색 여부
String field, search;//검색 변수 선언
String sql = "";
String sql_list = "";


if(request.getParameter("page_now") != null){
	page_now = Integer.parseInt(request.getParameter("page_now"));
}else{
	page_now = 1;
}

//총게시물 수 1
if(request.getParameter("search") != null){
	field = request.getParameter("field");
	search = request.getParameter("search");
	
	sql = "select count(*) as total_count from "+code+"";
	sql = sql + " where gongji != 1 and "+field+" like '%"+search+"%'";
}else{
	field = "";
	search = "";
	sql = "select count(*) as total_count from "+code+" where gongji != 1";
}

//총게시물 수 2
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);//select

if(rs.next()){
	total_record = rs.getInt("total_count");
}

//페이징 처리 2
total_page = (int)Math.ceil( total_record / (double)num_per_page);
first = num_per_page * (page_now - 1);//페이징 수가 달라질 경우

//출력
//out.print("총 페이지 수 : "+total_page+"<br>");
%>
<table width=600 align=center>
	<tr>
		
	</tr>
</table>
<table width=600 align=center>
	<tr><td colspan=4>Total : <%=total_record %></td></tr>
	<tr><td colspan=4 bgcolor=black width=100% height=1></td></tr>
	<tr>
		<td width=50 align=center>No</td>
		<td width=360>제목</td>
		<td width=100 align=center>글쓴이</td>
		<td width=80 align=center>조회수</td>
	</tr>
	<tr><td colspan=4 bgcolor=black width=100% height=1></td></tr>
<%
//공지사항 출력
if(page_now == 1){//1페이지에서만 출력처리
	
String sql_goji = "select * from "+code+" where gongji = 1";
Connection conn_goji = DriverManager.getConnection(url, user, password);
Statement stmt_goji = conn_goji.createStatement();
ResultSet rs_goji = stmt_goji.executeQuery(sql_goji);

	while(rs_goji.next()){
		int uid = rs_goji.getInt("uid");
		String subject = rs_goji.getString("subject");
		String id = rs_goji.getString("id");
		int ref = rs_goji.getInt("ref");
%>
	<tr bgcolor=eeeeee>
		<td align=center>[공지]</td>
		<td><a href="/bbs/view.jsp?code=<%=code%>&uid=<%=uid%>"><%=subject %></a></td>
		<td align=center><%=id %></td>
		<td align=center><%=ref %></td>
	</tr>
	<tr>
		<td colspan=4 width=100% height=1 bgcolor="#dddddd"></td>
	</tr>
<%	
	}
}//if 닫기

//리스트 출력
if(request.getParameter("search") != null){
	field = request.getParameter("field");
	search = request.getParameter("search");
	
	sql_list = "select * from "+code+" ";
	sql_list += " where gongji != 1 and "+field+" like '%"+search+"%'";
	sql_list += " order by fid desc, thread asc";
	sql_list += " limit "+first+","+num_per_page+"";
}else{
	field = "";
	search = "";
	
	sql_list = "select * from "+code+" where gongji != 1 order by fid desc, thread asc";
	sql_list += " limit "+first+","+num_per_page+"";
}

//리스트 출력 2
Connection conn_list = DriverManager.getConnection(url, user, password);
Statement stmt_list = conn_list.createStatement();
ResultSet rs_list = stmt_list.executeQuery(sql_list);

//int j = 0;//
int k = total_record - ((page_now -1) * num_per_page);//NO 처리

//객체 2개 생성
java.util.Date today_list, day_22;

//2일전 새로운글 아이콘 처리
java.util.Date today = new java.util.Date();
java.util.Date day2 = new java.util.Date(today.getTime() - (long)(1000*60*60*24*2));
SimpleDateFormat bbb = new SimpleDateFormat("yyyy-MM-dd");
String day_2 = bbb.format(day2);

while(rs_list.next()){
	int uid = rs_list.getInt("uid");
	String gongji = rs_list.getString("gongji");
	String subject = rs_list.getString("subject");
	String id = rs_list.getString("id");
	int ref = rs_list.getInt("ref");
	String signdate = rs_list.getString("signdate");
	String thread = rs_list.getString("thread");
	
	//2일전 날짜
	day_22 = new SimpleDateFormat("yyyy-MM-dd").parse(day_2);
	//입력날짜	
	today_list = new SimpleDateFormat("yyyy-MM-dd").parse(signdate);
	
	String new_day = "";
	if(today_list.getTime() > day_22.getTime()){
		new_day = "<img src='/bbs/img/main_new.gif'>";
	}else{
		new_day = "";
	}
	
	int len_sub = subject.length();
	if(len_sub > 24){
		subject = subject.substring(0,24) + "...";
	}else{
		subject =subject;
	}
%>	
	<tr>
		<td align=center><%=k %></td>
		<td>
			<%//답변처리
			if(thread.length() > 1){
				for(int i=1; i<=thread.length(); i++){
					out.print("&nbsp");
				}out.print("<img src='/bbs/img/thread_new.gif'>");
			}
			%>
			<%if(gongji.equals("3")){ %>
				<%if(id.equals(session_id)){ %>
				<a href="/bbs/view.jsp?code=<%=code%>&uid=<%=uid%>"><%=subject %></a>
				<img src="/bbs/img/icon_secret.gif">
				<%}else{ %>
				:: 비밀글 입니다. ::
				<%} %>
			<%}else{ %>				
			<a href="/bbs/view.jsp?code=<%=code%>&uid=<%=uid%>"><%=subject %></a>
			<%} %>
			<%=new_day %>
		</td>
		<td align=center><%=id %></td>
		<td align=center><%=ref %></td>
	</tr>
	<tr>
		<td colspan=4 width=100% height=1 bgcolor="#dddddd"></td>
	</tr>
<%
	k--;
}
%>
</table>
<table width=600 align=center>
	<tr>
		<td><a href="/bbs/list.jsp?code=<%=code%>">[새로고침]</a></td>
		<td align=right><a href="/bbs/write.jsp?code=<%=code%>">[글쓰기]</a></td>
	</tr>
</table>
<%
int total_block = 0; //총 블럭수
int block = 0; //블럭수
int first_page = 0;
int last_page = 0;
int direct_page = 0;
int my_page = 0;
// 4/2 = 2
total_block = (int)Math.ceil(total_page / (double)page_per_block);
block = (int)Math.ceil(page_now /(double)page_per_block);//2
first_page = (block -1) * page_per_block;//2
last_page = block * page_per_block;//4
%>
<table width=600 align=center>
	<tr>
		<td align=left>Total page : <%=total_page %></td>
		<td align=center>
<%
if(total_block <= block){
	last_page = total_page;
}
//이전 블럭
if(block == 1){
	out.print("[<<]");
}else{
	my_page = first_page;
%>
	<a href="/bbs/list.jsp?code=<%=code%>&page_now=<%=my_page%>">[<<]</a>
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
	<a href="/bbs/list.jsp?code=<%=code%>&page_now=<%=direct_page%>"><%=direct_page %></a>
<%
	}
}

//다음 블럭
if(block < total_block){
	my_page = last_page + 1;
%>
	<a href="/bbs/list.jsp?code=<%=code%>&page_now=<%=my_page%>">[>>]</a>
<%	
}else{
	out.print("[>>]");
}
%>		
		</td>
	</tr>
</table>
<form action="/bbs/list.jsp?code=<%=code %>" method="post">
<table width=600 align=center>
	<tr>
		<td width=40% align=right>
			<select name="field">
				<option value="subject">제목</option>
				<option value="comment">내용</option>
				<option value="memberid">아이디</option>
			</select>
		</td>
		<td><input name="search" value="<%=search%>"></td>
		<td width=40% align=left><input type="submit" value="검색"></td>
	</tr>
</table>
</form>

<%@ include file="/foot.jsp" %>


