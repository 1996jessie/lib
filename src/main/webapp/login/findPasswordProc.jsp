<%@page import="member.MemberBean"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
findPasswordProc.jsp<br>

<%
	request.setCharacterEncoding("UTF-8");
	String mname = request.getParameter("mname");
	String rrn1 = request.getParameter("rrn1");
	String rrn2 = request.getParameter("rrn2");
	String id = request.getParameter("id");
	
	System.out.println("<findPasswordProc.jsp> mname : " + mname + ", rrn1 : " + rrn1 + ", rrn2 : " + rrn2 + ", id : " + id);

	MemberDao mdao = MemberDao.getInstance();
	MemberBean mb = mdao.findId(mname, rrn1, rrn2);
	MemberBean mb2 = mdao.findPw(id, mname, rrn1, rrn2);
	
	String msg;
	String url;
	if(mb == null) {
		msg = "가입하지 않은 회원입니다.";
		url = "../user/ManageAccount/insertMyAccount.jsp?mname="+mname+"&rrn1="+rrn1+"&rrn2="+rrn2;
	} else if(mb2 == null){
		msg = "아이디가 일치하지 않습니다.";
		url = "login.jsp";
	} else {
		msg = mname+"님의 비밀번호는 "+mb2.getPassword()+"입니다.";
		url = "login.jsp";
	}
	
%>
	<script type="text/javascript">
		alert("<%= msg %>");
		location.href = "<%= url %>"
	</script> 