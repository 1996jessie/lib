<%@page import="member.MemberBean"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
findIdproc.jsp<br>
<%
	request.setCharacterEncoding("UTF-8");
	String mname = request.getParameter("mname");
	String rrn1 = request.getParameter("rrn1");
	String rrn2 = request.getParameter("rrn2");
	
	System.out.println("<findIdproc.jsp> mname : " + mname + ", rrn1 : " + rrn1 + ", rrn2 : " + rrn2);

	MemberDao mdao = MemberDao.getInstance();
	MemberBean mb = mdao.findId(mname, rrn1, rrn2);
	
	String msg;
	String url;
	if(mb == null) {
		msg = "가입하지 않은 회원입니다.";
		url = "../user/ManageAccount/insertMyAccount.jsp?mname="+mname+"&rrn1="+rrn1+"&rrn2="+rrn2;
	} else {
		msg = mname+"님의 아이디는 " + mb.getId()+"입니다.";
		url = "login.jsp";
	}
	
%>
	<script type="text/javascript">
		alert("<%= msg %>");
		location.href = "<%= url %>"
	</script> 