<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pin2.dao.PinDao" %>
<%@ page import="pin2.dto.PinDto" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	PinDao pdao=new PinDao();
	ArrayList<PinDto> list=pdao.list(request);
	pageContext.setAttribute("list", list);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#container {
		width:1100px;
		text-align:center;
		margin:auto;
	}
</style>
<script>
	function csvDown(fileName)
	{
		let downLink=document.getElementById("download");
		let csv="";
		let rows=document.querySelectorAll("#empDown tr");
		
		for(var i=0;i<rows.length;i++)
		{
			let cells=rows[i].querySelectorAll(".downtd");	
			let row=[];
			
			cells.forEach(function(cell)
			{
				row.push(cell.innerHTML);
			});
			
			csv+=row.join(',')+(i!=rows.length-1?'\n':'');
		}
		
		csvFile=new Blob(["\uFEFF"+csv],{type:"text/csv;charset=utf-8"});
		downLink.href=window.URL.createObjectURL(csvFile);
		downLink.download=fileName;
	}
</script>
</head>
<body>
	<div id="container">
		<h2>직원 목록</h2>
		<form method="post" action="list.jsp">
			<select name="stype">
				<option value="1">직원번호</option>
				<option value="2">직급</option>
				<option value="3">이름</option>
				<option value="4">전화번호</option>
				<option value="5">이메일</option>
			</select>
			<input type="text" name="search">
			<input type="submit" value="검색">
		</form>
		<table width="1000" align="center" id="empDown">
			<tr>
				<td class="downtd">직원번호</td>
				<td class="downtd">직급</td>
				<td class="downtd">이름</td>
				<td class="downtd">전화번호</td>
				<td class="downtd">이메일</td>
				<td colspan="2">정보수정</td>
			</tr>
			<c:forEach items="${list }" var="pdto">
				<tr>
					<td class="downtd"><fmt:formatNumber minIntegerDigits="3" value="${pdto.empno }"></fmt:formatNumber></td>
					<td class="downtd">${pdto.rank }</td>
					<td class="downtd">${pdto.name }</td>
					<td class="downtd">${pdto.phone }</td>
					<td class="downtd">${pdto.email }</td>
					<td><a href="update.jsp?empno=${pdto.empno }">수정</a></td>
					<td><a href="delete.jsp?empno=${pdto.empno }">삭제</a></td>
				</tr>
			</c:forEach>
		</table>
	<a href="reg.jsp">직원등록</a>
	<a href="" onclick="csvDown('data.csv')" id="download">csv다운로드</a>
	</div>
</body>
</html>