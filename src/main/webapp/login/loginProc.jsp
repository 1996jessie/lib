<%@page import="member.MemberBean"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
loginProc.jsp<br>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");

	System.out.println("<loginProc.jsp> id : " + id + ", password : " + password);

	MemberDao mdao = MemberDao.getInstance();
	MemberBean mb = mdao.memberCheck(id, password);
	

	
	String msg;
	String url;
	if(mb == null) {
		msg = "가입하지 않은 회원입니다.";
		url = "../user/ManageAccount/canIInsert.jsp";
	} else {
		msg = mb.getMname() + "님 환영합니다.";
		url = "../main.jsp?mname="+mb.getMname()+"&id="+id+"&mnum="+mb.getMnum();
		
		session.setAttribute("id", id);
		session.setAttribute("password", password);
		session.setAttribute("mname", mb.getMname());
		session.setAttribute("mnum", mb.getMnum());
	
	}
%>

	<script type="text/javascript">
		alert("<%= msg %>");
		location.href = "<%= url %>"
	</script> 
	
	
	
	
	
	