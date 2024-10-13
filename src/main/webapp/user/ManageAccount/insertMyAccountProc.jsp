<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
insertAccountProc.jsp<br>
<%
	request.setCharacterEncoding("UTF-8");
	MemberDao mdao = MemberDao.getInstance();
	String email3 = request.getParameter("email3");

%>

<jsp:useBean id="mb" class="member.MemberBean">
	<jsp:setProperty name="mb" property="*"/>
</jsp:useBean>

<%

	if(email3 != null) {
		mb.setEmail2(email3);
	}

	int cnt = mdao.insertMember(mb);
	System.out.println("<insertAccountProc.jsp> 성공 개수 : " + cnt);

	String msg;
	String url;
	
	if(cnt > 0) {
		msg = "insert 성공";
		url = "../../login/login.jsp";
	} else {
		msg = "insert 실패";
		url = "canIInsert.jsp";
	}
%>

<script type="text/javascript">
    alert("<%= msg %>");
    location.href = '<%= url %>';
</script> 