<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	div {
		text-align:center;
		width:1100px;
		margin:auto;
	}
</style>
<script>
	function empnoCheck()
	{
		var empno=document.regForm.empno.value;
		var numberChk=/^[0-9]+$/;
		if(empno.match(numberChk)!=null)
		{
			var chk = new XMLHttpRequest();
			var url="empno_ok.jsp?empno="+empno;
		    	chk.open("get",url);
			    chk.send();
			    chk.onreadystatechange = function()
			    {
			       if(chk.readyState == 4)
			       {
			          if(chk.responseText.trim() == "1")
			          {
			              alert("이미 등록된 사원번호입니다");
			          }
			          else
			          {
			        	  alert("사용가능한 사원번호입니다");
			          }
			       }
			    }
		}
		else
		{
			alert("사원번호를 정확히 입력해주세요(3자리숫자)");
		}
	}
	function finalCheck(form)
	{
		var rank=document.regForm.rank.value;
		var name=document.regForm.name.value;
		var empno=document.regForm.empno.value;
		
		var phone1=document.regForm.phone1.value;
		var phone2=document.regForm.phone2.value;
		var phone3=document.regForm.phone3.value;
		var phone=phone1+"-"+phone2+"-"+phone3;
		
		var email1=document.regForm.email1.value;
		var email2=document.regForm.email2.value;
		var email=email1+"@"+email2;
		
		var charChk=/^[가-힣a-zA-Z]+$/;
		var numberChk=/^[0-9]+$/;
		var phoneChk=/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
		var emailChk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		if(name.match(charChk)==null)
		{
			alert("이름은 한글과 영어만 입력가능합니다");
			document.regForm.name.value="";
			return false;
		}
		else if(empno.match(numberChk)==null)
		{
			alert("사원번호는 3자리 숫자만 입력해주세요");
			document.regFrom.empno.value="";
			return false;
		}
		else if(phone.match(phoneChk)==null)
		{
			alert("전화번호를 정확히 입력해주세요");
			return false;
		}
		else if(email.match(emailChk)==null)
		{
			alert("email을 정확히 입력해주세요");
			return false;
		}
		else
		{		
			var chk = new XMLHttpRequest();
			var url="empno_ok.jsp?empno="+empno;
		    	chk.open("get",url);
			    chk.send();
			    chk.onreadystatechange = function()
			    {
			       if(chk.readyState == 4)
			       {
			          if(chk.responseText.trim() == "1")
			          {
			              alert("이미 등록된 사원번호입니다");
			              document.regForm.empno.value="";
			          }
			          else
			          {
			        	  form.submit();
			          }
			       }
			    }
		}
	}
</script>
</head>
<body>
	<div><h2>직원 등록</h2></div>
	<form method="post" action="reg_ok.jsp" name="regForm">
	<table width="700" align="center">
		<tr>
			<td>직원번호</td>
			<td><input type="text" name="empno" maxlength="3" required><button type="button" onclick="empnoCheck();">중복체크</button></td>
		</tr>
		<tr>
			<td>직급</td>
			<td><input type="text" name="rank" required></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="name" required></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td>
				<input type="text" name="phone1" maxlength="4" style="width:90px;" required>-
				<input type="text" name="phone2" maxlength="4" style="width:90px;" required>-
				<input type="text" name="phone3" maxlength="4" style="width:90px;" required>
			</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>
				<input type="text" name="email1" required>@
				<input type="text" name="email2" required>
			</td>
		</tr>
	</table>
	<div><input type="button" onclick="finalCheck(this.form)" value="등록"></div>
	</form>
	<a href="list.jsp">직원목록</a>
</body>
</html>