<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	MemberDao mdao = MemberDao.getInstance();
	Boolean flag = mdao.searchId(id);
	
	if(flag) {
		out.print("exist");
	} else {
		out.print("not exist");
	}



%>