<%@page import="reserve.ReserveDao"%>
<%@page import="borrow.BorrowDao"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
deleteMemberByAdminProc.jsp<br>


<%
	int mnum = Integer.parseInt(request.getParameter("mnum"));
	System.out.println("<deleteMemberByAdminProc.jsp> mnum : " + mnum);

	MemberDao mdao = MemberDao.getInstance();
	BorrowDao brdao = BorrowDao.getInstance();
	ReserveDao rdao = ReserveDao.getInstance();
	
	boolean flag = brdao.checkCanAdminDeleteThisMember(mnum);
	/* boolean flag2 = rdao.checkBookCount(mnum); */
	String msg = null;
	String url = null;;
	
	if(flag == true) {
		msg = "대출중인 도서가 있는 회원은 제명할 수 없습니다.";
		url = "showMember.jsp";
	} else {
		int cnt = mdao.deleteMemberbyAdmin(mnum);

		if(cnt > 0) {
			msg = "delete Member by admin 성공";
			url = "showMember.jsp";			
		} else {
			msg = "delete Member by admin 실패";
			url = "showMember.jsp";
		}
	}
	
%>

	<script type="text/javascript">
		alert("<%= msg %>");
		location.href = "<%= url %>"
	</script> 