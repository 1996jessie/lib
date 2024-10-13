<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String mname = request.getParameter("mname");
	String rrn1 = request.getParameter("rrn1");
	String rrn2 = request.getParameter("rrn2");

	System.out.println("<canIInsertCheck.jsp> mname : " + mname + ", rrn1 : " + rrn1 + ", rrn2 : " + rrn2);
	MemberDao mdao = MemberDao.getInstance();
	
	boolean flag = mdao.canIInsert(mname, rrn1, rrn2);
	if(flag) {
		out.print("exist");
	}else {
		out.print("not exist");
	}
%>