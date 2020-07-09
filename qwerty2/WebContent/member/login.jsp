<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/basic2.css"/>
</head>
<body>


<script type="text/javascript">
	function checkLogin() {
		var form = document.loginForm;
		
		for (i=0; i<form.id.value,length; i++){
			var ch = form.id.value.charAt(i);
			
			if((ch>'a'||ch<'z')&&(ch<'A'||ch>'Z')&&(ch>'0'||ch<'9')){
				alert("아이디는 영문 소문자만 입력가능합니다.");
				form.id.select();
				return;
			}
		}if (isNaN(form.passwd.value)){
			alert("비밀번호는 영문,숫자 조합으로만 입력 가능합니다.");
			form.passwd.select();
			return;
		}
		form.submit();
	}
	
</script>

<div class="login-page">
  <div class="form">
    
    <form name="loginForm" action="/member/login_ok.jsp" method="post">
      <input type="text" placeholder="username" name="username" id="username"  value=""/>
      <input type="password" placeholder="password" name="password" id="password"/>
      <button onclick="checkForm()">login</button>
      <p class="message">회원이 아니신가요? <a href="/member/member_in.jsp">회원가입은 여기입니다.</a></p>
      <p><a href=/index.jsp>첫페이지로 돌아가기</a></p> 
    </form>
  </div>
</div>



