<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pin2.dao.PinDao"%>
<%
	PinDao pdao=new PinDao();
	pdao.reg_ok(request);
	response.sendRedirect("list.jsp");
%>