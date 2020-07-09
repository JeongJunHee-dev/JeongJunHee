<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/head.jsp" %>
    

<%
String sql = "select * from member3 where memberid = '"+session_id+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);//select

String id = "";
String pass = "";
String name = "";
String email = "";
String zipcode = "";
String add1 = "";
String add2 = "";
String add3 = "";
String add4 = "";
String phone = "";

if(rs.next()) {
	id = rs.getString("memberid");
	pass = rs.getString("memberpass");
	name = rs.getString("membername");
	email = rs.getString("email");
	zipcode = rs.getString("zipcode");
	add1 = rs.getString("addr1");
	add2 = rs.getString("addr2");
	add3 = rs.getString("addr3");
	add4 = rs.getString("addr4");
	phone = rs.getString("phone");
}

%>

    <script>
	function send(){
		if(document.member.id.value == ""){
			alert("아이디 입력해랏.");
			document.member.id.focus();
			return;
		}
		if(!document.member.name.value){
			alert("이름을 입력해랏.");
			document.member.name.focus();
			return;
		}
		document.member.submit();
	}
</script>

<table width=100%>
	<tr>
		<td align=center>회원수정</td>
	</tr>
</table>

<table width=600 align=center>
	<form name="member" action="member_update.jsp" method="post">
	<tr>
		<td>* 아이디</td>
		<td><input type="text" name="id" value="<%=id%>"readonly></td>
	</tr>
	<tr>
		<td>* 비밀번호</td>
		<td><input type="text" name="pass" value=""></td>
	</tr>
	<tr>
		<td>* 비밀번호 확인</td>
		<td><input type="text" name="pass1" value=""></td>
	</tr>
	<tr>
		<td>* 이름</td>
		<td><input type="text" name="name" value="<%=name%>"></td>
	</tr>
	<tr>
		<td>메일주소</td>
		<td><input type="text" name="email" value="<%=email%>"></td>
	</tr>
	<tr>
		<td>집주소</td>
		<td>
			<input type="text" name="zipcode" id="sample4_postcode" value="<%=zipcode%>">
			<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
		</td>
	</tr>
	<tr>
		<td></td>
		<td>
			<input type="text" name="addr1" id="sample4_roadAddress" value="<%=add1%>">
			<input type="text" name="addr2" id="sample4_jibunAddress" value="<%=add2%>">
			<span id="guide" style="color:#999;display:none"></span>
			<input type="text" name="addr3" id="sample4_detailAddress" value="<%=add3%>">
			<input type="text" name="addr4" id="sample4_extraAddress" value="<%=add4%>">
		</td>
	</tr>
	<tr>
		<td>연락처</td>
		<td><input type="text" name="phone" value="<%=phone%>" max="13"></td>
	</tr>
	</form>
	<tr>
		<td></td>
		<td><button onclick="send()">회원수정</button></td>
	</tr>
</table>


<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>